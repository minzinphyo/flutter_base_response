import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_base_response/data_models/daos/product_ob.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data_models/base_response/api_response.dart';
import '../data_source/repository_impl.dart';
import '../exception/exception.dart';
import '../utils/setup_locator.dart';

class ProductViewModel with ChangeNotifier {
  var repository = locator<RepositoryImpl>();

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  List<Product> productList = [];

  Future<void> getProductList() async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      productList = await repository.getProductList();
      _apiResponse = ApiResponse.completed(productList);
    }on DioError catch (dioError) {
      final error = DioExceptions.fromDioError(dioError).toString();
      _apiResponse = ApiResponse.error(error);
      Fluttertoast.showToast(msg: _apiResponse.message!);
    }
    notifyListeners();
  }
}

