import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base_response/data_source/network/logging_iterceptor.dart';

import '../../exception/api_exception.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

//const BASE_URL = "https://fakestoreapi.com/";

const BASE_URL = "https://api-hlapa.yeyintaung.com/";

class HttpService {
  Dio? _dio;

  static header() => {"Content-Type": "application/json"};

  Future<HttpService> init() async {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio!.interceptors.add(LoggingInterceptor());
  }

  Future<Map<String,dynamic>> request(String url, Method method,
      {Map<String, dynamic>? params}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio!.post("https://api-hlapa.yeyintaung.com/" + url, data: params);
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(url);
      } else {
        response = await _dio!.get(url, queryParameters: params);
      }

      if (response.statusCode == 200) {
        return returnResponse(response);
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something does wen't wrong");
      }
    } on SocketException catch (e) {
      //logger.e(e);
      throw Exception("Not Internet Connection");
    } on FormatException catch (e) {
      //logger.e(e);
      throw Exception("Bad response format");
    } on DioError catch (e) {
      //logger.e(e);
      throw Exception(e);
    } catch (e) {
      //logger.e(e);
      print("Error ***** $e");
      throw Exception("Something wen't wrong");
    }
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
