import 'package:flutter/material.dart';
import 'package:flutter_base_response/screens/login_screen.dart';
import 'package:flutter_base_response/screens/product_list_screen.dart';
import 'package:flutter_base_response/utils/setup_locator.dart';
import 'package:flutter_base_response/view_model/product_provider.dart';
import 'package:flutter_base_response/view_model/user_view_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'cache/hive_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Need To register Adapters
  //HiveHelper.registerAdapters();
  //Need To open Box
  await HiveHelper.openBox();
  await setupLocator();
  var productProvider = locator<ProductViewModel>();
  var userProvider = locator<UserViewModel>();

  return runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => productProvider,
      ),
      ChangeNotifierProvider(
        create: (context) => userProvider,
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: LoginScreen()
    );
  }
}
