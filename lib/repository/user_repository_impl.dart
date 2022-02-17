import 'package:dio/dio.dart';
import 'package:flutter_base_response/data_models/daos/profile_ob.dart';
import 'package:flutter_base_response/data_models/daos/salon_item_ob.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';
import 'package:flutter_base_response/data_source/service/dio_service.dart';
import 'package:flutter_base_response/data_source/service/http_service.dart';
import 'package:flutter_base_response/repository/user_repository.dart';

import '../data_models/base_response/base_api_response.dart';

class UserRepositoryImpl extends UserRepository {
  final DioService _dioService = DioService();
  final HttpService _httpService = HttpService();

  @override
  Future<Map<String, dynamic>> loginUser(String phone, String password) async {
    try {
      Map<String, dynamic> map = {
        'phone': phone,
        'password': password,
      };
      final response =
          await _dioService.postRequest("user/user-login", data: map);
      // final response =
      //     await _httpService.request("user/user-login", Method.POST,params: map);
      return response;
      // if (response['status'] == true) {
      //   final parsedResponse = BaseApiResponse<UserOb>.fromObjectJson(response,
      //       createObject: (data) => UserOb.fromJson(data));
      //   return parsedResponse.objectResult;
      // } else {
      //   return null;
      // }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileOb> getProfile({String? token}) async {
    try {
      final response = await _dioService.getRequest("user/user-profile",
          options: Options(headers: {
            "Accept": "application/json",
            "Authorization": "Bearer" + token!
          }));
      final parsedResponse = BaseApiResponse<ProfileOb>.fromObjectJson(response,
          createObject: (data) => ProfileOb.fromJson(data));
      return parsedResponse.objectResult;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SalonItemOb>> getSalonList() async {
    try {
      final response =
          await _dioService.getRequest("user/salon-list?offset=10&name=");
      final parsedResponse = BaseApiResponse<SalonItemOb>.fromListJson(response,
          create: (data) => SalonItemOb.fromJson(data));
      return parsedResponse.listResult;
    } catch (e) {
      rethrow;
    }
  }
}
