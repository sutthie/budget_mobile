// ignore_for_file: prefer_const_constructors, file_names
import 'package:budget_mobile/models/TBStatusSearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global/MySQLService.dart';
import '../global/globalVar.dart';
import '../global/DateTimes.dart';
import '../global/ResponseMessage.dart';
import '../global/GetYearBudget.dart';
import '../styles/TextStyle.dart';

class ReceiveExpedite extends StatefulWidget {
  final TBStatusSearch tbstatus;

  const ReceiveExpedite({required this.tbstatus});

  @override
  _ShowBudgetDetailState createState() => _ShowBudgetDetailState();
}

class _ShowBudgetDetailState extends State<ReceiveExpedite> {
// =====declare object===========
  late MySQLDB mydb;
  late ResponseMessage msg;
//=====Controller Text===========
  final txtIdExpSpen = TextEditingController();
  final txtListName = TextEditingController();
  final txtStatus = TextEditingController();
  final txtStRX = TextEditingController();
  final txtDaystart = TextEditingController();
  final txtUnit_chk = TextEditingController();
  final txtResponse = TextEditingController();

//===== define FocusNode=======
  final FocusNode _focus = FocusNode();
  final FocusNode _focusDayStart = FocusNode();
  final FocusNode _focusDayStop = FocusNode();

//=======defind variable==================
  late DateTimes now = DateTimes();
  String DateString = "";
//======const ===========================
  ////currencyRegExp = r'^(\d+)?\.?\d{0,2}$';
  static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';
  final currencyFormatter =
      FilteringTextInputFormatter.allow(RegExp(currencyRegExp));

  // ==== set caption to Text====
  int yearNow = 0;

  @override
  void initState() {
    super.initState();

    msg = ResponseMessage();
    mydb = MySQLDB();

    //=====init Data=================
    GetYearBudget yb = new GetYearBudget();
    yearNow = yb.getYearBudget();
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

    TextStyle styleHead3 =
        styleCustom("", 16.0, Colors.redAccent.shade700, true);

    TextStyle styleInput = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.black,
    );

    //======define widget=======

    final txt_id_exp_spen = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: _focus,
      focusNode: _focus,
      controller: txtIdExpSpen,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: Colors.white,
          hintText: "รหัสงบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onTap: () {
        _focus.requestFocus();
      },
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txtlistname = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: _focus,
      //focusNode: _focus,
      controller: txtListName,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: Colors.white,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_st_rx = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStRX,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_status = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStatus,
      keyboardType: TextInputType.number,
      inputFormatters: [
        //FilteringTextInputFormatter.digitsOnly,
        //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
        currencyFormatter,
      ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_daystart = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focusDayStart,
      controller: txtDaystart,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "วันที่เริ่ม",
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

            txtDaystart.text = DateString;
          }
        });
      },
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_unit_chk = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtUnit_chk,
      keyboardType: TextInputType.number,
      inputFormatters: [
        //FilteringTextInputFormatter.digitsOnly,
        //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
        currencyFormatter,
      ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_response_person = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtResponse,
      keyboardType: TextInputType.number,
      inputFormatters: [
        //FilteringTextInputFormatter.digitsOnly,
        //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
        currencyFormatter,
      ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final saveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.deepPurple,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
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

    //MySQLDB mydb = MySQLDB();
    //mydb.getExpDetail(widget.id_exp_spen).then((Expedite? result) {
    // txtIdExpSpen.text = result.id_use_int;
    // txtListName.text = result.list_exp_spen;

    // txtStatus.text = result.status.toString();
    // txtDaystart.text = result.daystart;

    // txtUnit_chk.text = result.unit_chk;
    // txtStRx.text = result.st_rx;
    //});

    //mydb.getTBStatusDetail(widget.id_status).then((TBStatus? result) {
    // txtIdExpSpen.text = result.id_use_int;
    // txtListName.text = result.list_exp_spen;

    // txtStatus.text = result.status.toString();
    // txtDaystart.text = result.daystart;

    // txtUnit_chk.text = result.unit_chk;
    // txtStRx.text = result.st_rx;
    //txtResponse.text = result!.response_person;
    // });

    _focus.requestFocus();
    //========Scaffold======
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "ปรับปรุงข้อมูลงบประมาณ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
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
                padding: const EdgeInsets.all(4.0),
                child: Text('รายละเอียดงาน', style: styleHead),
              ),
              Visibility(
                visible: false,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: txt_id_exp_spen,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 95,
                        child: Text('Id_Exp_Spen', style: styleHead3)),
                    Container(
                        child: txt_id_exp_spen,
                        width: MediaQuery.of(context).size.width * 0.70
                        //width: 350,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80, child: Text('ชื่องบ', style: styleHead3)),
                    Container(
                        child: txtlistname,
                        width: MediaQuery.of(context).size.width * 0.75
                        //width: 350,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80, child: Text('สถานะงาน', style: styleHead3)),
                    Container(
                        child: txt_status,
                        width: MediaQuery.of(context).size.width * 0.75

                        //width: 350,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80, child: Text('วันเริ่ม', style: styleHead3)),
                    Container(
                        child: txt_daystart,
                        width: MediaQuery.of(context).size.width * 0.75

                        //width: 350,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80,
                        child: Text('ใครรับผิดชอบ', style: styleHead3)),
                    Container(
                        child: txt_response_person,
                        width: MediaQuery.of(context).size.width * 0.75

                        //width: 350,
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80,
                        child: Text('สถานะการปฏิบัติ', style: styleHead3)),
                    Container(
                        child: txt_st_rx,
                        width: MediaQuery.of(context).size.width * 0.75

                        //width: 350,
                        ),
                  ],
                ),
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
