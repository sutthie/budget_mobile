// ignore_for_file: prefer_const_constructors, file_names
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

class StartExpedite extends StatefulWidget {
  final String id_exp_spen;

  const StartExpedite({super.key, required this.id_exp_spen});

  @override
  _ShowBudgetDetailState createState() => _ShowBudgetDetailState();
}

class _ShowBudgetDetailState extends State<StartExpedite> {
  late MySQLDB mydb;
  late DateTimes now = DateTimes();
  String DateString = "";
  String msgStr = "";
  late Future<List<UnitName>?> unitList;
  late String? unitNow;
//=========data ddl==============
  List<String> itemSecret = ['ปกติ', 'ลับ', 'ลับมาก', 'ลับที่สุด'];
  List<String> itemAcc = ['ปกติ', 'ด่วน', 'ด่วนมาก', 'ด่วนที่สุด'];
  int sel_acc = 0;
  int sel_secret = 0;
  String sel_unit = "";

//=====Controller Text===========
  final txtListName = TextEditingController();
  final txtTitle = TextEditingController();
  final txtBookNo = TextEditingController();
  final txtDate = TextEditingController();
  final txtMoney = TextEditingController();
  final txtResponse = TextEditingController();
  final txtHideDate = TextEditingController();
  // file
  // ddl urgent
  // ddl secret
  // ddl type_job

// define FocusNode
  final FocusNode _focus = FocusNode();
  final FocusNode _focusDate = FocusNode();

  //const currencyRegExp = r'^(\d+)?\.?\d{0,2}$';
  static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';
  final currencyFormatter =
      FilteringTextInputFormatter.allow(RegExp(currencyRegExp));

  // ==== set caption to Text====
  int yearNow = 0;

  @override
  void initState() {
    super.initState();

    mydb = MySQLDB();

    //=====init Data=================
    GetYearBudget yb = new GetYearBudget();
    yearNow = yb.getYearBudget();

    //=====init UNIT Name==============
    unitNow = null;
    unitList = mydb.getUnitList();

    //======init Date to TextField========
    DateString = now.DateThaiNow();
    txtDate.text = DateString;
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
      //focusNode: focusNode,
      focusNode: _focus,
      controller: txtTitle,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "ชื่อเรื่อง",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txtmoney = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMoney,
      // keyboardType: TextInputType.number,
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
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
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
      focusNode: _focusDate,
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
            });

            txtDate.text = DateString;
          }
        });
      },
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_hide_bookdate = TextField(
      controller: txtHideDate,
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txtresponse = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtResponse,
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
          hintText: "ผู้รับผิดชอบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    //======widget ddl=================
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
                //value: unitNow,
                //value: "",
                //value: null,
                onChanged: (un) {
                  setState(() {
                    sel_unit = un!;
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
                iconSize: 30,
              );
          });
    }

//==========================================

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
      iconSize: 40,
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
      iconSize: 40,
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
          var msg = new ResponseMessage();

          if (txtTitle.text.isEmpty ||
              txtBookNo.text.isEmpty ||
              txtMoney.text.isEmpty ||
              txtDate.text.isEmpty ||
              txtResponse.text.isEmpty ||
              sel_unit.isEmpty) {
            msgStr = "กรอกข้อมูลไม่ครบถ้วน!!! \n กรุณาตรวจสอบก่อนบันทึก";
          } else {
            msgStr = "บันทึกเรียบร้อยแล้ว!!! ";
          }

          msg.Alert(context, "Error", msgStr);
          //Navigator.of(context).pop();
        },
        child: Text("บันทึก",
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
    txtMoney.text = "0";

    //_focus.requestFocus();
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
                  Text('ประจำปี',
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
              child: txtmoney,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: txtdate,
            ),
            //hidden TextField
            Visibility(visible: false, child: txt_hide_bookdate),
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
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'เลือกหน่วยรับ',
                      style: styleHead,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      //width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ddlUnit(unitList),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightpurple2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: txtresponse,
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
