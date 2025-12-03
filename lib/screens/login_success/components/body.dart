import 'package:budget_mobile/MainPage.dart';
import 'package:budget_mobile/MainPageAdmin.dart';
import 'package:budget_mobile/budget/ShowReceiveExpedite.dart';
import 'package:flutter/material.dart';
import '../../../components/default_button.dart';
//import '../../../screens/home/MainScreen.dart';
import '../../../../global/size_config.dart';
import '../../../global/GetYearBudget.dart';
import '../../../global/ManageLogin.dart';
import '../../../global/MySQLService.dart';

var login;

// ignore: must_be_immutable
class Body extends StatelessWidget {
  late String uid;
  //late String status;
  //String cnt_work = "";
  late int yearBud;

  final txtIncome = TextEditingController();
  final txtcntSend = TextEditingController();

  Body() {
    yearBud = GetYearBudget.getYearBudget();
    print("Year Budget : " + yearBud.toString());

    ManageLogin _login = ManageLogin();
    // box.put('status', dat["status"]);
    // box.put('token', dat["token"]);
    _login.DefineBox().then((box) {
      login = box;
      uid = login.get('uid').toString();
      //status = login.get('status').toString();
      // print("UID : " + uid);
      // print("Status : " + status);

      //Get Status Income Job
      MySQLDB mydb = MySQLDB();
      mydb.getStatusInCome(uid, yearBud.toString()).then((String result) {
        print(result);

        txtIncome.text = result;
      });

      //Get Status Send Job
      mydb.getStatusSend(uid, yearBud.toString()).then((String result) {
        print(result);

        txtcntSend.text = result;
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
      readOnly: true,
      //enabled: false,
      textAlign: TextAlign.center,
      style: styleLabel,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(3),
      ),
      onTap: () {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => ShowReceiveExpedite(uid)),
        // );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShowReceiveExpedite(uid)),
          (Route<dynamic> route) => false,
        );

        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   '/showrxexp',
        //   (Route<dynamic> route) => false,
        // );
      },
    );

    final TxtField_cntSend = TextField(
      controller: txtcntSend,
      readOnly: true,
      //enabled: false,
      textAlign: TextAlign.center,
      style: styleLabel,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(3),
      ),
      onTap: () {
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //   '/showrxexp',
        //   (Route<dynamic> route) => false,
        // );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShowReceiveExpedite(uid)),
          (Route<dynamic> route) => false,
        );
      },
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
        Column(
          children: [
            Text(
              "มีงานยังไม่ได้รับ",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
        Column(children: [TxtField_cntIncome]),
        Spacer(),
        Column(
          children: [
            Text(
              "มีงานยังไม่ได้ส่ง",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.bold,
                color: Colors.lightGreenAccent,
              ),
            ),
          ],
        ),
        Column(children: [TxtField_cntSend]),
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
                  MaterialPageRoute(builder: (context) => MainPageAdmin()),
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
