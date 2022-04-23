import 'package:bias_admin/app/modules/division/controllers/division_controller.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class DivisionView extends GetView<DivisionController> {
  
  const DivisionView({ 
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
            'List Divisi',
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
                          title: GestureDetector(
                            onTap: () => controller.openEditDivision(controller.dataList.value[index]),
                            behavior: HitTestBehavior.translucent,
                            child: NxText(
                              controller.dataList.value[index].name ?? '-',
                              color: Colors.black,
                              lineHeight: 1.5,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () => controller.deleteDivision(index), 
                            icon: Icon(Icons.delete)
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
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: NxButton.primary(
                child: NxText(
                  'Tambah Divisi',
                  color: Colors.white,
                ),
                onPressed: () => Get.toNamed(Routes.divisionForm),
              ),
            ),
          ],
        ),
      ),
    );
  }

}