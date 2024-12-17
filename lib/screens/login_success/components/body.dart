import 'package:budget_mobile/MainPage.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
//import '../../../screens/home/MainScreen.dart';
import '../../../admin/AdminSystem.dart';
import '../../../../global/size_config.dart';
import '../../../global/GetYearBudget.dart';
import '../../../global/ManageLogin.dart';
import '../../../global/MySQLService.dart';

var login;

// ignore: must_be_immutable
class Body extends StatelessWidget {
  late String uid;
  //String cnt_work = "";
  late int yearBud;

  final txtIncome = TextEditingController();

  Body() {
    GetYearBudget yb = new GetYearBudget();
    yearBud = yb.getYearBudget();
    print("Year Budget : " + yearBud.toString());

    ManageLogin _login = ManageLogin();
    _login.DefineBox().then((box) {
      login = box;
      uid = login.get('uid').toString();

      //Get Status Income Job
      MySQLDB mydb = MySQLDB();
      mydb.getStatusInCome(uid, yearBud.toString()).then((String result) {
        print(result);

        txtIncome.text = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleLabel = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final TxtField_cntIncome = TextField(
      controller: txtIncome,
      //readOnly: true,
      enabled: false,
      textAlign: TextAlign.center,
      style: styleLabel,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.all(3)),
    );

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
        Text(
          "มีงานยังไม่ได้รับ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        Center(
            child: Container(
                //alignment: Alignment.center,
                width: 80,
                child: TxtField_cntIncome)),
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
                Navigator.pushReplacementNamed(context, MainPage.routeName);
              //Navigator.pushNamed(context, MainPage.routeName);

              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ShowStartBook(),
              //     ),
              // );

              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => MainPage()));

              //Navigator.of(context).pop();
              //  Navigator.of(context).pushNamedAndRemoveUntil(MainPage.routeName, (Route<dynamic> route) => false);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
