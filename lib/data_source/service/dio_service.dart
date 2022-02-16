import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_base_response/cache/hive_helper.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';
import 'package:flutter_base_response/data_source/network/logging_iterceptor.dart';
import '../../exception/api_exception.dart';

class DioService {

  // BaseOptions options =  BaseOptions(
  //   headers: {
  //     "Content-Type": Headers.jsonContentType,
  //   },
  //   // contentType: 'application/vnd.api+json',
  //   //baseUrl: "https://gist.githubusercontent.com/",
  //   //baseUrl: "https://api-hlapa.yeyintaung.com/",
  //   connectTimeout: 10000,
  //   receiveTimeout: 5000,
  // );

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getRequest(
    String url, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    dynamic responseJson;
    try {
      final response = await _dio.get(
        "https://api-hlapa.yeyintaung.com/" + url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      String token = HiveHelper.getToken();
      BaseOptions options = token != null ?  BaseOptions(
        headers: {
          "Content-Type": Headers.jsonContentType,
          "Authorization": "Bearer " + token
        },
        // contentType: 'application/vnd.api+json',
        //baseUrl: "https://gist.githubusercontent.com/",
        //baseUrl: "https://api-hlapa.yeyintaung.com/",
        connectTimeout: 10000,
        receiveTimeout: 5000,
      ) : BaseOptions(
        headers: {
          "Content-Type": Headers.jsonContentType,
        },
        connectTimeout: 10000,
        receiveTimeout: 5000,
      );
      Dio(options).interceptors.add(LoggingInterceptor());
      print("TOKEN Bearer $token");
      responseJson = returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> postRequest(
    String uri, {
    data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onSendProgress,
    ProgressCallback onReceiveProgress,
  }) async {
    dynamic responseJson;
    try {
      final response = await _dio.post(
        "https://api-hlapa.yeyintaung.com/" + uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      //Dio(options).interceptors.add(LoggingInterceptor());
      responseJson = returnResponse(response);
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
