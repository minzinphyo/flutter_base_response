import 'package:flutter/material.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';

class UserProfileScreen extends StatelessWidget {
  final UserOb userOb;
  const UserProfileScreen(this.userOb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: Center(child: Text(userOb.name)),
    );
  }
}
