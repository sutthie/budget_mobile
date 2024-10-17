// ignore_for_file: prefer_const_constructors, file_names

import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import '../admin/ShowAccDetail.dart';
import '../chat/ChatPerson.dart';
// import '../admin/AddUser.dart';
import '../admin/ShowAcc.dart';
import '../budget/ShowExpediteAdmin.dart';
import '../global/globalVar.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../global/ManageLogin.dart';

var login;

//draw side menu
class SideMenuLeftAdmin extends StatelessWidget {
  // const SideMenuLeftAdmin({Key? key}) : super(key: key);

  SideMenuLeftAdmin() {
    // initHive Box Name : LoginData
    ManageLogin _login = ManageLogin();
    _login.DefineBox().then((box) {
      login = box;
    });
  }

  //late final login;

  //=================set Hive for Global Data===================
  // await Hive.initFlutter();
  // box = await Hive.openBox('LoginData');
  // box.put('aid', dat["aid"]);
  // box.put('userid', dat['userid']);
  // box.put('uid', dat['uid']);
  // box.put('fullname', dat['fullname']);
  // box.put('email', dat['email']);
  // box.put('status', dat["status"]);
  // box.put('token', dat["token"]);
//============================================================

  String getStatusUser(String i) {
    String str = "";

    switch (i) {
      case '1':
        str = "ผู้ดูแลระบบ";
        break;
      case '2':
        str = "เจ้าหน้าที่";
        break;
      case '3':
        str = "ผู้บังคับบัญชา";
        break;
      case '4':
        str = "ผู้บังคับบัญชาโดยตรง";
        break;
    }

    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: lightpurple2,
        child: Column(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เมนูหลัก',
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "ชื่อผู้ใช้ : ",
                            //textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 15),
                          ),
                          Text(
                            "${login.get('fullname')}",
                            //textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          Text(
                            //"สถานะ : ${login.get('status')}",
                            "สถานะ : ",
                            //textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 15),
                          ),
                          Text(
                            //"สถานะ : ${login.get('status')}",
                            "${getStatusUser(login.get('status'))}",
                            //textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        children: [
                          Text(
                            //"สถานะ : ${login.get('status')}",
                            //"หน่วยงาน : ${getStatusUser(login.get('unitname'))}",
                            "หน่วยงาน : ",
                            //textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Colors.yellow, fontSize: 15),
                          ),
                          Text(
                            //"สถานะ : ${login.get('status')}",
                            //"หน่วยงาน : ${getStatusUser(login.get('unitname'))}",
                            "${CurrentUnitName}",
                            //textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.cyan.shade50, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: bgcolorApp,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'ข้อมูลแอคเค้าท์',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    //builder: (context) => ShowAccountDetail(login.get('aid')),
                    builder: (context) => ShowAccountDetail(login.get('aid')),
                    //builder: (context) => ShowAccount(),
                  ),
                ),
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.person_add),
            //   title: const Text('เพิ่มข้อมูลผู้ใช้'),
            //   onTap: () => {
            //     //Navigator.of(context).pop()
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => AddUser(),
            //       ),
            //     ),
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text(
                'บริหารรายชื่อผู้ใช้',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowAccount(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text(
                'ข้อมูลงบประมาณ',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowExpediteAdmin(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text(
                'คุยกัน',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPerson(
                      title: '',
                    ),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.routeName, (Route<dynamic> route) => false),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SignInScreen(),
                //   ),
                // ),
              },
            ),
            /* ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Test List Page'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TestListPage(),
                  ),
                ),
              },
            ), */
          ],
        ),
      ),
    );
  }
}
