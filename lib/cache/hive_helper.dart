import 'package:hive/hive.dart';

class HiveHelper {
  static const String tokenName = "tokenName";
  static const String tokenKey = "tokenKey";

  static Box<String>? tokenBox;

  // static Box<SalonOb> salonBox = Hive.box<SalonOb>(HiveHelper.salonName);

  // static void registerAdapters() {
  //   Hive.registerAdapter(ProfileObAdapter()); //Hive ID 0
  //   //Hive.registerAdapter(SalonObAdapter()); //Hive ID 1
  // }

  static Future openBox() async {
    await Hive.openBox<String>(tokenName);
  }


  static String? getToken() {
    tokenBox = Hive.box<String>(tokenName);
    return tokenBox!.get(tokenKey);
  }

  static void clearAllBoxes() {
    print("All DB are clear");
    tokenBox!.clear();
  }
}
