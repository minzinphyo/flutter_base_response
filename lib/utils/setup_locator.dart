import 'package:flutter_base_response/cache/hive_helper.dart';
import 'package:flutter_base_response/repository/user_repository_impl.dart';
import 'package:flutter_base_response/view_model/product_provider.dart';
import 'package:flutter_base_response/view_model/user_view_model.dart';
import 'package:get_it/get_it.dart';
import '../data_source/repository_impl.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton<HiveHelper>(() => HiveHelper());
  locator.registerLazySingleton<RepositoryImpl>(() => RepositoryImpl());
  locator.registerLazySingleton<ProductViewModel>(() => ProductViewModel());
  locator.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());
  locator.registerLazySingleton<UserViewModel>(() => UserViewModel());
}
