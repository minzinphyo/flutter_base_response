import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_models/base_response/api_response.dart';
import '../utils/setup_locator.dart';
import '../view_model/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key key}) : super(key: key);


  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var productProvider = locator<ProductProvider>();

  @override
  void initState() {
    productProvider.getProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<ProductProvider>(context).response;
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Demo App"),),
      body: getProductWidget(context, apiResponse)
    );
  }

  Widget getProductWidget(BuildContext context, ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Consumer<ProductProvider>(
          builder: (context, shopProfileProvider, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                  itemCount: shopProfileProvider.productList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1,
                      color: Colors.black,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Text(shopProfileProvider.productList[index].name);
                  })),
        );
      case Status.ERROR:
        return Center(
          child: Text(apiResponse.message),
        );
      case Status.INITIAL:
      default:
        return const Center(
          child: Text('Search the song by Artist'),
        );
    }
  }
}
