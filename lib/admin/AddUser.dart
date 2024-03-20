import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:budget_mobile/styles/colors.dart';
import '../global/MySQLService.dart';
import '../global/ResponseMessage.dart';
import '../models/UnitName.dart';
import 'package:budget_mobile/styles/TextStyle.dart';

import 'ShowAcc.dart';
//import 'MainPage.dart';

class AddUser extends StatefulWidget {
  //const AddUser({Key? key, required this.title}) : super(key: key);
  //final String title;
  static String routeName = "/adduser";

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final oneSecond = Duration(seconds: 1);
  final txtUser = TextEditingController();
  final txtPwd = TextEditingController();
  final txtFirstName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtMobile = TextEditingController();

  late Future<List<UnitName>?> unitList;

  late String? unitNow;
  //final int i = 0;

  final FocusNode _focus = FocusNode(); // username
  final FocusNode _nextFocus1 = FocusNode(); //pwd
  final FocusNode _nextFocus2 = FocusNode(); //firstname
  final FocusNode _nextFocus3 = FocusNode(); //lastname
  final FocusNode _nextFocus4 = FocusNode(); //mobile
  final FocusNode _nextFocusBSave = FocusNode(); // button save
  final FocusNode ddlNode = FocusNode(); // ddl

  _AddUserState() {
    //fetchData();
  }

  @override
  void initState() {
    super.initState();

    MySQLDB mydb = MySQLDB();
    //===init Unit ==================
    unitNow = null;
    unitList = mydb.getUnitList();
  }

  @override
  void dispose() {
    super.dispose();
  }

//=========================================
  TextStyle styleHead = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle styleNormal = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    color: Colors.black,
  );

  TextStyle styleError = const TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    color: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    //======define widget=======
//======define ddl widget=======
    Widget ddlUnit(udata) {
      return FutureBuilder<List<UnitName>?>(
          future: udata,
          //builder: (BuildContext context, AsyncSnapshot<List<UnitName>?> snapshot) {
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            //return Center(child: CircularProgressIndicator());
            else
              return DropdownButton<String>(
                focusNode: ddlNode,
                autofocus: true,
                //isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                items: snapshot.data
                    ?.map((item) => DropdownMenuItem<String>(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.uint_name,
                                style: TextStyle(
                                  //backgroundColor: white,
                                  decoration: TextDecoration.underline,
                                  color: blue,
                                  //backgroundColor: lightgreen
                                )),
                          ),
                          value: item.uint,
                        ))
                    .toList(),
                value: unitNow,
                //value: "",
                //value: null,
                onChanged: (un) {
                  setState(() {
                    unitNow = un.toString();
                  });
                  // ignore: unused_local_variable
                  var msg = new ResponseMessage();
                  //msg.Alert(context, "เลือกหน่วยงาน", unitNow.toString());
                },
                //isExpanded: true,
                hint: Text('กรุณาเลือกหน่วยที่ต้องการ'),
                disabledHint: Text("Disabled"),
                elevation: 8,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                //style: Theme.of(context).textTheme.labelMedium,
                //style: Theme.of(context).textTheme.bodyText2,
                //dropdownColor: Colors.white,
                dropdownColor: lightyellow2,
                //focusColor: Colors.yellow.shade100,
                icon: Icon(Icons.arrow_drop_down_circle),
                iconDisabledColor: Colors.red,
                iconEnabledColor: Colors.blue,
                iconSize: 30,
              );
          });
    }

    final userField = TextField(
      style: styleNormal,
      autofocus: true,
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
      obscureText: true,
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Mobile",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onSubmitted: (v) {
        _fieldFocusChange(context, _nextFocus4, _nextFocusBSave);
      },
      /*   onChanged: (txt) {
        setState(() {
          log(txt);
        });
      },*/
    );
    //=========================================
    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: const Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
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
              txtMobile.text.trim() == '' ||
              unitNow == null) {
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

              mysql.AddUserJson(unitNow!, txtUser.text, txtPwd.text,
                      txtFirstName.text, txtLastName.text, txtMobile.text)
                  .then((String result) {
                var ret = json.decode(result);

                String msg = "";
                if (ret["result"] == "false") {
                  msg = "ผิดพลาดในการบันทึก : ${ret["msg"]} ";
                } else if (ret["result"] == "true") {
                  msg = "บันทึกเรียบร้อยแล้ว";

                  //log("Status Login : $msg");
                }

                amsg.Alert(context, "ผลการบันทึก", "ผลคือ : ${msg}");

                Future.delayed(oneSecond * 2, () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowAccount(),
                    ),
                  );
                });
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
    //================================
    final resetButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.redAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          txtUser.text = "";
          txtPwd.text = "";

          txtFirstName.text = "";
          txtLastName.text = "";
          txtMobile.text = "";

          //amsg.Alert("หัวข้อ","ทดสอบ");
          //FocusScope.of(context).requestFocus(_focus);
          //FocusScope.of(context).requestFocus(_nextFocus2);
        },
        child: Text("Reset",
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
        },
        child: Text("ย้อนกลับ",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    //===================================

    return Scaffold(
      // help protect bottom  overflow display
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan[200],
      appBar: AppBar(
        //title: Text(widget.title),
        title: Text(
          'สร้างรายการผู้ใช้ใหม่',
          style: styleHeadWhite4,
        ),
      ),
      body: Container(
        //width: MediaQuery.of(context).size.width * 0.3,
        //height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'กรุณาป้อนข้อมูล',
                style: styleHead,
              ),
            ),
            const SizedBox(height: 3.0),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                //width: 250,
                child: ddlUnit(unitList),
                color: white,
              ),
            ),
            const SizedBox(height: 3.0),
            userField,
            const SizedBox(height: 3.0),
            passwordField,
            const SizedBox(height: 3.0),
            firstnameField,
            const SizedBox(height: 3.0),
            lastnameField,
            const SizedBox(height: 3.0),
            mobileField,
            const SizedBox(height: 3.0),
            SaveButon,
            const SizedBox(height: 3.0),
            resetButon,
            const SizedBox(height: 3.0),
            backButon,
          ],
        ),
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
