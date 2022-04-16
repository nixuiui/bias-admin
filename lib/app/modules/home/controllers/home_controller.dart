import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final authService = AuthService.to;

  final version = ''.obs;

  init() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    await Future.delayed(Duration(seconds: 2));
    checkUserState();
  }

  checkUserState() {
    if(authService.isLoggedIn.value) {
      Get.offNamed(Routes.home);
    } else {
      Get.offNamed(Routes.login);
    }
  }

}
