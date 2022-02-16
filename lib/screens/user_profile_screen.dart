import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data_models/base_response/api_response.dart';
import '../utils/setup_locator.dart';
import '../view_model/user_view_model.dart';
import '../widget/list_item_salon_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var userProvider = locator<UserViewModel>();

  @override
  void initState() {
    userProvider.getSalonList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<UserViewModel>(context).response;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Top Salon",
          style:
              GoogleFonts.lato(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (input) {},
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    hintText: "Search salon by name",
                    hintStyle: const TextStyle(fontSize: 15),
                  ),
                  onChanged: (input) {
                    //print(input);
                  },
                ),
              ),
            ),
            Expanded(
              child: widgetBody(context, apiResponse),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetBody(BuildContext context, ApiResponse apiResponse) {
    switch (apiResponse.status) {
      case Status.LOADING:
        return const Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return Consumer<UserViewModel>(
          builder: (context, userProvider, child) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.separated(
                  itemCount: userProvider.salonList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1,
                      color: Colors.black,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return listItemSalonWidget(
                      showFavourite: true,
                      context: context,
                    );
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
