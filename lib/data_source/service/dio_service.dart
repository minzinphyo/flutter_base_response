import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base_response/data_models/base_response/api_response.dart';

import '../../exception/api_exception.dart';

class DioService{
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getRequest(String url) async {
    dynamic responseJson;
    try{
      final response = await _dio.get("https://gist.githubusercontent.com/$url");
      responseJson =  returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.toString());
        return responseJson;
      case 400:
        print("400 Error is occurred and ${response.data}");
        throw BadRequestException(response.data);
      case 401:
      case 403:
        throw UnauthorisedException(response.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

}