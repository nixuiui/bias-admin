import 'package:bias_admin/app/models/division.dart';
import 'package:bias_admin/app/modules/division/repositories/division_repository.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/dialog_helper.dart';
import 'package:bias_admin/helpers/network/network_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DivisionController extends GetxController {
  static DivisionController get to => Get.find();

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    loadData();
    super.onInit();
  }

  final _divisionRepository = DivisionRepository();

  var page = 1;
  var limit = 20;
  var scrollThreshold = 200.0;
  var hasReachedMax = false;
  var isLoading = RxBool(false);
  final scrollController = ScrollController();
  var searchController = TextEditingController();

  final dataList = Rx<List<Division>>([]);

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
        (e) => Division.fromJson(e.toJson())
      ).toList();
      final response = await _divisionRepository.getList(
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
  
  // ----------------------------------------------------
  // UPDATE DIVISION
  // ----------------------------------------------------

  void deleteDivision(int index) async {
    var divisionId = dataList.value[index].id ?? '';
    dataList.value.removeAt(index);
    dataList.value = dataList.value.map(
      (e) => Division.fromJson(e.toJson())
    ).toList();
    try {
      await _divisionRepository.deleteDivision(id: divisionId);
    } catch (e) {
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }

  }


  // ----------------------------------------------------
  // FORM DIVISION
  // ----------------------------------------------------

  var division = Rx<Division?>(null);

  void openFormDivision() {
    division.value = null;
    Get.toNamed(Routes.divisionForm);
  }
  
  void openEditDivision(Division division) {
    this.division.value = division;
    Get.toNamed(Routes.divisionForm);
  }

  var nameController = TextEditingController();
  var name = Rx<String>('');
  var nameError = Rx<String>('');
  var updatingDivision = false.obs;

  void initForm() {
    nameController.text = division.value?.name ?? '';
    name.value = division.value?.name ?? '';
  }

  bool get isUpdateDivisionValid {
    var valid = true;

    nameError.value = '';

    if(name.value == '') {
      nameError.value = 'Nama lengkap harus diisi';
      valid = false;
    }

    return valid;
  }

  void saveDivision() {
    if(division.value != null) {
      updateDivision();
    } else {
      addDivision();
    }
  }

  void addDivision() async {
    try {
      updatingDivision.value = true;
      await _divisionRepository.postDivision(
        name: name.value,
      );
      updatingDivision.value = false;
      onRefresh();
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Data user berhasil diubah'
      );
      Get.back();
    } catch (e) {
      updatingDivision.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }
  
  void updateDivision() async {
    try {
      updatingDivision.value = true;
      await _divisionRepository.updateDivision(
        id: division.value!.id!,
        name: name.value,
      );
      onRefresh();
      await DialogHelper.showDialogSuccess(
        title: 'Berhasil',
        description: 'Data user berhasil diubah'
      );
      Get.back();
    } catch (e) {
      updatingDivision.value = false;
      DialogHelper.showDialogError(
        title: 'Terjadi Kesalahan',
        description: NetworkException.getErrorException(e).prefix
      );
    }
  }

}
