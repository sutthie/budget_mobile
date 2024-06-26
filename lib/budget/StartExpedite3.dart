// ignore_for_file: prefer_const_constructors, file_names
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global/MySQLService.dart';
import '../models/Expedite.dart';
import '../global/globalVar.dart';
import '../global/ResponseMessage.dart';
import '../global/GetYearBudget.dart';
import 'package:flutter_money/flutter_money.dart';
import '../models/UnitName.dart';
import 'package:budget_mobile/styles/colors.dart';
import 'package:budget_mobile/styles/TextStyle.dart';
import '../global/DateTimes.dart';
import '../global/ManageLogin.dart';
import '../upload/UploadFileBudget.dart';
import 'ShowStartBook.dart';
import '../widget_share/SnackBarMsg.dart';
//import 'ShowExpUserStart.dart.bak';

var login;

class StartExpedite extends StatefulWidget {
  final String id_exp_spen;

  const StartExpedite({super.key, required this.id_exp_spen});

  @override
  _ShowBudgetDetailState createState() => _ShowBudgetDetailState();
}

class _ShowBudgetDetailState extends State<StartExpedite> {
  late MySQLDB mydb;
  late ResponseMessage msg;
  late DateTimes now = DateTimes();
  String DateString = "";
  //String DateReal = "";
  String msgStr = "";
  late Future<List<UnitName>?> unitList;

  File? _file;
  String FileName = "";
  UploadFileClass upc = UploadFileClass();

  SnackBarMsg snackMsg = SnackBarMsg();
//=========data ddl==============
  List<String> itemSecret = ['ปกติ', 'ลับ', 'ลับมาก', 'ลับที่สุด'];
  List<String> itemAcc = ['ปกติ', 'ด่วน', 'ด่วนมาก', 'ด่วนที่สุด'];
  List<String> itemTypeJob = [
    'กรุณาเลือกประเภทงาน',
    'MA',
    'ครุภัณฑ์',
    'งานจัดหารายบรรทัด',
    'งานซ่อมรถ',
    'งานโครงการ',
    'งานก่อสร้าง',
    'งานอื่นๆ'
  ];

  int sel_acc = 0;
  int sel_secret = 0;
  double amout = 0.00;
  String sel_type_job = "กรุณาเลือกประเภทงาน";
  String txt_unit = "";
  String unitName = "";
  //String uid = "";

  //late String? unitNow;
  //String? unitNow = null;
//=====Controller Text===========
  final txtListName = TextEditingController();
  final txtTitle = TextEditingController();
  final txtAmout = TextEditingController();
  final txtBookNo = TextEditingController();
  final txtDate = TextEditingController();
  //final txtHideDate = TextEditingController(); // Date Format DB
  //final txtMoney = TextEditingController();
  final txtResponse = TextEditingController();
  final txtYear = TextEditingController();
  final txtIdExpSpen = TextEditingController();
  final txtUnit = TextEditingController();
  final txtLastAccess = TextEditingController();

  // file
  // ddl urgent
  // ddl secret
  // ddl type_job

// define FocusNode
  final FocusNode _focus = FocusNode();
  //final FocusNode _focusDate = FocusNode();

  //const currencyRegExp = r'^(\d+)?\.?\d{0,2}$';
  static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';
  final currencyFormatter =
      FilteringTextInputFormatter.allow(RegExp(currencyRegExp));

//==========set==fullname=====
  String fullname = "";

// ==== set year====
  int yearNow = 0;

  @override
  void initState() {
    super.initState();

    // initHive Box Name : LoginData
    ManageLogin _login = ManageLogin();

    _login.DefineBox().then((box) {
      login = box;
      fullname = login.get('fullname');
      txt_unit = login.get("uid");
      txtResponse.text = fullname + " " + login.get("unitname");
      unitName = login.get("unitname");
    });

    msg = ResponseMessage();
    mydb = MySQLDB();

    //=====init Data=================
    GetYearBudget yb = new GetYearBudget();
    yearNow = yb.getYearBudget();
    txtYear.text = yearNow.toString();

    //=====init UNIT Name==============
    //unitNow = null;
    unitList = mydb.getUnitList();

    //======init Date to TextField========
    DateString = now.DateThaiNow();
    txtDate.text = DateString; // show date now

    //txtHideDate.text = now.DateNowYMD(); // real record date

    // =====init Amout===================
    // setState(() {
    //   txtAmout.text = amout.toString();
    // });
    txtAmout.text = "0";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_focus.requestFocus();
//====TextStyle========
    TextStyle styleHead = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    );

    TextStyle styleLabel = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      color: Colors.yellow,
    );

    TextStyle styleInput = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.black,
    );

    //======define widget=======
    // final txtyear = TextField(
    //   controller: txtYear,
    //   style: styleLabel,
    //   //autofocus: true,
    //   //focusNode: _focus,

    //   minLines: 1, // Display at least 5 lines
    //   maxLines: null,
    //   decoration: InputDecoration(
    //       contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //       filled: true,
    //       //filled : false,
    //       fillColor: Colors.green.shade800,
    //       //hintText: "ชื่องบ",
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    //   onSubmitted: (v) {
    //     //_fieldFocusChange(context, _focus, _nextFocus);
    //   },
    // );

    // final txt_hide_idexpspen = TextField(
    //   controller: txtIdExpSpen,
    // );

    // final txt_hide_unit = TextField(
    //   controller: txtUnit,
    // );

    // final txt_hide_bookdate = TextField(
    //   controller: txtHideDate,
    // );

    // final txt_unit_docno = TextField(
    //   style: styleLabel,
    //   //autofocus: true,
    //   //focusNode: _focus,
    //   controller: txtBookNo,
    //   minLines: 1, // Display at least 5 lines
    //   maxLines: null,
    //   decoration: InputDecoration(
    //       contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //       filled: true,
    //       //filled : false,
    //       fillColor: Colors.green.shade800,
    //       //hintText: "ชื่องบ",
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    //   onSubmitted: (v) {
    //     //_fieldFocusChange(context, _focus, _nextFocus);
    //   },
    // );

    final txtlistname = TextField(
      style: styleLabel,
      //autofocus: true,
      //focusNode: _focus,
      readOnly: true,
      keyboardType: TextInputType.none,
      controller: txtListName,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: Colors.green.shade800,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txttitle = TextField(
      style: styleInput,
      autofocus: true,
      focusNode: _focus,
      //enabled: true,
      // minLines: 1, // Display at least 5 lines
      // maxLines: null,
      controller: txtTitle,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "ชื่อเรื่อง",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      // onSubmitted: (v) {
      //   //_fieldFocusChange(context, _focus, _nextFocus);
      // },
      // onTap: () {
      //   _focus.requestFocus();
      // },
    );

    final txt_amout = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtAmout,
      keyboardType: TextInputType.number,
      // inputFormatters: [
      //   currencyFormatter,
      // ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "จำนวนเงิน",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onChanged: (value) {
        String money = "";

        print(money);
      },
      // onSubmitted: (v) {
      //   //_fieldFocusChange(context, _focus, _nextFocus);
      // },
    );

    final txtbookno = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtBookNo,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "ที่ของหนังสือ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txtdate = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focusDate,
      controller: txtDate,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "วันที่ตั้งเรื่อง",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onTap: () {
        DateTime dt = DateTime.now();
        int dn = dt.year - 5;
        DateTime ystart = DateTime(dn);
        dn = dt.year + 10;
        DateTime yend = DateTime(dn);

        showDatePicker(
                context: context,
                initialDate: now.DateTimeNow(),
                firstDate: ystart,
                lastDate: yend)
            .then((value) {
          if (value != null) {
            setState(() {
              DateString = now.ConvertDateThaiNow(value);
              //DateReal = now.ConvertDateDB(value);
            });

            txtDate.text = DateString;
            //txtHideDate.text = DateReal;
          }
        });
      },
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_response_person = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtResponse,
      readOnly: true,
      keyboardType: TextInputType.none,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightyellow2,
          hintText: "ผู้รับผิดชอบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    //======widget ddl=================
    /*
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
                //focusNode: ddlNode,
                //autofocus: true,
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
                //value: sel_unit,
                onChanged: (un) {
                  setState(() {
                    //sel_unit = un!;
                    unitNow = un!;
                  });

                  //var msg = new ResponseMessage();
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
                dropdownColor: lightpurple2,
                //focusColor: Colors.yellow.shade100,
                icon: Icon(Icons.arrow_drop_down_circle),
                iconDisabledColor: Colors.red,
                iconEnabledColor: Colors.blue,
                iconSize: 35,
              );
          });
    }
*/
//==========DDL================================
    final ddlTypeJob = DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: sel_type_job,
      items: itemTypeJob.map((item) {
        //int index = itemTypeJob.indexOf(item);
        return DropdownMenuItem<String>(
          child: Text('$item'),
          value: item,
          //value: index,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          sel_type_job = value!;
        });
      },
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      style: TextStyle(
          color: Colors.green.shade900,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      //style: styleLabel,
      dropdownColor: Colors.grey.shade200,
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 35,
    );

    final ddlAcc = DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: sel_acc,
      items: itemAcc.map((item) {
        int index = itemAcc.indexOf(item);
        return DropdownMenuItem<int>(
          child: Text('$item'),
          value: index,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          sel_acc = value!;
        });
      },
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      style: TextStyle(
          color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
      //style: styleLabel,
      dropdownColor: Colors.grey.shade200,
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 35,
    );

    final ddlSecret = DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: sel_secret,
      items: itemSecret.map((item) {
        int index = itemSecret.indexOf(item);
        return DropdownMenuItem<int>(
          child: Text('$item'),
          value: index,
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          sel_secret = value!;
        });
      },
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      style: TextStyle(
          color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
      //style: styleLabel,
      dropdownColor: Colors.yellow.shade100,
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 35,
    );

//=======widget button===========
    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          if (txtTitle.text.isEmpty ||
              txtBookNo.text.isEmpty ||
              txtAmout.text == "0" ||
              txtDate.text.isEmpty ||
              txtResponse.text.isEmpty ||
              //unitNow == null ||
              txt_unit == "" ||
              sel_type_job == "กรุณาเลือกประเภทงาน" ||
              //(unitNow == null || unitNow!.isEmpty) ||
              txtYear.text.isEmpty ||
              txtIdExpSpen.text.isEmpty) // add years , id_exp_spen
          {
            // if (_file != null) {
            //   FileName = _file!.path;
            //   FileName = FileName.replaceAll(RegExp(r'.*/'), '');
            // } else {
            //   FileName = "";
            // }
            // print("file : " + FileName);

            msgStr = "กรุณากรอกข้อมูลให้ครบถ้วน !!!";
            msg.Alert(context, "Error", msgStr);
          } else {
            //=======================save===========================================

            //txtDate.text = now.ConvDateThaiToDateDB(txtDate.text);
            String dateDB = now.ConvDateThaiToDateDB(txtDate.text);
            print("date format db : " + dateDB);

            String fmtCommaStr = "r'[\,]";
            RegExp fmtCommaRegExp = RegExp(fmtCommaStr);
            //const fmtMoneyDisp = "r'^(\d+)(?:\.|\,)\d{0,2}";

            //String fmt = txtAmout.text.replaceAll(RegExp(r'[\,]+'), '');
            String fmt = txtAmout.text.replaceAll(fmtCommaRegExp, '');

            // cut only filename
            if (_file != null) {
              FileName = _file!.path;
              FileName = FileName.replaceAll(RegExp(r'.*/'), '');
            } else {
              FileName = "";
            }
            print("file : " + FileName);

            mydb.AddBookUnit(
              txtYear.text,
              txtIdExpSpen.text,
              txtListName.text,
              txtTitle.text,
              txtBookNo.text,
              //txtAmout.text,
              FileName,
              fmt,
              dateDB,
              //txtDate.text,
              ddlSecret.value.toString(),
              ddlAcc.value.toString(),
              txtResponse.text,
              txt_unit,
              unitName,
              //unitNow.toString(), // send to other unit
              sel_type_job,
            ).then((String result) {
              var ret = json.decode(result);

              //String msgstr = "";
              if (ret["result"] == "false") {
                msgStr = "ผิดพลาดในการบันทึก : ${ret["msg"]} ";
              } else if (ret["result"] == "true") {
                msgStr = "บันทึกเรียบร้อยแล้ว";
                print("Status Insert : $msgStr");

                //create QR CODE by PHP in budget1 send url from ret["msg"]
                String id_exp_spen = ret["msg"];

                mydb.SentURLQRCODE(id_exp_spen, "budget1").then((value) {
                  print("Value Return : \n" + value);

                  //   int ret = int.parse(value);
                  //   if (ret == 0) {
                  //     print('Error Create QR Code !!!');
                  //   } else
                  //     print('Create QR Code Complete !!!');
                });

                if (_file != null) {
                  //upc.UploadFileToServer(_file, "budget1").then((value) {
                  upc.UploadFToSrvAddProp(
                    _file,
                    "budget1",
                    txtIdExpSpen.text,
                  ).then((value) {
                    print("return upload msg : \n" + value);

                    if (value != "") {
                      var ret = json.decode(value);

                      if (ret["result"] == true) {
                        print("Upload File Successful \n FileName : " +
                            ret["msg"]);
                      } else {
                        print("Error Upload File \n FileName : " + ret["msg"]);
                      }
                    } else {
                      print("Error Upload File");
                    }
                  });
                }
              }

              msg.Alert(context, "ผลการบันทึก", "ผลคือ : ${msgStr}");

              // GetExpUserSend.php for show last start 10 send
              // final oneSecond = Duration(seconds: 1);
              // Future.delayed(oneSecond * 2, () {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => ShowStartBook(),
              //     ),
              //   );
              // });
            });
          }
        },
        child: Text("เริ่มส่ง",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final selFileButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: blue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width / 5,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          upc.getFile().then((value) {
            setState(() {
              _file = value;
            });
          });
        },
        child: Text("เลือกแฟ้ม",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.redAccent,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("ย้อนกลับ",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    //======init data=======

    mydb.getExpDetail(widget.id_exp_spen).then((Expedite? result) {
      if (result != null) {
        txtListName.text = result.list_exp_spen;
        txtIdExpSpen.text = widget.id_exp_spen;
      }
      //txtMemo.text = result.memo_th;

      //txtBorder.text = result.mborder;
      //txtMalloc.text = result.malloc;

      //MoneyFormatterOutput fo = FlutterMoney(amount: double.parse(result.mborder)).output;
      //txtBorder.text = fo.nonSymbol;

      //fo = FlutterMoney(amount: double.parse(result.malloc)).output;
      //txtMalloc.text = fo.nonSymbol;
    });

//=====defined coding=====
    //txtAmout.text = "0";
    //txtResponse.text = fullname;

    //print(fullname);
    //print(unitStr);
    //_focus.requestFocus();
    //FocusScope.of(context).requestFocus(_focus);

    //========Scaffold======
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "หน่วยต้นเรื่องเริ่มบันทึก",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text('รายละเอียดงบที่บันทึก', style: styleHead),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ประจำปีงบประมาณ',
                      style: styleHead.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  Text(' $yearNow',
                      style: styleHead.copyWith(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txtlistname,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txttitle,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txtbookno,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txt_amout,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txtdate,
            ),

            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(_file?.path ?? '', style: styleHeadWhite3),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: selFileButton,
            ),

            //hidden TextField
            //Visibility(visible: false, child: txt_hide_bookdate),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'เลือกชั้นความลับ',
                      style: styleHead,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow.shade100,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ddlSecret,
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'เลือกความเร่งด่วน',
                      style: styleHead,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ddlAcc,
                        )),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(4.0),
            //   child:
            //   Row(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Text(
            //           'เลือกหน่วยรับ',
            //           style: styleHead,
            //         ),
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(4.0),
            //         child: Container(
            //           //width: 250,
            //           child: Padding(
            //             padding: const EdgeInsets.all(2.0),
            //             child: ddlUnit(unitList),
            //           ),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: lightpurple2,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'เลือกประเภทงาน',
                    style: styleHead,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    child: ddlTypeJob,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: txt_response_person,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: saveButton,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: backButton,
            ),
          ],
        ),
      ),
    );
  }
}
