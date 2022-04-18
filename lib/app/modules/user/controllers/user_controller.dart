import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/app/modules/user/repositories/user_repository.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/dialog_helper.dart';
import 'package:bias_admin/helpers/network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    loadData();
    super.onInit();
  }

  final _userRepository = UserRepository();

  var page = 1;
  var limit = 20;
  var scrollThreshold = 200.0;
  var hasReachedMax = false;
  var isLoading = RxBool(false);
  final scrollController = ScrollController();
  var searchController = TextEditingController();

  final dataList = Rx<List<User>>([]);

  void _onScroll() async {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    loadDataList(
      loadMore: true, 
      maxScroll: maxScroll, 
      currentScroll: currentScroll
    );
  }

  onRefresh() {
    page = 1;
    loadData();
  }

  loadDataList({
    bool refresh = false,
    bool loadMore = false,
    double maxScroll = 0,
    double currentScroll = 0,
  }) async {
    if(refresh) {
      hasReachedMax = false;
      await loadData();
    } else if(loadMore) {
      if (
        (maxScroll - currentScroll) <= scrollThreshold && 
        !hasReachedMax && 
        !isLoading.value
      ) {
        isLoading.value = false;
        await loadData();
      }
    }
  }

  loadData() async {
    isLoading.value = true;
    try {
      if(page == 1) {
      }
      var currentData = dataList.value.map(
        (e) => User.fromJson(e.toJson())
      ).toList();
      final response = await _userRepository.getList(
        page: page, 
        limit: limit, 
        search: searchController.text,
      );
      if(page == 1) {
        dataList.value = response ?? [];
      } else {
        currentData.addAll(response ?? []);
        dataList.value = currentData;
      }
      updatePage();
    } catch (err) {
      Get.snackbar('Error', '$err');
    }
    isLoading.value = false;
  }

  void updatePage() {
    var length = dataList.value.length;
    if(length%limit > 0) {
      hasReachedMax = true;
    } else {
      page = (length/limit).ceil() + 1;
    }
  }

  var user = Rx<User?>(null);

  void openDetail(User user) {
    this.user.value = user;
    Get.toNamed(Routes.userDetail);
  }

  var balanceController = TextEditingController();
  var balance = Rx<int?>(null);
  var balanceNoteController = TextEditingController();
  var balanceNote = Rx<String?>(null);
  var updatingBalance = false.obs;

  bool get isUpdateBalanceValid {
    var valid = true;

    if((balance.value ?? 0) <= 0) valid = false;

    return valid;
  }

  void updateBalanace() async {
    try {
      updatingBalance.value = true;
      final response = await _userRepository.updateBalance(
        balance: balance.value!, 
        note: balanceNote.value, 
        userId: user.value!.id!
      );
      updatingBalance.value = false;
      user.value = response;
      var userIndex = dataList.value.indexWhere((e) => e.id == user.value?.id);
      if(userIndex > -1) {
        dataList.value[userIndex] = user.value!;
      }
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Saldo berhasil ditambah ke ${user.value?.name}'
      );
      Get.back();
    } catch (e) {
      updatingBalance.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }

}
