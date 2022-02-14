import 'package:flutter/material.dart';
import 'package:flutter_base_response/screens/product_list_screen.dart';
import 'package:flutter_base_response/utils/setup_locator.dart';
import 'package:flutter_base_response/view_model/product_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  var productProvider = locator<ProductProvider>();

  return runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => productProvider,
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
      home: ProductListScreen()
    );
  }
}
