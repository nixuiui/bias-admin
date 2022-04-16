import 'package:bias_admin/app/modules/home/repositories/home_repository.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final _homeRepository = HomeRepository();
  final user = AuthService.to.user;

  final version = ''.obs;

  init() async {
    var packageInfo = await PackageInfo.fromPlatform();
    version.value = packageInfo.version;
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> onRefresh() async {
    await loadUser();
  }

  Future loadUser() async {
    try {
      user.value = await _homeRepository.getProfile();
    } catch (e) {
      print('error: $e');
    }
  }

}
