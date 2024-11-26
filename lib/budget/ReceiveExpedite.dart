// ignore_for_file: prefer_const_constructors, file_names
import 'dart:convert';
import 'package:budget_mobile/models/TBStatusSearch.dart';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../MainPageAdmin.dart';
import '../download/OpenUrlBrowser.dart';
import '../global/MySQLService.dart';
import '../global/globalVar.dart';
import '../global/DateTimes.dart';
import '../global/FormatMoney.dart';
import '../global/ResponseMessage.dart';
// import '../global/GetYearBudget.dart';
import '../styles/TextStyle.dart';
import '../global/ManageLogin.dart';
import 'SendTbStatusBetweenUnit.dart';
import 'ShowReceiveExpedite.dart';

var login;

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
  String uid = "0";
// download file attach original
  late OpenUrlBrowser open;
//=====Controller Text===========
  final txtIdExpen = TextEditingController();
  final txtListExpen = TextEditingController();
  final txtTitle = TextEditingController();
  final txtDocUnitNo = TextEditingController();
  final txtDocUnit = TextEditingController();
  final txtUnitSend = TextEditingController();
  final txtAmout = TextEditingController();
  final txtDateSend = TextEditingController();
  final txtDateSendReal = TextEditingController();
  final txtStatus = TextEditingController();
  final txtNoDocRx = TextEditingController();
  final txtStRX = TextEditingController();
  final txtETC = TextEditingController();
  final txtUnit_chk = TextEditingController();
  final txtSender = TextEditingController();
  final txtResponse = TextEditingController();

//===== define FocusNode=======
  // final FocusNode _focus = FocusNode();
  final FocusNode _focus_no_doc_rx = FocusNode();
  final FocusNode _focus_status = FocusNode();
  final FocusNode _focus_etc = FocusNode();

//=======defind variable==================
  late DateTimes now = DateTimes();
  String DateString = "";
//======const ===========================
  ////currencyRegExp = r'^(\d+)?\.?\d{0,2}$';
  static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';
  final currencyFormatter =
      FilteringTextInputFormatter.allow(RegExp(currencyRegExp));

  // ==== set caption to Text====
  //int yearNow = 0;

// =====set Message==========
  String msgStr = "";

  _ShowBudgetDetailState() {
    // initHive Box Name : LoginData
    ManageLogin _login = ManageLogin();
    _login.DefineBox().then((box) {
      login = box;
      txtResponse.text = login.get('fullname').toString();
      uid = login.get('uid');
    });
  }

  @override
  void initState() {
    super.initState();

    msg = ResponseMessage();
    mydb = MySQLDB();

    open = OpenUrlBrowser();

    //=====init Data=================
    // GetYearBudget yb = new GetYearBudget();
    // yearNow = yb.getYearBudget();

    //txtIdExpen.text = widget.tbstatus.id_exp_spen;
    // print("id_exp_spen : ${widget.tbstatus.id_exp_spen}");

    txtListExpen.text = widget.tbstatus.list_exp_spen;
    txtTitle.text = widget.tbstatus.title;
    txtAmout.text = FormatMoney.setFormat(double.parse(widget.tbstatus.amout));
    txtDocUnitNo.text = widget.tbstatus.doc_unit_no;

    // file attach
    txtDocUnit.text = widget.tbstatus.doc_unit;
    txtDateSend.text = widget.tbstatus.date_sent_to;
    txtDateSendReal.text = widget.tbstatus.date_sent_real;
    txtUnitSend.text = widget.tbstatus.unit_send_name;
    txtStatus.text = widget.tbstatus.status_work;
    txtStRX.text = widget.tbstatus.status_detail;
    txtSender.text = widget.tbstatus.sender;
    txtETC.text = widget.tbstatus.etc;
    txtNoDocRx.text = widget.tbstatus.no_doc_rx;

    _focus_no_doc_rx.requestFocus();
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
    // final txt_id_exp_spen = TextField(
    //   controller: txtIdExpen,
    // );

    final txt_list_exp_spen = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: _focus,
      // focusNode: _focus,
      controller: txtListExpen,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: lightpurple2,
          hintText: "รหัสงบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      // onTap: () {
      //   _focus.requestFocus();
      // },
      // onSubmitted: (v) {
      //   //_fieldFocusChange(context, _focus, _nextFocus);
      // },
    );

    final txt_title = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: _focus,
      //focusNode: _focus,
      controller: txtTitle,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: lightpurple2,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_amout = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: _focus,
      //focusNode: _focus,
      controller: txtAmout,
      // minLines: 1, // Display at least 5 lines
      // maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          //filled : false,
          fillColor: lightpurple2,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_doc_unit_no = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtDocUnitNo,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          //hintText: "ชื่องบ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_doc_unit = TextField(
      style: styleLinkNormal(Colors.blue),
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtDocUnit,
      //keyboardType: TextInputType.number,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onTap: () {
        //print(txtDocUnit.text);

        String urlPath = 'http://10.130.230.64/budget1/Follow/doc/';

        //call launchURL(urlStr, fileName)
        //String fullUrl = urlStr + Uri.encodeComponent(fileName);
        //url = "http://$ipAddress/$Budget_Site/Follow/doc/$FileNameOriginal";

        open.launchURL(urlPath, txtDocUnit.text);
      },
    );

    final txt_unit_send = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtUnitSend,
      //keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_date_send = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      // focusNode: _focusDayStart,
      controller: txtDateSend,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_date_send_real = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      // focusNode: _focusDayStart,
      controller: txtDateSendReal,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_status = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStatus,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_no_doc_rx = TextField(
      style: styleInput,
      autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_no_doc_rx,
      controller: txtNoDocRx,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "เลขที่หนังสือรับ",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      // onChanged: (val) {
      //   // _focus_no_doc_rx.requestFocus();
      //   if (_focus_no_doc_rx.hasFocus) {
      //     print("TextField is focused");
      //   } else {
      //     print("TextField is not focused");
      //   }
      // },
      // onSubmitted: (v) {
      //   //_fieldFocusChange(context, _focus, _nextFocus);
      // },
    );

    final txt_status_rx = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_status,
      controller: txtStRX,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_etc = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      focusNode: _focus_etc,
      controller: txtETC,
      //keyboardType: TextInputType.number,
      // inputFormatters: [
      //   //FilteringTextInputFormatter.digitsOnly,
      //   //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //   currencyFormatter,
      // ],
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    // final txt_daystart = TextField(
    //   style: styleInput,
    //   //autofocus: true,
    //   //focusNode: focusNode,
    //   focusNode: _focusDayStart,
    //   controller: txtDaystart,
    //   decoration: InputDecoration(
    //       contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //       filled: true,
    //       fillColor: Colors.white,
    //       hintText: "วันที่เริ่ม",
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    //   onTap: () {
    //     DateTime dt = DateTime.now();
    //     int dn = dt.year - 5;
    //     DateTime ystart = DateTime(dn);
    //     dn = dt.year + 10;
    //     DateTime yend = DateTime(dn);

    //     showDatePicker(
    //             context: context,
    //             initialDate: now.DateTimeNow(),
    //             firstDate: ystart,
    //             lastDate: yend)
    //         .then((value) {
    //       if (value != null) {
    //         setState(() {
    //           DateString = now.ConvertDateThaiNow(value);
    //         });

    //         txtDaystart.text = DateString;
    //       }
    //     });
    //   },
    //   onSubmitted: (v) {
    //     //_fieldFocusChange(context, _focus, _nextFocus);
    //   },
    // );

    // final txt_sender = TextField(
    //   style: styleInput,
    //   //autofocus: true,
    //   //focusNode: focusNode,
    //   //focusNode: _focus,
    //   controller: txtSender,
    //   keyboardType: TextInputType.number,
    //   inputFormatters: [
    //     //FilteringTextInputFormatter.digitsOnly,
    //     //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
    //     currencyFormatter,
    //   ],
    //   decoration: InputDecoration(
    //       contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //       filled: true,
    //       fillColor: lightpurple2,
    //       hintText: "",
    //       border:
    //           OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    // );

    final txt_response_person = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtResponse,
      //keyboardType: TextInputType.number,
      //inputFormatters: [
      //FilteringTextInputFormatter.digitsOnly,
      //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //currencyFormatter,
      //],
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: lightpurple2,
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
          // save tbl_status
          print("no_doc_rx : " + txtNoDocRx.text);
          print("date_rec_rx : " + now.DateNowYMDTime());
          print("id_status : ${widget.tbstatus.id_status}");

          print("id_exp_spen : ${widget.tbstatus.id_exp_spen}");
          print("id_job : ${widget.tbstatus.id_job}");
          print("status detail : " + txtStRX.text);

          //================================================

          print("id_use_int : ${widget.tbstatus.id_use_int}");
          print("sent_to : ${widget.tbstatus.sent_to}");
          print(
              "date_sent_to : ${widget.tbstatus.date_sent_to}"); // time enter by rx unit
          print(
              "date_sent_real : ${widget.tbstatus.date_sent_real}"); // time real by rx unit
          //print("status : " + txtStatus.text);
          //print("date_rec_rx : ${DateTime.now()}"); // time real by rx unit

          print("from unit : ${widget.tbstatus.unit_send_name}");
          print("Current unit name : ${CurrentUnitName}");

          //=======================================================

          if (widget.tbstatus.id_job > 0 &&
              widget.tbstatus.id_exp_spen != "" &&
              widget.tbstatus.id_status > 0 &&
              txtNoDocRx.text.isEmpty == false &&
              txtStatus.text.isEmpty == false) {
            //=======================save===========================================
            String date_rec_rx = now.DateNowYMDTime();
            print("date_rec_rx format db : " + date_rec_rx);

            mydb.ReceiveExpediteUser(
                    txtNoDocRx.text,
                    txtStRX.text,
                    widget.tbstatus.id_exp_spen,
                    widget.tbstatus.id_job.toString(),
                    widget.tbstatus.id_status.toString(),
                    txtETC.text,
                    txtResponse.text)
                .then((String result) {
              var ret = json.decode(result);

              if (ret["result"] == "false") {
                msgStr = "ผิดพลาดในการบันทึก : ${ret["msg"]} ";
              } else if (ret["result"] == "true") {
                msgStr = "บันทึกเรียบร้อยแล้ว";
                print("Status Insert : $msgStr");
              }

              msg.Alert(context, "ผลการบันทึก", "ผลคือ : ${msgStr}");

              // GetExpUserSend.php for show last start 10 send
              final oneSecond = Duration(seconds: 1);
              Future.delayed(oneSecond * 2, () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowReceiveExpedite(login.get('uid')),
                  ),
                );
              });
            });
          } else {
            msgStr = "กรุณากรอกข้อมูลให้ครบถ้วน !!!";
            msg.Alert(context, "Error", msgStr);
          }

          //========================================
        },
        child: Text("บันทึก",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final sentButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blueAccent.shade700,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        highlightColor:
            Colors.blueAccent.shade100, //on press button change color
        onPressed: () {
          if (txtNoDocRx.text != '' && txtStRX.text != '') {
            // go to page send
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SendTbStatusBetweenUnit(
                    id_exp_spen: widget.tbstatus.id_exp_spen,
                    id_job: widget.tbstatus.id_job.toString(),
                    id_status: widget.tbstatus.id_status.toString(),
                    sel_year: widget.tbstatus.years),
              ),
            );
          } else {
            msgStr = "กรุณากรอกข้อมูลให้ครบถ้วน และ ทำการบันทึกก่อนส่ง !!!";
            msg.Alert(context, "Error", msgStr);
          }
        },
        child: Text("หน้าส่ง",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(
                color: Colors.yellow, fontWeight: FontWeight.bold)),
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
          if (uid == '30') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPageAdmin(),
              ),
            );
          } else
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

    // _focus_no_doc_rx.requestFocus();
    //========Scaffold======
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "รายละเอียดงานที่ส่งมา",
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
                    Text('งบประมาณประจำปี',
                        style: styleHead.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('${widget.tbstatus.years}',
                        style: styleHead.copyWith(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                    // Text('$yearNow',
                    //     style: styleHead.copyWith(
                    //         color: Colors.blue[900],
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 16.0)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('วันที่ปัจจุบัน : ${now.DateThaiNow()}',
                    style: styleHeadPurple3),
              ),
              // Visibility(
              //   visible: false,
              //   child: Padding(
              //     padding: const EdgeInsets.all(2.0),
              //     child: txt_list_exp_spen,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 80, child: Text('ชื่องบ', style: styleHead3)),
                    Container(
                        child: txt_list_exp_spen,
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
                        width: 80, child: Text('ชื่องาน', style: styleHead3)),
                    Container(
                        child: txt_title,
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
                        width: 80, child: Text('จำนวนเงิน', style: styleHead3)),
                    Container(
                        child: txt_amout,
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
                        child: Text('ที่ของหนังสือ', style: styleHead3)),
                    Container(
                        child: txt_doc_unit_no,
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
                        child: Text('หน่วยที่ส่ง', style: styleHead3)),
                    Container(
                        child: txt_unit_send,
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
                        child: Text('วันที่หนังสือ', style: styleHead3)),
                    Container(
                        child: txt_date_send,
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
                        child: Text('วัน/เวลา ส่งมา', style: styleHead3)),
                    Container(
                        child: txt_date_send_real,
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
                        width: 80, child: Text('สถานะ', style: styleHead3)),
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
                        width: 80, child: Text('เลขที่รับ', style: styleHead3)),
                    Container(
                        child: txt_no_doc_rx,
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
                        child: txt_status_rx,
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
                        width: 80, child: Text('หมายเหตุ', style: styleHead3)),
                    Container(
                        child: txt_etc,
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
                        width: 80, child: Text('ผู้รับ', style: styleHead3)),
                    Container(
                        child: txt_response_person, //txt_response_person,
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
                        width: 80, child: Text('แฟ้มแนบ', style: styleHead3)),
                    Container(
                        child: txt_doc_unit,
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
                child: sentButton,
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
