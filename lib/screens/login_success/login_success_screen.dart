import 'package:flutter/material.dart';
import '../../styles/TextStyle.dart';
import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "พิสูจน์สิทธิ์เรียบร้อย !!!",
          style: styleCustom("", 28.0, Colors.white, true),
        ),
      ),
      body: Body(),
    );
  }
}
