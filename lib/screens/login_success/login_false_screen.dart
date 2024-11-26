import 'package:flutter/material.dart';
import '../../../global/size_config.dart';
import '../../components/default_button.dart';
import '../../styles/TextStyle.dart';
import '../sign_in/sign_in_screen.dart';
import '../../styles/colors.dart';

class LoginFalseScreen extends StatelessWidget {
  static String routeName = "/login_false";

  @override
  Widget build(BuildContext context) {
    // Unfocus any currently focused text field
    FocusScope.of(context).unfocus();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "ไม่สามารถพิสูจน์สิทธิ์ได้ !!!",
          style: styleNormalLarge(yellow),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          Image.asset(
            "assets/images/unsuccess.png",
            height: SizeConfig.screenHeight * 0.4, // 40%
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Text(
            "Login False",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(30),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.screenWidth * 0.6,
            child: DefaultButton(
              text: "กลับสู่หน้าพิสูจน์สิทธิ์",
              press: () {
                // Unfocus keyboard when navigating to SignInScreen
                FocusScope.of(context).unfocus();
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
