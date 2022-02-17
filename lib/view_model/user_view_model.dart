import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';
import 'package:flutter_base_response/screens/salon_list_screen.dart';
import 'package:flutter_base_response/screens/user_profile_screen.dart';
import 'package:flutter_base_response/utils/app_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../cache/hive_helper.dart';
import '../data_models/base_response/api_response.dart';
import '../data_models/base_response/base_api_response.dart';
import '../data_models/daos/profile_ob.dart';
import '../data_models/daos/salon_item_ob.dart';
import '../exception/exception.dart';
import '../repository/user_repository_impl.dart';
import '../utils/setup_locator.dart';

class UserViewModel with ChangeNotifier {
  var repository = locator<UserRepositoryImpl>();
  final tokenBox = Hive.box<String>(HiveHelper.tokenName);

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  ProfileOb? profileOb;
  UserOb? userOb;
  List<SalonItemOb> salonList = [];

  Future<void> loginUser(
      BuildContext context, String phone, String password) async {
    AppUtils.showLoaderDialog(context);
    notifyListeners();
    try {
      final response = await repository.loginUser(phone, password);
      Navigator.pop(context);
        if(response['status']){
          final parsedResponse = BaseApiResponse<UserOb>.fromObjectJson(response,
              createObject: (data) => UserOb.fromJson(data));
          userOb = parsedResponse.objectResult;
          tokenBox.put(HiveHelper.tokenKey, userOb!.token);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SalonListScreen()),
          );
        }else {
          Fluttertoast.showToast(
              msg: "UserName or Password is incorrect and ${response['status']}");
        }
    } on DioError catch (dioError) {
      final error = DioExceptions.fromDioError(dioError).toString();
      Fluttertoast.showToast(msg: error);
      Navigator.pop(context);
    }
    notifyListeners();
  }

  Future<void> getProfile(
    BuildContext context,
  ) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      profileOb = await repository.getProfile(token: HiveHelper.getToken());
      _apiResponse = ApiResponse.completed(profileOb);
      print("Profile name is ${profileOb!.name}");
    } on DioError catch (dioError) {
      final error = DioExceptions.fromDioError(dioError).toString();
      print("Profile Error is  $error");
      _apiResponse = ApiResponse.error(error);
      Fluttertoast.showToast(msg: _apiResponse.message!);
    }
    notifyListeners();
  }

  Future<void> getSalonList() async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      salonList = await repository.getSalonList();
      _apiResponse = ApiResponse.completed(salonList);
      print("SalonList is ${salonList.length}");
    } on DioError catch (dioError) {
      final error = DioExceptions.fromDioError(dioError).toString();
      print("SalonList Error is  $error");
      _apiResponse = ApiResponse.error(error);
      Fluttertoast.showToast(msg: _apiResponse.message!);
    }
    notifyListeners();
  }
}
