import '../data_models/daos/product_ob.dart';

abstract class Repository{
  //Local
  Future<List<Product>> getProductList();
}