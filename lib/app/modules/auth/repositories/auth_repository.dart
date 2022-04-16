import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/services/network_service.dart';

class AuthRepository {

  var network = NetworkService.to;

  Future<User?> login({
    required String role,
    required String email,
    required String password,
  }) async {
    try {
      var url = '/$role/login';
      final response = await network.post(
        url: url, 
        data: {
          "emailOrUsername": email,
          "email": email,
          "password": password,
        }
      );
      print('response: ${response.data["data"]}');
      print('response user: ${User.fromJson(response.data['data']).toJson()}');
      return User.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

}