import 'dart:convert';

import 'package:bias_admin/app/models/withdraw.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:bias_admin/services/network_service.dart';

class MerchantRepository {

  var network = NetworkService.to;

  Future<List<Withdraw>?> getList({
    int page = 1,
    int limit = 20
  }) async {
    try {
      var url = '/${AuthService.to.role}/withdraw';
      final response = await network.get(
        url: url,
        parameters: {
          'page': page,
          'limit': limit,
        }
      );
      return withdrawFromJson(
        json.encode(response.data['data']['withdraw'])
      );
    } catch (e) {
      rethrow;
    }
  }

}