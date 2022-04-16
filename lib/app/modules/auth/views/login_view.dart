import 'package:bias_admin/app/modules/auth/controllers/auth_controller.dart';
import 'package:bias_admin/resources/colors.dart';
import 'package:bias_admin/services/config_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nx_flutter_ui_starter_pack/nx_flutter_ui_starter_pack.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
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
                      fontWeight: FontWeight.w900,
                      lineHeight: 1.5,
                    ),
                    SizedBox(height: 8),
                    NxText(
                      'Silahkan Masuk',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.5,
                    ),
                    SizedBox(height: 40),
                    _buildRoleOptions(),
                    SizedBox(height: 20),
                    _buildLoginForm(),
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

  Widget _buildRoleOptions() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => NxBox(
            borderRadius: 8,
            borderColor: controller.role.value == 'admin' ? AppColors.primary : Colors.black26,
            padding: EdgeInsets.all(16),
            onPressed: () => controller.role.value = 'admin',
            child: NxText(
              'ADMIN',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              color: controller.role.value == 'admin' ? AppColors.primary : Colors.black26,
            ),
          )),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Obx(() => NxBox(
            borderRadius: 8,
            borderColor: controller.role.value == 'merchant' ? AppColors.primary : Colors.black26,
            padding: EdgeInsets.all(16),
            onPressed: () => controller.role.value = 'merchant',
            child: NxText(
              'MERCHANT',
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              color: controller.role.value == 'merchant' ? AppColors.primary : Colors.black26,
            ),
          )),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        Obx(() => NxTextFieldBox(
          textHint: 'Masukan Username',
          borderRadius: 12,
          padding: 14,
          prefix: Icon(Icons.email, color: Colors.grey),
          controller: controller.emailController,
          textError: controller.emailError.value,
        )),
        SizedBox(height: 20),
        Obx(() => NxTextFieldBox(
          textHint: 'Masukan Password',
          borderRadius: 12,
          padding: 14,
          prefix: Icon(Icons.lock, color: Colors.grey),
          controller: controller.passwordController,
          textError: controller.passwordError.value,
          isObsecure: true,
        )),
        SizedBox(height: 28),
        Obx(() => NxButton.primary(
          child: NxText(
            'Login',
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          padding: 14,
          fontSize: 16,
          onPressed: controller.loading.value ? null : () => controller.login(),
          isLoading: controller.loading.value,
        )),
      ],
    );
  }
}