import 'package:bias_admin/app/modules/order/controllers/order_controller.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class OrderView extends GetView<OrderController> {
  
  const OrderView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order',
        )
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onRefresh(),
        child: Obx(() {
          return ListView(
            controller: controller.scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.dataList.value.length,
                separatorBuilder: (contextn, index) => Divider(height: 0), 
                itemBuilder: (contextn, index) => Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NxText(
                              controller.dataList.value[index].note ?? '-',
                              color: Colors.black,
                              fontSize: 16,
                              lineHeight: 1.5,
                            ),
                            SizedBox(height: 4),
                            NxText(
                              controller.dataList.value[index].transactionCode ?? '-',
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Icons.store, 
                                  size: 12, 
                                  color: Colors.grey
                                ),
                                SizedBox(width: 4),
                                NxText.small1(
                                  controller.dataList.value[index].merchant?.name ?? '-',
                                  color: Colors.grey
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.person, 
                                  size: 12, 
                                  color: Colors.grey
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: NxText.small1(
                                    controller.dataList.value[index].user?.name ?? '-',
                                    color: Colors.grey,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      NxText.lead1(
                        rupiah(controller.dataList.value[index].totalBuy),
                        color: Colors.green,
                      )
                    ],
                  ),
                ), 
              ),
              if(controller.isLoading.value) Container(
                padding: EdgeInsets.all(16),
                child: Center(child: NxLoadingSpinner())
              ),
              SizedBox(height: 32)
            ],
          );
        }),
      ),
    );
  }

}