import 'dart:convert';

import 'package:bias_admin/app/models/user.dart';
import 'package:bias_admin/app/models/withdraw.dart';
import 'package:bias_admin/services/auth_service.dart';
import 'package:bias_admin/services/network_service.dart';

class MerchantRepository {

  var network = NetworkService.to;

  Future<List<User>?> getList({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      var url = '/${AuthService.to.role}/merchant';
      final response = await network.get(
        url: url,
        parameters: {
          'page': page,
          'limit': limit,
          'search': search,
        }
      );
      return userListFromJson(
        json.encode(response.data['data']['merchant'])
      );
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<Withdraw>?> getWithdrawHistory({
    int page = 1,
    int limit = 20
  }) async {
    try {
      var url = '/${AuthService.to.role}/merchant-withdraw';
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
  
  Future<User?> updateBalance({
    required String userId,
    required int balance,
    String? note,
  }) async {
    try {
      var url = '/${AuthService.to.role}/user-balance/$userId';
      final response = await network.patch(
        url: url,
        data: {
          "balance" : balance,
          "note" : note
        }
      );
      return userFromJson(
        json.encode(response.data['data'])
      );
    } catch (e) {
      rethrow;
    }
  }
  
  Future<User?> updatePassword({
    required String userId,
    required String password,
  }) async {
    try {
      var url = '/${AuthService.to.role}/user-password/$userId';
      final response = await network.patch(
        url: url,
        data: {
          "password" : password
        }
      );
      return userFromJson(
        json.encode(response.data['data'])
      );
    } catch (e) {
      rethrow;
    }
  }
  
  Future<User?> updateUser({
    required String userId,
    required String fullName,
    required String division,
    required String phoneNumber,
    required String username,
  }) async {
    try {
      var url = '/${AuthService.to.role}/user/$userId';
      final response = await network.patch(
        url: url,
        data:  {
          "fullName": fullName,
          "division": division,
          "phoneNumber": phoneNumber,
          "userName": username
        }
      );
      return userFromJson(
        json.encode(response.data['data'])
      );
    } catch (e) {
      rethrow;
    }
  }

}