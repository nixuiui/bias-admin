import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/app/routes/app_pages.dart';
import 'package:bias_admin/services/local_storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final localStorage = LocalStorageService.to;

  AuthService() {
    init();
  }

  init() async {
    final username = await localStorage.username;
    final token = await localStorage.token;
    final user = await localStorage.user;
    final role = await localStorage.role;
    this.username = Rx<String?>(username);
    this.token = Rx<String?>(token);
    this.user = Rx<User?>(user);
    this.role = Rx<String?>(role);
    isLoggedIn.value = token != null;
  }

  var isLoggedIn = false.obs;
  late Rx<String?> username;
  late Rx<String?> token;
  late Rx<User?> user;
  late Rx<String?> role;

  void setUsername(String? data) async {
    await LocalStorageService.to.setUsername(data);
    username = Rx<String?>(data);
  }

  void setToken(String? data) async {
    await LocalStorageService.to.setToken(data);
    token = Rx<String?>(data);
  }

  void setUser(User? data) async {
    await LocalStorageService.to.setUser(data);
    user = Rx<User?>(data);
  }
  
  void setRole(String? data) async {
    await LocalStorageService.to.setRole(data);
    role = Rx<String?>(data);
  }

  void logout() async {
    localStorage.setToken(null);
    localStorage.setUser(null);
    Get.offAndToNamed(Routes.login);
  }
}
