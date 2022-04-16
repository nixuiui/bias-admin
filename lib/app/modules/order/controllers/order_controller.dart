import 'package:bias_admin/app/models/order.dart';
import 'package:bias_admin/app/modules/order/repositories/order_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();

  @override
  void onInit() {
    scrollController.addListener(_onScroll);
    loadData();
    super.onInit();
  }

  final _orderRepository = OrderRepository();

  var page = 1;
  var limit = 20;
  var scrollThreshold = 200.0;
  var hasReachedMax = false;
  var isLoading = RxBool(false);
  final scrollController = ScrollController();
  var searchController = TextEditingController();

  final dataList = Rx<List<Order>>([]);

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
        (e) => Order.fromJson(e.toJson())
      ).toList();
      final response = await _orderRepository.getList(
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

}
