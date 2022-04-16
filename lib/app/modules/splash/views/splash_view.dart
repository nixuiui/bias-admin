import 'package:bias_admin/app/modules/splash/controllers/splash_controller.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:bias_admin/services/config_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.init();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => NxText(
                  "${ConfigService.to.appVersion}",
                  color: Colors.white,
                )),
                SizedBox(height: 32),
                NxText(
                  'Splash Screen',
                  color: Colors.white,
                ),
              ],
            ),
            NxText(
              'Bias.id',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}