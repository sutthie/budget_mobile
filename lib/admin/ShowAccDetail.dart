// ignore_for_file: prefer_const_constructors, file_names
import 'dart:convert';
import 'dart:developer';

import 'package:budget_mobile/styles/TextStyle.dart';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import '../global/MySQLService.dart';
import '../global/ResponseMessage.dart';
//import 'ShowAcc.dart';
// import '../global/globalVar.dart';
import '../models/Account.dart';
import '../global/ManageLogin.dart';

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
//String Aid = "";

var login;

class ShowAccountDetail extends StatefulWidget {
  //const ShowAccountDetail({Key? key}) : super(key: key);
  final String aid;
  ShowAccountDetail(this.aid) {
    print(this.aid);

    // initHive Box Name : LoginData
    ManageLogin _login = ManageLogin();
    _login.DefineBox().then((box) {
      login = box;

      print(login.get('status'));
    });

    //print('get status after get box : ' + login.get('status'));
  }

  @override
  _ShowAccountDetailState createState() => _ShowAccountDetailState();
}

class _ShowAccountDetailState extends State<ShowAccountDetail> {
  //String Token = "";
  //String FullName = "";
  //String Email = "";
  //String Status = "";

  _ShowAccountDetailState() {}

//=================set Hive for Global Data===================
  // await Hive.initFlutter();
  // box = await Hive.openBox('GlobalData');
  // box.put('aid', dat["aid"]);
  // box.put('fullname', dat['fullname']);
  // box.put('email', dat['email']);
  // box.put('status', dat["status"]);
  // box.put('token', dat["token"]);

  // DefineBox() async {
  //   await Hive.initFlutter();
  //   box = await Hive.openBox('GlobalData');
  //   // get from Hive
  //   Aid = box.get('aid');
  //   Status = box.get('status');
  //   FullName = box.get('fullname');
  //   // Email = box.get('email');
  //   Token = box.get('token');
  // }

//=====define TextEditingController======
  final txtUser = TextEditingController();
  final txtPwd = TextEditingController();
  final txtFirstName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtMobile = TextEditingController();
  // final txtStatus = TextEditingController();

// define FocusNode
  final FocusNode _focus = FocusNode(); // username
  final FocusNode _nextFocus1 = FocusNode(); //pwd
  final FocusNode _nextFocus2 = FocusNode(); //firstname
  final FocusNode _nextFocus3 = FocusNode(); //lastname
  final FocusNode _nextFocus4 = FocusNode(); //mobile
  final FocusNode _nextFocusBSave = FocusNode(); // button save

  // defind string

  String fname = "";
  String lname = "";
  String userid = "";
  String password = "";
  String mobile = "";

  @override
  void initState() {
    super.initState();
    //=====init Data=================
    MySQLDB mydb = MySQLDB();
    mydb.getAccDetail(widget.aid).then((Account? result) {
      setState(() {
        fname = result!.firstname;
        lname = result.lastname;
        userid = result.userid;
        password = result.passwords;
        mobile = result.mobile;
      });

      txtFirstName.text = fname;
      txtLastName.text = lname;
      txtUser.text = userid;
      txtPwd.text = password;
      txtMobile.text = mobile;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//====TextStyle========
    TextStyle styleHead = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.brown,
    );

    TextStyle styleHead1 = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.brown,
    );

    TextStyle styleNormal = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.black,
    );

    // ignore: unused_local_variable
    TextStyle styleLabel = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      //backgroundColor: Colors.white,
    );

    // ignore: unused_local_variable
    TextStyle styleError = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      color: Colors.red,
    );

    //======define widget=======
    // final textStatus = TextField(
    //   controller: txtStatus,
    // );

    final userField = TextField(
      style: styleNormal,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus,
      controller: txtUser,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "UserName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _focus, _nextFocus1);
      },
    );

    final passwordField = TextField(
      //obscureText: true,
      controller: txtPwd,
      focusNode: _nextFocus1,
      //enabled: false,
      style: styleNormal,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _nextFocus1, _nextFocus2);
      },
      /*   onChanged: (txt) {
        setState(() {
          log(txt);
        }); 
      },*/
    );

    final firstnameField = TextField(
      //obscureText: true,
      controller: txtFirstName,
      focusNode: _nextFocus2,
      //enabled: false,
      style: styleNormal,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "FirstName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _nextFocus2, _nextFocus3);
      },
      /*   onChanged: (txt) {
        setState(() {
          log(txt);
        }); 
      },*/
    );

    final lastnameField = TextField(
      //obscureText: true,
      controller: txtLastName,
      focusNode: _nextFocus3,
      //enabled: false,
      style: styleNormal,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "LastName",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _nextFocus3, _nextFocus4);
      },
      /*   onChanged: (txt) {
        setState(() {
          log(txt);
        }); 
      },*/
    );

    final mobileField = TextField(
      //obscureText: true,
      controller: txtMobile,
      focusNode: _nextFocus4,
      //enabled: false,
      style: styleNormal,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Mobile",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _nextFocus4, _nextFocusBSave);
        //FocusScope.of(context).requestFocus(_nextFocus4);
      },
      /*   onChanged: (txt) {
        setState(() {
          log(txt);
        });
      },*/
    );
    //=========================================

    final updateButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: orange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          // check input
          //bool chk = true;
          bool chk1 = false;
          bool chk2 = false;

          ResponseMessage amsg = new ResponseMessage();

          // check form
          if (txtUser.text.trim() == '' ||
              txtPwd.text.trim() == '' ||
              txtFirstName.text.trim() == '' ||
              txtLastName.text.trim() == '' ||
              txtMobile.text.trim() == '') {
            chk1 = false;
          } else {
            chk1 = true;
          }

          if (chk1 == false) {
            amsg.Alert(context, "กรอกข้อมูลไม่ครบ", "กรุณากรอกข้อมูลให้ครบ!!!");
          } else if (chk1 == true) {
            chk2 = txtMobile.text.trim().contains(new RegExp(r'^\d{10}$'));
            if (chk2 == false) {
              amsg.Alert(context, "กรอกข้อมูลผิดรูปแบบ",
                  "กรุณากรอกเบอร์โทรให้ถูกต้อง");
              FocusScope.of(context).requestFocus(_nextFocus4);
            } else {
              //====== check login=============
              MySQLDB mysql = MySQLDB();

              var Dat = <String, dynamic>{};
              Dat['aid'] = widget.aid;
              Dat['userid'] = txtUser.text;
              Dat['password'] = txtPwd.text;
              Dat['firstname'] = txtFirstName.text;
              Dat['lastname'] = txtLastName.text;
              Dat['mobile'] = txtMobile.text;

              mysql.UpdateUser(Dat).then((String result) {
                var ret = json.decode(result);

                String msg = "";
                if (ret["result"] == "false") {
                  msg = "ผิดพลาดในการบันทึก : ${ret["msg"]} ";
                } else if (ret["result"] == "true") {
                  msg = "ปรับปรุงข้อมูลเรียบร้อยแล้ว";

                  log("Status Update : $msg");
                }

                amsg.Alert(context, "ปรับปรุงข้อมูล", "ผลคือ : ${msg}");

                // Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ShowAccount(),
                //     //builder: (context) => ShowBudgetDetail('${spen.list_exp_spen}'),
                //   ),
                // );
              });
            }
          }
        },
        child: Text("บันทึก",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final deleteButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          //=== show dialog confirm delete===
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('ยืนยันการลบ'),
              content: const Text('กรุณายืนยันการลบ ???'),
              actions: [
                TextButton(
                  onPressed: () {
                    //=========delete=============
// check input
                    //bool chk = true;
                    bool chk1 = false;

                    ResponseMessage amsg = new ResponseMessage();

                    // check form
                    if (widget.aid == '') {
                      chk1 = false;
                    } else {
                      chk1 = true;
                    }

                    if (chk1 == false) {
                      amsg.Alert(
                          context, "ข้อมูลไม่พบ", "กรุณาเลือกข้อมูลให้ครบ!!!");
                    } else if (chk1 == true) {
                      //====== check login=============
                      MySQLDB mysql = MySQLDB();

                      var Dat = <String, dynamic>{};
                      Dat['aid'] = widget.aid;
                      Dat['table'] = "account";

                      mysql.DeleteUser(Dat).then((String result) {
                        var ret = json.decode(result);

                        String msg = "";
                        if (ret["result"] == "false") {
                          msg = "ผิดพลาดในการลบ : ${ret["msg"]} ";
                        } else if (ret["result"] == "true") {
                          msg = "ลบข้อมูลเรียบร้อยแล้ว";

                          log("Status Delete : $msg");
                        }

                        amsg.Alert(context, "ลบข้อมูล", "ผลคือ : ${msg}");
                        //Navigator.of(context).pop();
                      });
                    }
                    //============================
                    Navigator.of(context).pop();

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ShowAccount(),
                    //   ),
                    // );

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ShowAccount(),
                    //   ),
                    // );
                  },
                  child: const Text('OK'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ).then((retval) {
            if (retval != null) {}
          });
          //========================================
        },
        child: Text("ลบ",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final backButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: green,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          Navigator.of(context).pop();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ShowAccount(),
          //     //builder: (context) => ShowBudgetDetail('${spen.list_exp_spen}'),
          //   ),
          // );

          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     '/account', (Route<dynamic> route) => false);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => ShowAccount()),
          //     (Route<dynamic> route) => false);
        },
        child: Text("ย้อนกลับ",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    _focus.requestFocus();
    return Scaffold(
      // help protect bottom  overflow display
      resizeToAvoidBottomInset: false,
      backgroundColor: lightpurple,
      appBar: AppBar(
        //title: Text(widget.title),
        title: Text(
          "ปรับปรุงข้อมูลผู้ใช้",
          style: styleHeadWhite4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Text('รายละเอียด Account', style: styleHeadPurple),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [Text('')],
            // ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text(
                        'UserId',
                        style: styleHead1,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: userField,
                    width: 250,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                      width: 100, child: Text('Password', style: styleHead1)),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: passwordField,
                    width: 250,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                      width: 100,
                      child: Text('ยศ ชื่อ-สกุล', style: styleHead1)),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: firstnameField,
                    width: 250,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                      width: 100, child: Text('นามสกุล', style: styleHead1)),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: lastnameField,
                    width: 250,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                      width: 100, child: Text('มือถือ', style: styleHead1)),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    child: mobileField,
                    width: 250,
                  ),
                ],
              ),
            ),
            // Visibility(visible: false, child: textStatus),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: updateButton,
            ),
            const SizedBox(height: 4.0),
            //login?.get('status') == '1' ? deleteButton : Text(''),
            login?.get('status') == '1'
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: deleteButton,
                  )
                : const SizedBox(height: 4.0),
            const SizedBox(height: 4.0),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: backButon,
            ),
          ],
        ),
      ),
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
