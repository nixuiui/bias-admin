import 'package:bias_admin/app/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageKeys {
  static const String username = 'username';
  static const String token = 'token';
  static const String user = 'user';
}

class LocalStorageService extends GetxService{
  static LocalStorageService get to => Get.find();

  late GetStorage box;

  LocalStorageService() : box = GetStorage();

  Future<String?> get username async {
    final username = box.read(LocalStorageKeys.username);
    return username;
  }

  Future setUsername(String? username) async {
    box.write(LocalStorageKeys.username, username);
  }

  Future<String?> get token async {
    final token = box.read(LocalStorageKeys.token);
    return token;
  }

  Future setToken(String? token) async {
    box.write(LocalStorageKeys.token, token);
  }
  
  Future<User?> get user async {
    final user = box.read<String>(LocalStorageKeys.user);
    if(user != null) {
      return userFromJson(user);
    }
    return null;
  }

  Future setUser(User? data) async {
    box.write(LocalStorageKeys.user, data != null ? userToJson(data) : null);
  }

}
