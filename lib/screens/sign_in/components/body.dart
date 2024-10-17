import 'package:flutter/material.dart';
import '../../../components/no_account_text.dart';
import '../../../components/socal_card.dart';
import '../../../global/size_config.dart';
import 'sign_form.dart';
import '../../../styles/TextStyle.dart';
import '../../../global/constants.dart';
import 'package:budget_mobile/styles/colors.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: lightpurple,
        //color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Text(
                    'ยินดีต้อนรับเข้าสู่',
                    style: TextStyle(
                      color: blue,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "ระบบติดตามเร่งรัดการใช้จ่ายงบประมาณ สส.ทหาร",
                    style: TextStyle(
                        color: greendark,
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      //"Sign in with your email and password  \nor continue with social media",
                      "พิสูจน์สิทธิ์การใช้งาน",
                      textAlign: TextAlign.start,
                      //style: styleMedium(Colors.pink.shade200),
                      style: styleCustom('', 18.0, brown, false),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        colour: white,
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        colour: white,
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/line_logo.svg",
                        colour: white,
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(50)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NoAccountText(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
