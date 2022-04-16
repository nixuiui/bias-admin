import 'package:bias_admin/app/modules/user/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class UserView extends GetView<UserController> {
  
  const UserView({ 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'List User',
          )
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: NxTextFieldBox(
                backgroundColor: Colors.grey[100],
                borderRadius: 50,
                suffix: Icon(Icons.search),
                textHint: 'Cari disini',
                controller: controller.searchController,
                onFieldSubmitted: (val) => controller.onRefresh(),
                suffixClicked: controller.onRefresh,
              ),
            ),
            Divider(),
            Expanded(
              child: RefreshIndicator(
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
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NxText(
                                controller.dataList.value[index].name ?? '-',
                                color: Colors.black,
                                fontSize: 16,
                                lineHeight: 1.5,
                              ),
                              SizedBox(height: 4),
                              NxText(
                                '+${controller.dataList.value[index].phoneNumber}',
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.chevron_right),
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
            ),
          ],
        ),
      ),
    );
  }

}