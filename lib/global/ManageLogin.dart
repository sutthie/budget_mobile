import 'package:hive_flutter/hive_flutter.dart';

class ManageLogin {
//=========================================================
  var box;
  DefineBox() async {
    await Hive.initFlutter();
    box = await Hive.openBox('LoginData');
    return box;
  }
}
