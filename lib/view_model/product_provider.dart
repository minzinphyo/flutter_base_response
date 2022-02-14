import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_base_response/data_models/daos/product_ob.dart';

import '../data_models/base_response/api_response.dart';
import '../data_source/repository_impl.dart';
import '../utils/setup_locator.dart';

class ProductProvider with ChangeNotifier {
  var repository = locator<RepositoryImpl>();

  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  ApiResponse get response => _apiResponse;

  List<Product> productList = [];

  Future<void> getProductList() async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      productList = await repository.getProductList();
      print("Product list is ${productList.length}");
      _apiResponse = ApiResponse.completed(productList);
    } on SocketException catch (_) {
      _apiResponse = ApiResponse.error("No Internet");
    } catch (_) {
      _apiResponse = ApiResponse.error("Failed");
    }
    catch (e) {
      if(e is SocketException ){
        _apiResponse = ApiResponse.error("No Internet");
      }
      //print("Error **** ${e.toString()}");
    }
    notifyListeners();
  }
}

