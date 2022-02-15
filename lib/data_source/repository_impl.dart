import 'dart:io';

import 'package:flutter_base_response/data_models/base_response/api_response.dart';
import 'package:flutter_base_response/data_source/repository.dart';
import 'package:flutter_base_response/data_source/service/dio_service.dart';
import '../data_models/base_response/base_api_response.dart';
import '../data_models/daos/product_ob.dart';

class RepositoryImpl extends Repository {
  final DioService _dioService = DioService();

  @override
  Future<List<Product>> getProductList() async {
      try{
        final response = await _dioService.getRequest(
            "ydhnwb/raw/8e2af09b6fb9813b2edcc88e68e5ec20cb2ad263/example_multi_product.json");
        final parsedResponse = BaseApiResponse<Product>.fromListJson(response,
            create: (data) => Product.fromJson(data));
        return parsedResponse.listResult;
      }catch(e){
        rethrow;
      }

  }
}
