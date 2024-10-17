import 'package:flutter/material.dart';
import '../../styles/TextStyle.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text("Sign In"),
          title: Text(
        "ลงชื่อเข้าใช้ระบบ",
        //style: styleMedium(Colors.blue),
        style: styleCustom('', 18.0, Colors.white, true),
      )),
      body: Body(),
    );
  }
}
