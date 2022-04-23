import 'dart:convert';

import 'package:bias_admin/app/models/division.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:bias_admin/services/network_service.dart';

class DivisionRepository {

  var network = NetworkService.to;

  Future<List<Division>?> getList({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      var url = '/${AuthService.to.role}/division';
      final response = await network.get(
        url: url,
        parameters: {
          'page': page,
          'limit': limit,
          'search': search,
        }
      );
      return divisionListFromJson(
        json.encode(response.data['data']['division'])
      );
    } catch (e) {
      rethrow;
    }
  }
  
  Future<bool?> postDivision({
    required String name,
  }) async {
    try {
      var url = '/${AuthService.to.role}/division';
      await network.post(
        url: url,
        data:  {
          "name": name,
        }
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> updateDivision({
    required String id,
    required String name,
  }) async {
    try {
      var url = '/${AuthService.to.role}/division/$id';
      await network.patch(
        url: url,
        data:  {
          "name": name,
        }
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<bool?> deleteDivision({
    required String id
  }) async {
    try {
      var url = '/${AuthService.to.role}/division/$id';
      await network.delete(
        url: url,
        parameters: {}
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

}