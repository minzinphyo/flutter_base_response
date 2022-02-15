import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';
import 'package:flutter_base_response/screens/user_profile_screen.dart';
import 'package:flutter_base_response/utils/app_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../data_models/base_response/api_response.dart';
import '../exception/exception.dart';
import '../repository/user_repository_impl.dart';
import '../utils/setup_locator.dart';

class UserViewModel with ChangeNotifier {
  var repository = locator<UserRepositoryImpl>();

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response => _apiResponse;

  UserOb userOb;

  Future<void> loginUser(
      BuildContext context, String phone, String password) async {
    AppUtils.showLoaderDialog(context);
    notifyListeners();
    try {
      userOb = await repository.loginUser(phone, password);
      Navigator.pop(context);
      userOb != null
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfileScreen(userOb)),
            )
          : Fluttertoast.showToast(msg: "UserName or Password is incorrect");
    } on DioError catch (dioError) {
      final error = DioExceptions.fromDioError(dioError).toString();
      Fluttertoast.showToast(msg: error);
      Navigator.pop(context);
    }
    notifyListeners();
  }
}
