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
  
  Future<User?> withdraw({
    required String userId,
    required int balance,
    String? note,
  }) async {
    try {
      var url = '/${AuthService.to.role}/merchant-withdraw/$userId';
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
  
  Future<bool?> updatePassword({
    required String userId,
    required String password,
  }) async {
    try {
      var url = '/${AuthService.to.role}/merchant-password/$userId';
      await network.patch(
        url: url,
        data: {
          "password" : password
        }
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<User?> updateMerchant({
    required String userId,
    required String name,
    required String address,
    required String phoneNumber,
    required String username,
  }) async {
    try {
      var url = '/${AuthService.to.role}/merchant/$userId';
      final response = await network.patch(
        url: url,
        data:  {
          "name": name,
          "address": address,
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