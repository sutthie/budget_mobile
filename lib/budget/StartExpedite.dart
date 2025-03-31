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
import 'package:currency_formatter/currency_formatter.dart';
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
  final FocusNode _focus_title = FocusNode();
  final FocusNode _focus_addr_book = FocusNode();
  final FocusNode _focus_amout = FocusNode();
  final FocusNode _focus_date = FocusNode();

  //final FocusNode _focus_ddlSecret = FocusNode();

  //const currencyRegExp = r'^(\d+)?\.?\d{0,2}$';
  static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';
  final currencyFormatter =
      FilteringTextInputFormatter.allow(RegExp(currencyRegExp));

//==========set==fullname=====
  String fullname = "";

// ==== set year====
  int yearNow = 0;

  _ShowBudgetDetailState() {}

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
    //txtAmout.text = "0";

    //_focus.requestFocus();
    //FocusScope.of(context).requestFocus(_focus);

    // _focus.addListener(() {
    //   print("Focus Node Status: ${_focus.hasFocus}");
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Request focus after the context is fully available.
    //_focus.requestFocus();
    //FocusScope.of(context).requestFocus(_focus);
    //FocusScope.of(context).unfocus();
    //SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void dispose() {
    // _focus.removeListener(() {
    //   print("Focus Node Listener Removed");
    // });

// dispose focus
    _focus_title.dispose();
    _focus_addr_book.dispose();
    _focus_amout.dispose();
    _focus_date.dispose();
    //_focus_ddlSecret.dispose();

// dispose Text Controller
    txtTitle.dispose();
    txtAmout.dispose();
    txtBookNo.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //_focus.requestFocus();
    //var widthTextFiled = MediaQuery.of(context).size.width * 0.6;
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
      //key: ValueKey("my_text_field"),
      // inputFormatters: [], // Can help stabilize input connection
      // keyboardType: TextInputType.text,
      // autocorrect: false,
      // enableSuggestions: false,
      style: styleInput,
      autofocus: true,
      focusNode: _focus_title,
      //enabled: true,
      // minLines: 1, // Display at least 5 lines
      // maxLines: null,
      controller: txtTitle,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "ชื่อเรื่อง",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
        _focus_addr_book.requestFocus();
      },
      // onTap: () {
      //   //_focus.requestFocus();
      //   FocusScope.of(context).requestFocus(_focus);
      //   SystemChannels.textInput.invokeMethod('TextInput.show');
      // },
      // onTapOutside: (event) {
      //   // ปิด Focus เมื่อแตะนอก TextField
      //   _focus.unfocus();
      // },
      // onEditingComplete: () {
      //   // จัดการเมื่อแก้ไขเสร็จ
      //   _focus.unfocus();
      // },
    );

    final txt_addr_book = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_addr_book,
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
        _focus_amout.requestFocus();
      },
    );

    final txt_amout = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_amout,
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
      onSubmitted: (v) {
        _focus_date.requestFocus();
      },
    );

    final txtdate = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_date,
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
        //_focus_ddlSecret.requestFocus();
      },
    );

    final txt_response_person = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtResponse,
      readOnly: true,
      //keyboardType: TextInputType.none,
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
    final ddlSecret = DropdownButton(
      //focusNode: _focus_ddlSecret,
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
            String fmtAmout = txtAmout.text.replaceAll(fmtCommaRegExp, '');

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
              fmtAmout,
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
                // create QRCODE in website budget
                mydb.SentURLQRCODE(id_exp_spen, Budget_Site).then((value) {
                  int ret = int.parse(value);
                  if (ret == 0) {
                    print('Error Create QR Code !!!');
                  } else {
                    print("Create QRCode OK=>id_exp_spen : " + id_exp_spen);
                  }
                });

                if (_file != null) {
                  //upc.UploadFileToServer(_file, "budget1").then((value) {
                  upc.UploadFToSrvAddProp(
                    _file,
                    Budget_Site,
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
              final oneSecond = Duration(seconds: 1);
              Future.delayed(oneSecond * 5, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowStartBook(),
                  ),
                );
              });
            });
          }
        },
        child: Text("บันทึก",
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
        child: Form(
          //key: _formKey,
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
                child: txt_addr_book,
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
      ),
    );
  }
}
