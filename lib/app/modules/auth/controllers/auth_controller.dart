import 'package:bias_admin/app/modules/auth/repositories/auth_repository.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/helpers/dialog_helper.dart';
import 'package:bias_admin/helpers/network/network_exceptions.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final authRepository = AuthRepository();

  final role = 'admin'.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  final emailError = ''.obs;
  final passwordError = ''.obs;

  final loading = false.obs;

  AuthController() {
    debugPrint('AuthController:: AuthController()');
    emailController.text = AuthService.to.username.value ?? '';
    role.value = AuthService.to.role.value ?? 'admin';
  }

  bool isValid() {
    var isValid = true;
    emailError.value = '';
    passwordError.value = '';

    if(emailController.text == '') {
      isValid = false;
      emailError.value = 'Username harus diisi';
    }
    
    if(passwordController.text == '') {
      isValid = false;
      passwordError.value = 'Password harus diisi';
    }

    return isValid;
  }

  void login() async {
    if(isValid()) {
      try {
        loading.value = true;
        final response = await authRepository.login(
          role: role.value,
          email: emailController.text, 
          password: passwordController.text, 
        );
        AuthService.to.setUsername(emailController.text);
        AuthService.to.setToken(response?.token);
        AuthService.to.setUser(response);
        AuthService.to.setRole(role.value);
        Get.offNamed(Routes.home);
      } catch (e) {
        loading.value = false;
        print('erroe: $e');
        DialogHelper.showDialogError(
          title: 'Terjadi Kesalahan',
          description: NetworkException.getErrorException(e).prefix,
        );
      } 
    }
  }

}
