import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  final authService = AuthService.to;

  final version = ''.obs;

  init() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    await Future.delayed(Duration(seconds: 2));
    checkUserState();
  }

  checkUserState() async {
    try {
      if(authService.isLoggedIn.value) {
        await Get.offNamed(Routes.home);
      } else {
        await Get.offNamed(Routes.login);
      }
    } catch (e) {
      print(e);
    }
  }

}
