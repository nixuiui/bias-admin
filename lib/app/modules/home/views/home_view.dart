import 'package:bias_admin/app/modules/home/controllers/home_controller.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/general.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Obx((() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NxText(
              controller.user.value?.name ?? ''
            ),
            NxText.small1(
              '(${AuthService.to.role.value})'
            ),
          ],
        ))),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: ListView(
          children: [
            NxBox(
              borderColor: AppColors.primary,
              color: AppColors.primary,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              borderRadius: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NxText(
                    'Balance', 
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  SizedBox(height: 6),
                  SizedBox(height: 6),
                  Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NxText(
                        rupiah(controller.user.value?.balance ?? 0),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      NxText(
                        '${controller.user.value?.sold} penjualan',
                        fontSize: 12,
                        color: Colors.white,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            ListTile(
              title: Text('Merchat'),
              leading: Icon(Icons.shopping_bag),
            ),
            ListTile(
              title: Text('Order'),
              leading: Icon(Icons.shopping_bag),
              onTap: () => Get.toNamed(Routes.order),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        child: NxButton(
          color: Colors.grey[200],
          onPressed: () => AuthService.to.logout(),
          padding: 14,
          child: NxText(
            'Logout', 
            color: AppColors.error,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}