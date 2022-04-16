import 'package:bias_admin/app/modules/auth/controllers/auth_controller.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:bias_admin/services/config_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_checkbox.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class LoginView extends StatelessWidget {
  const LoginView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AuthController());

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Container(
          padding: EdgeInsets.all(40),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NxText(
                      'Login',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      lineHeight: 1.5,
                    ),
                    SizedBox(height: 8),
                    NxText(
                      'Silahkan Masuk',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      lineHeight: 1.5,
                    ),
                    SizedBox(height: 40),
                    NxText.lead1(
                      'Username',
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Obx(() => NxTextFieldBox(
                      textHint: 'Masukan Username',
                      backgroundColor: AppColors.bgInputBlack,
                      borderColor: AppColors.bgInputBlack,
                      textColor: Colors.white,
                      borderRadius: 12,
                      padding: 14,
                      prefix: Icon(Icons.email, color: Colors.white),
                      controller: controller.emailController,
                      textError: controller.emailError.value,
                    )),
                    SizedBox(height: 20),
                    NxText.lead1(
                      'Password',
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Obx(() => NxTextFieldBox(
                      textHint: 'Masukan Password',
                      backgroundColor: AppColors.bgInputBlack,
                      borderColor: AppColors.bgInputBlack,
                      textColor: Colors.white,
                      borderRadius: 12,
                      padding: 14,
                      prefix: Icon(Icons.lock, color: Colors.white),
                      controller: controller.passwordController,
                      textError: controller.passwordError.value,
                      isObsecure: true,
                    )),
                    SizedBox(height: 28),
                    Obx(() => NxButton(
                      color: Colors.white,
                      borderColor: Colors.white,
                      child: NxText(
                        'Login',
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      padding: 14,
                      fontSize: 16,
                      textColor: AppColors.primary,
                      onPressed: controller.loading.value ? null : () => controller.login(),
                      isLoading: controller.loading.value,
                    )),
                    SizedBox(height: 24),
                    NxCheckbox(
                      child: NxText(
                        'Mode Trial', 
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      checked: false,
                      size: 12,
                      borderRadius: 2,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Obx(() => NxText(
                "${ConfigService.to.appVersion}",
                color: Colors.white,
              )),
            ],
          ),
        ),
      ),
    );
  }
}