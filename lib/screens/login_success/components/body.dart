import 'package:budget_mobile/MainPage.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
//import '../../../screens/home/MainScreen.dart';
import '../../../admin/AdminSystem.dart';
import '../../../../global/size_config.dart';
import '../../../global/ManageLogin.dart';

var login;

class Body extends StatelessWidget {
  Body() {
    ManageLogin _login = ManageLogin();
    _login.DefineBox().then((box) {
      login = box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
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
            text: "ไปหน้าหลัก",
            press: () {
              // if (login.get('status') == '1')
              //   ListTile(
              //     leading: const Icon(Icons.manage_accounts),
              //     title: const Text('บริหารระบบ'),
              //     onTap: () => {
              //       //Navigator.of(context).pop()
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AdminSystem(),
              //         ),
              //       ),
              //     },
              //   ),

              if (login.get('status') == '1')
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminSystem(),
                  ),
                );
              else
                Navigator.pushNamed(context, MainPage.routeName);
              //Navigator.pushNamed(context, MainScreen.routeName);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
