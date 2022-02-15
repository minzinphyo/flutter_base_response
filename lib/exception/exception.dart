import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_base_response/exception/no_found_exception.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    if (dioError.type == DioErrorType.response) {
      message = _handleError(dioError.response.statusCode, dioError.response.data);
    }else if (dioError.type == DioErrorType.connectTimeout) {
      message = "Receive timeout in connection with API server";
    }else if (dioError.type == DioErrorType.receiveTimeout) {
      message = "Receive timeout in connection with API server";
    }else if (dioError.type == DioErrorType.sendTimeout) {
      message = "Send timeout in connection with API server";
    }else if (dioError.error is SocketException) {
      message = "No Internet Connection";
    }else{
      message = "Something went wrong";
    }

    // switch (dioError.type) {
    //   case DioErrorType.cancel:
    //     message = "Request to API server was cancelled";
    //     break;
    //   case DioErrorType.connectTimeout:
    //     message = "Connection timeout with API server";
    //     break;
    //   case DioErrorType.receiveTimeout:
    //     message = "Receive timeout in connection with API server";
    //     break;
    //   case DioErrorType.response:
    //     message =
    //         _handleError(dioError.response.statusCode, dioError.response.data);
    //     break;
    //   case DioErrorType.sendTimeout:
    //     message = "Send timeout in connection with API server";
    //     break;
    //   default:
    //     message = "Something went wrong";
    //     break;
    // }
  }

  String message;

  String _handleError(int statusCode, dynamic error) {
    print("Status code $statusCode");
    //final String errorMessage = NotFoundException(message: error["message"]).message;
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return "No Found";
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
