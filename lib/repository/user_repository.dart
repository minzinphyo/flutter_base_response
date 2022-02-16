import 'package:flutter_base_response/data_models/daos/salon_item_ob.dart';
import 'package:flutter_base_response/data_models/daos/user_ob.dart';

abstract class UserRepository{
  //Local
  Future<UserOb> loginUser(String phone,String password);

  Future<List<SalonItemOb>> getSalonList();
}