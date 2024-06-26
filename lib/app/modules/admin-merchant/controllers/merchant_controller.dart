import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/dialog_helper.dart';
import 'package:bias_admin/helpers/network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repositories/merchant_repository.dart';

class MerchantController extends GetxController {
  static MerchantController get to => Get.find();

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    loadData();
    super.onInit();
  }

  final _merchantRepository = MerchantRepository();

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
      final response = await _merchantRepository.getList(
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

  var merchant = Rx<User?>(null);

  void openDetail(User merchant) {
    this.merchant.value = merchant;
    Get.toNamed(Routes.merchantDetail);
  }

  // ----------------------------------------------------
  // UPDATE SALDO USER
  // ----------------------------------------------------

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

  void withdraw() async {
    try {
      updatingBalance.value = true;
      final response = await _merchantRepository.withdraw(
        balance: balance.value!, 
        note: balanceNote.value, 
        userId: merchant.value!.id!
      );
      updatingBalance.value = false;
      merchant.value = response;
      var merchantIndex = dataList.value.indexWhere((e) => e.id == merchant.value?.id);
      if(merchantIndex > -1) {
        dataList.value[merchantIndex] = merchant.value!;
      }
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Saldo berhasil ditambah ke ${merchant.value?.name}'
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


  // ----------------------------------------------------
  // UPDATE PASSWORD MERCHANT
  // ----------------------------------------------------

  var passwordController = TextEditingController();
  var password = Rx<String>('');
  var passwordError = Rx<String>('');
  var updatingPassword = false.obs;

  bool get isUpdatePasswordValid {
    var valid = true;

    if(password.value == '') valid = false;

    return valid;
  }

  void updatePassword() async {
    try {
      updatingPassword.value = true;
      await _merchantRepository.updatePassword(
        password: password.value,
        userId: merchant.value!.id!
      );
      updatingPassword.value = false;
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Password berhasil diubah'
      );
      Get.back();
    } catch (e) {
      updatingPassword.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }
  
  // ----------------------------------------------------
  // UPDATE USER
  // ----------------------------------------------------

  var nameController = TextEditingController();
  var name = Rx<String>('');
  var nameError = Rx<String>('');
  var addressController = TextEditingController();
  var address = Rx<String>('');
  var addressError = Rx<String>('');
  var phoneNumberController = TextEditingController();
  var phoneNumber = Rx<String>('');
  var phoneNumberError = Rx<String>('');
  var usernameController = TextEditingController();
  var username = Rx<String>('');
  var usernameError = Rx<String>('');
  var updatingUser = false.obs;

  void openFormMerchant() {
    merchant.value = null;
    Get.toNamed(Routes.merchantUpdate);
  }

  void initUpdateUserForm() {
    nameController.text = merchant.value?.name ?? '';
    name.value = merchant.value?.name ?? '';
    addressController.text = merchant.value?.address ?? '';
    address.value = merchant.value?.address ?? '';
    phoneNumberController.text = merchant.value?.phoneNumber ?? '';
    phoneNumber.value = merchant.value?.phoneNumber ?? '';
    usernameController.text = merchant.value?.userName?? '';
    username.value = merchant.value?.userName?? '';
    passwordController.text = '';
    password.value = '';
  }

  bool get isUpdateUserValid {
    var valid = true;
    
    if(name.value == '') {
      nameError.value = 'Nama lengkap harus diisi';
      valid = false;
    }
    if(address.value == '') {
      addressError.value = 'Divisi harus diisi';
      valid = false;
    }
    if(phoneNumber.value == '') {
      phoneNumberError.value = 'No hp harus diisi';
      valid = false;
    }
    if(username.value == '') {
      usernameError.value = 'Username harus diisi';
      valid = false;
    }
    if(password.value == '') {
      passwordError.value = 'Password harus diisi';
      valid = false;
    }

    return valid;
  }

  void saveMerchant() {
    if(merchant.value == null) {
      postMerchant();
    } else {
      updateMerchant();
    }
  }

  void postMerchant() async {
    try {
      updatingUser.value = true;
      await _merchantRepository.postMerchant(
        name: name.value,
        address: address.value,
        phoneNumber: phoneNumber.value,
        username: username.value,
        password: password.value,
      );
      updatingUser.value = false;
      onRefresh();
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Data merchant berhasil diubah'
      );
      Get.back();
    } catch (e) {
      updatingUser.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }
  
  void updateMerchant() async {
    try {
      updatingUser.value = true;
      final response = await _merchantRepository.updateMerchant(
        userId: merchant.value!.id!,
        name: name.value,
        address: address.value,
        phoneNumber: phoneNumber.value,
        username: username.value,
      );
      updatingUser.value = false;
      merchant.value = response;
      var userIndex = dataList.value.indexWhere((e) => e.id == merchant.value?.id);
      if(userIndex > -1) {
        dataList.value[userIndex] = merchant.value!;
      }
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Data merchant berhasil diubah'
      );
      Get.back();
    } catch (e) {
      updatingUser.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }

}
