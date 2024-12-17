import 'package:flutter/material.dart';
import '../../../global/size_config.dart';
import '../../components/default_button.dart';
import '../../styles/TextStyle.dart';
import '../sign_in/sign_in_screen.dart';
import '../../styles/colors.dart';

class LoginFalseScreen extends StatelessWidget {
  static String routeName = "/login_false";
  final String errMsg;

  LoginFalseScreen({required this.errMsg});

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
          //Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,

          Center(
            child: Container(
              alignment: Alignment.center,
              width: 300,
              height: 100,
              //constraints: BoxConstraints.expand(height: 100, width: 300),
              /*  width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
                      height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height */
              //color: white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Login False :\n${(errMsg != '') ? 'Connection False !!!\nตรวจสอบเครือข่ายเน็ตเวิร์คด้วย' : 'ตรวจสอบความถูกต้อง UserName/Password'}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
                  fontWeight: FontWeight.bold,
                  //backgroundColor: Colors.white,
                  color: Colors.red,
                ),
              ),
            ),
          ),

          // var value = condition1 ? (condition2 ? valueA : valueB) : valueC;
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
