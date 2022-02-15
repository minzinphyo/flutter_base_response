import 'package:flutter_base_response/view_model/product_provider.dart';
import 'package:get_it/get_it.dart';
import '../data_source/repository_impl.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton<RepositoryImpl>(() => RepositoryImpl());
  locator.registerLazySingleton<ProductViewModel>(() => ProductViewModel());
}
