import 'dart:convert';

import 'package:bias_admin/app/models/topup.dart';
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
  
  Future<List<Topup>?> getListUserTopup({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    try {
      var url = '/${AuthService.to.role}/users/topup';
      final response = await network.get(
        url: url,
        parameters: {
          'page': page,
          'limit': limit,
          'search': search,
        }
      );
      return topupFromJson(
        json.encode(response.data['data']['topup'])
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

  Future<bool> deactiveUser({
    required String userId,
    required bool isActive,
  }) async {
    try {
      var url = '/${AuthService.to.role}/user-deactive/$userId';
      await network.patch(
        url: url,
        data:  {
          "isActive" : isActive
        }
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

}