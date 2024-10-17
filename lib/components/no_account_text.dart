import 'package:flutter/material.dart';
import '../screens/sign_up/sign_up_screen.dart';

import '../global//constants.dart';
import '../global/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ถ้าไม่มีแอคเค้าท์? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "ลงทะเบียนใหม่",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: bPrimaryColor),
          ),
        ),
      ],
    );
  }
}
