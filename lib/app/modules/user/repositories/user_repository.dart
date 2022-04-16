import 'dart:convert';

import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:bias_admin/services/network_service.dart';

class UserRepository {

  var network = NetworkService.to;

  Future<List<User>?> getList({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      var url = '/${AuthService.to.role}/users';
      final response = await network.get(
        url: url,
        parameters: {
          'page': page,
          'limit': limit,
          'search': search,
        }
      );
      return userListFromJson(
        json.encode(response.data['data']['user'])
      );
    } catch (e) {
      rethrow;
    }
  }

}