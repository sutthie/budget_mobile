import 'package:flutter/material.dart';
import '../../styles/TextStyle.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ลงทะเบียนผู้ใช้",
          style: styleCustom('', 18.0, Colors.white, true),
        ),
      ),
      body: Body(),
    );
  }
}
