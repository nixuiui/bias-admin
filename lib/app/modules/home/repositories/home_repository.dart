import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:bias_admin/services/network_service.dart';

class HomeRepository {

  var network = NetworkService.to;

  Future<User?> getProfile() async {
    try {
      var url = '/${AuthService.to.role}/me';
      final response = await network.get(
        url: url
      );
      return User.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

}