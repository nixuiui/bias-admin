import 'package:bias_admin/app/modules/user/controllers/user_topup_controller.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class UserTopupView extends GetView<UserTopupController> {
  
  const UserTopupView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Riwayat Topup User',
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
                itemBuilder: (contextn, index) => ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  minVerticalPadding: 0,
                  dense: true,
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NxText(
                              controller.dataList.value[index].user?.name ?? '-',
                              color: Colors.black,
                              lineHeight: 1.5,
                            ),
                            SizedBox(height: 4),
                            NxText(
                              'Catatan: ${controller.dataList.value[index].note ?? 'tidak ada'}',
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ],
                        ),
                      ),
                      NxText.lead2(
                        rupiah(controller.dataList.value[index].balance),
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