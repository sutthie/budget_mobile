import 'package:budget_mobile/admin/ShowAccDetail.dart';
import 'package:budget_mobile/budget/ShowStartBook.dart';
//import 'package:budget_mobile/budget/ReceiveExpedite.dart.bak';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import '../MainPage.dart';
//import '../budget/SendExpediteTo.dart.bak';
//import '../TestSJComponet.dart';
import '../budget/ShowExpedite.dart';
//import '../budget/ShowExpediteOwn.dart';
import '../budget/ShowReceiveExpedite.dart';
import '../global/ManageLogin.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import '../chat/ChatPerson.dart';
// import '../admin/ShowAcc.dart';
// import '../screens/advert/AdvertScreen.dart';
import '../global/globalVar.dart';
import '../screens/sign_in/sign_in_screen.dart';
// import '../upload/TestFormFileUp.dart';
// import '../upload/TestUploadFile.dart';
// import '../upload/TestUploadFile1.dart';
// import '../url/test_js1.dart';
// import '../url/test_url_launcher1.dart';

var login;

//draw side menu
class SideMenuLeft extends StatelessWidget {
  //SideMenuLeft({Key? key}) : super(key: key);

  SideMenuLeft() {
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
              leading: const Icon(Icons.home),
              title: const Text(
                'หน้าหลัก',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MainPage(),
                //     //builder: (context) => MainScreen(),
                //     //builder: (context) => AdvertScreen(),
                //   ),
                // ),
                Navigator.of(context).pushNamedAndRemoveUntil(
                    MainPage.routeName, (Route<dynamic> route) => false),
              },
            ),

            /*
           if (admin == true)
              ListTile(
                leading: const Icon(Icons.border_color),
                title: const Text('ปรับปรุงข้อมูลสินค้า'),
                onTap: () => {
                  //Navigator.of(context).pop()
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminProduct(),
                    ),
                  ),
                },
              ),
      */
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
                    builder: (context) => ShowExpedite(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text(
                'หน่วยต้นเรื่องส่งต่อ',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowStartBook(),
                  ),
                ),
              },
            ),
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text(
                'บันทึกรับงานของหน่วย',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                //Navigator.of(context).pop()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowReceiveExpedite(login.get('uid')),
                  ),
                ),
              },
            ),

            // ListTile(
            //   leading: const Icon(Icons.chat),
            //   title: const Text(
            //     'คุยกัน',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //Navigator.of(context).pop()
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ChatPerson(
            //       title: '',
            //     ),
            //   ),
            // ),
            //   },
            // ),

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

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.brown, fontSize: 18),
              ),
              onTap: () => {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SignInScreen(),
                //   ),
                // ),
                Navigator.of(context).pushNamedAndRemoveUntil(
                    SignInScreen.routeName, (Route<dynamic> route) => false),
              },
            ),
            //SizedBox(height: 10),
            // ListTile(
            //   leading: Icon(Icons.run_circle),
            //   title: const Text(
            //     'Test fileUtilSample',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => fileUtilSample(),
            //       ),
            //     ),
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.run_circle),
            //   title: const Text(
            //     'Test url_launcher1',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => test_url_launcher1(),
            //       ),
            //     ),
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.run_circle),
            //   title: const Text(
            //     'Test javascript1',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => test_js1(),
            //       ),
            //     ),
            //   },
            // ),

            // ListTile(
            //   leading: Icon(Icons.run_circle),
            //   title: const Text(
            //     'TestUploadFile1',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => TestUploadFile1(),
            //       ),
            //     ),
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.run_circle),
            //   title: const Text(
            //     'Test Form File Upload',
            //     style: TextStyle(color: Colors.brown, fontSize: 18),
            //   ),
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => TestFormFileUp(),
            //       ),
            //     ),
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
