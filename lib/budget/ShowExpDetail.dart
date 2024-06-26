import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/flutter_money.dart';
import '../global/MySQLService.dart';
import '../models/Expedite.dart';
import '../global/globalVar.dart';
import '../global/ResponseMessage.dart';
import '../global/GetYearBudget.dart';
import '../styles/TextStyle.dart';

class ShowExpDetail extends StatefulWidget {
  final String id_exp_spen;

  const ShowExpDetail({super.key, required this.id_exp_spen});

  @override
  _ShowBudgetDetailState createState() => _ShowBudgetDetailState();
}

class _ShowBudgetDetailState extends State<ShowExpDetail> {
  _ShowBudgetDetailState() {}
//=====Controller Text===========
  final txtListName = TextEditingController();
  final txtMBorder = TextEditingController();
  final txtMemo = TextEditingController();
  final txtMalloc = TextEditingController();
  final txtIdList = TextEditingController();
  final txtStatus = TextEditingController();
  final txtDaystart = TextEditingController();
  final txtDaystop = TextEditingController();
  final txtIdExpSpen = TextEditingController();
  final txtCodeBudRtarf = TextEditingController();
  final txtFieldWork = TextEditingController();
  final txtExpType = TextEditingController();
  final txtIntGroup = TextEditingController();
  final txtUnitUse = TextEditingController();
  final txtUnitOper = TextEditingController();
  final txtBudType = TextEditingController();
  final txtMpay = TextEditingController();
  final txtBpay_n = TextEditingController();
  final txtBpay = TextEditingController();
  final txtCpay = TextEditingController();
  final txtDpay = TextEditingController();
  final txtSpay = TextEditingController();
  final txtSpay_n = TextEditingController();
  final txtOpay = TextEditingController();
  final txtTpay = TextEditingController();
  final txtTlpay = TextEditingController();
  final txtStpay = TextEditingController();
  final txtBalan = TextEditingController();
  final txtYears = TextEditingController();
  final txtM10 = TextEditingController();
  final txtM11 = TextEditingController();
  final txtM12 = TextEditingController();
  final txtSum1 = TextEditingController();
  final txtM01 = TextEditingController();
  final txtM02 = TextEditingController();
  final txtM03 = TextEditingController();
  final txtSum2 = TextEditingController();
  final txtM04 = TextEditingController();
  final txtM05 = TextEditingController();
  final txtM06 = TextEditingController();
  final txtSum3 = TextEditingController();
  final txtM07 = TextEditingController();
  final txtM08 = TextEditingController();
  final txtM09 = TextEditingController();
  final txtSum4 = TextEditingController();
  final txtStwork = TextEditingController();
  final txtWhocreate = TextEditingController();
  final txtCreatetime = TextEditingController();
  final txtWhouse = TextEditingController();
  final txtLastaccess = TextEditingController();
  final txtUnit_chk = TextEditingController();
  final txtStRx = TextEditingController();
  final txtStMalloc = TextEditingController();

//===========Format Money======================
  //static const currencyRegExp = r'^(\d+)(?:\.|\,)\d{0,2}$';

// ==== set caption to Text====
  int yearNow = 0;

  @override
  void initState() {
    super.initState();

    //=====init Data=================
    GetYearBudget yb = new GetYearBudget();
    yearNow = yb.getYearBudget();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // @override
  // void didUpdateWidget(covariant ShowExpDetail oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   KeyboardUtil.hideKeyboard(context);
  // }

  @override
  Widget build(BuildContext context) {
//====TextStyle========
    TextStyle styleHead = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    );

//styleCustom("", 16.0, Colors.redAccent.shade700, true)

    TextStyle styleHead3 =
        styleCustom("", 16.0, Colors.redAccent.shade700, true);

    TextStyle styleInput = const TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.black,
    );

    //======define widget=======
    final txtlistname = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtListName,
      readOnly: true,
      //textAlign: TextAlign.right,
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

    final txt_mborder = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMBorder,
      readOnly: true,
      textAlign: TextAlign.right,
      //keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "กรอบวงเงิน",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txtmalloc = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMalloc,
      readOnly: true,
      textAlign: TextAlign.right,
      //keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_idlist = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtIdList,
      readOnly: true,
      textAlign: TextAlign.right,
      //keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final txt_memo_th = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMemo,
      readOnly: true,
      textAlign: TextAlign.right,
      //keyboardType: TextInputType.number,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
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
      readOnly: true,
      textAlign: TextAlign.right,
      //keyboardType: TextInputType.number,

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
      //focusNode: _focus,
      controller: txtDaystart,
      //keyboardType: TextInputType.number,
      readOnly: true,
      textAlign: TextAlign.right,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_daystop = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtDaystop,
      //keyboardType: TextInputType.number,
      readOnly: true,
      textAlign: TextAlign.right,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_id_exp_spen = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtIdExpSpen,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_code_bud_rtarf = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtCodeBudRtarf,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_field_work = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtFieldWork,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_exp_type = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtExpType,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_int_group = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtIntGroup,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_unit_use = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtUnitUse,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_unit_oper = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtUnitOper,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final txt_bud_type = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtBudType,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_malloc = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMalloc,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_mpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtMpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_bpay_n = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtBpay_n,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_bpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtBpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_cpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtCpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_dpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtDpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_spay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_spay_n = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSpay_n,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_opay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtOpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_tpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtTpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_tlpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtTlpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_stpay = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStpay,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_balan = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtBalan,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_years = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtYears,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m10 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM10,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m11 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM11,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m12 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM12,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_sum1 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSum1,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m01 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM01,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m02 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM02,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m03 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM03,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_sum2 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSum2,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m04 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM04,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m05 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM05,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m06 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM06,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_sum3 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSum3,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m07 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM07,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m08 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM08,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_m09 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtM09,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_sum4 = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtSum4,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_stwork = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStwork,
      //keyboardType: TextInputType.number,
      //inputFormatters: [
      //FilteringTextInputFormatter.digitsOnly,
      //FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
      //currencyFormatter,
      //],
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      readOnly: true,
      //textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_whocreate = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtWhocreate,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_createtime = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtCreatetime,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_whouse = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtWhouse,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_lastaccess = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtLastaccess,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_unit_chk = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtUnit_chk,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_st_rx = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStRx,
      readOnly: true,
      minLines: 1, // Display at least 5 lines
      maxLines: null,
      //textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );
    final txt_st_malloc = TextField(
      style: styleInput,
      //autofocus: true,
      //focusNode: focusNode,
      //focusNode: _focus,
      controller: txtStMalloc,
      //keyboardType: TextInputType.number,

      readOnly: true,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final backButon = Material(
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
    MySQLDB mydb = MySQLDB();
    mydb.getExpDetail(widget.id_exp_spen).then((Expedite? result) {
      if (result != null) {
        txtListName.text = result.list_exp_spen;
        txtMemo.text = result.memo_th;

        MoneyFormatterOutput fo = FlutterMoney(amount: result.mborder).output;
        txtMBorder.text = fo.nonSymbol;
        //txtMBorder.text = fo.symbolOnRight.toString();
        //txtMBorder.text = result.mborder.toString();
        //txtMalloc.text = result.malloc.toString();

        fo = FlutterMoney(amount: result.malloc).output;
        txtMalloc.text = fo.nonSymbol.toString();
        //txtMalloc.text = fo.symbolOnRight.toString();

        txtIdList.text = result.idlist.toString();
        txtStatus.text = result.status.toString();
        txtDaystart.text = result.daystart;
        txtDaystop.text = result.daystop;
        txtIdExpSpen.text = result.id_exp_spen;
        txtCodeBudRtarf.text = result.code_bud_rtarf;
        txtFieldWork.text = result.field_work.toString();
        txtExpType.text = result.exp_type.toString();
        txtIntGroup.text = result.int_group.toString();
        txtUnitUse.text = result.unit_use.toString();
        txtUnitOper.text = result.unit_oper.toString();
        txtBudType.text = result.bud_type.toString();

        fo = FlutterMoney(amount: result.mpay).output;
        txtMpay.text = fo.nonSymbol.toString();
        //txtMpay.text = result.mpay.toString();

        txtBpay_n.text = result.bpay_n.toString();
        txtBpay.text = result.bpay.toString();
        txtCpay.text = result.cpay.toString();
        txtDpay.text = result.dpay.toString();

        fo = FlutterMoney(amount: result.spay).output;
        txtSpay.text = fo.nonSymbol.toString();
        //txtSpay.text = result.spay.toString();

        txtSpay_n.text = result.spay_n.toString();
        txtOpay.text = result.opay.toString();
        txtTpay.text = result.tpay.toString();
        txtTlpay.text = result.tlpay.toString();
        txtStpay.text = result.stpay.toString();
        txtBalan.text = result.balan.toString();
        txtYears.text = result.years.toString();
        txtM10.text = result.m10.toString();
        txtM11.text = result.m11.toString();
        txtM12.text = result.m12.toString();
        txtSum1.text = result.sum1.toString();
        txtM01.text = result.m01.toString();
        txtM02.text = result.m02.toString();
        txtM03.text = result.m03.toString();
        txtSum2.text = result.sum2.toString();
        txtM04.text = result.m04.toString();
        txtM05.text = result.m05.toString();
        txtM06.text = result.m06.toString();
        txtSum3.text = result.sum3.toString();
        txtM07.text = result.m07.toString();
        txtM08.text = result.m08.toString();
        txtM09.text = result.m09.toString();
        txtSum4.text = result.sum4.toString();
        txtStwork.text = result.stwork;
        txtWhocreate.text = result.whocreate.toString();
        txtCreatetime.text = result.createtime;
        txtWhouse.text = result.whouse.toString();
        txtLastaccess.text = result.lastaccess;
        txtUnit_chk.text = result.unit_chk;
        txtStRx.text = result.st_rx;
        txtStMalloc.text = result.st_malloc.toString();
      }
    });

    //========Scaffold======
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "รายละเอียดงบประมาณ",
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
                child: Text('รายละเอียดงบประมาณ', style: styleHead),
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
                        width: 90, child: Text('ชื่องบ', style: styleHead3)),
                    Container(
                        child: txtlistname,
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
                        width: 90, child: Text('รหัสอักษร', style: styleHead3)),
                    Container(
                        child: txt_memo_th,
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
                      width: 90,
                      child: Text('กรอบวงเงิน', style: styleHead3),
                      // Text('กรอบวงเงิน',
                      //     style: styleCustom(
                      //         "", 16.0, Colors.redAccent.shade700, true))
                    ),
                    Container(
                        child: txt_mborder,
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
                        width: 90, child: Text('จัดสรร', style: styleHead3)),
                    Container(
                        child: txtmalloc,
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
                        width: 90, child: Text('สถานะงาน', style: styleHead3)),
                    Container(
                        child: txt_status,
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
                        width: 90, child: Text('วันเริ่ม', style: styleHead3)),
                    Container(
                        child: txt_daystart,
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
                        width: 90,
                        child: Text('วันสิ้นสุด', style: styleHead3)),
                    Container(
                        child: txt_daystop,
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
                        width: 90,
                        child: Text('รหัสงบ บก.', style: styleHead3)),
                    Container(
                        child: txt_code_bud_rtarf,
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
                        width: 90, child: Text('สายงาน', style: styleHead3)),
                    Container(
                        child: txt_field_work,
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
                        width: 90, child: Text('ประเภทงบ', style: styleHead3)),
                    Container(
                        child: txt_exp_type,
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
                        width: 90, child: Text('กลุ่มงาน', style: styleHead3)),
                    Container(
                        child: txt_int_group,
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
                        width: 90, child: Text('ประเภทงบ', style: styleHead3)),
                    Container(
                        child: txt_bud_type,
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
                        width: 90, child: Text('หน่วยใช้', style: styleHead3)),
                    Container(
                        child: txt_unit_use,
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
                        width: 85,
                        child: Text('หน่วยปฏิบัติ', style: styleHead3)),
                    Container(
                        child: txt_unit_oper,
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
                        width: 90,
                        child: Text('เงินสั่งจ่าย', style: styleHead3)),
                    Container(
                        child: txt_mpay,
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
                        width: 105,
                        child: Text('ขอใช้ไม่มีรหัส', style: styleHead3)),
                    Container(
                        child: txt_bpay_n,
                        width: MediaQuery.of(context).size.width * 0.7

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
                        width: 85,
                        child: Text('ขอใช้มีรหัส', style: styleHead3)),
                    Container(
                        child: txt_bpay,
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
                        width: 90, child: Text('ผูกพัน', style: styleHead3)),
                    Container(
                        child: txt_cpay,
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
                        width: 90, child: Text('วางเบิก', style: styleHead3)),
                    Container(
                        child: txt_dpay,
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
                        width: 90, child: Text('เบิกจ่าย', style: styleHead3)),
                    Container(
                        child: txt_spay,
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
                        width: 90,
                        child: Text('เบิกจ่ายไม่มีรหัส', style: styleHead3)),
                    Container(
                        child: txt_spay_n,
                        width: MediaQuery.of(context).size.width * 0.72

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
                        width: 90, child: Text('OPAY', style: styleHead3)),
                    Container(
                      child: txt_opay,
                      width: MediaQuery.of(context).size.width * 0.70,

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
                        width: 90, child: Text('TPAY', style: styleHead3)),
                    Container(
                        child: txt_tpay,
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
                        width: 90, child: Text('TLPAY', style: styleHead3)),
                    Container(
                        child: txt_tlpay,
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
                        width: 90, child: Text('ส่งคืน', style: styleHead3)),
                    Container(
                        child: txt_stpay,
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
                        width: 90, child: Text('คงเหลือ', style: styleHead3)),
                    Container(
                        child: txt_balan,
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
                        width: 90, child: Text('ปีงบ', style: styleHead3)),
                    Container(
                        child: txt_years,
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
                        width: 90, child: Text('งบ ต.ค.', style: styleHead3)),
                    Container(
                        child: txt_m10,
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
                        width: 90, child: Text('งบ พ.ย.', style: styleHead3)),
                    Container(
                        child: txt_m11,
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
                        width: 90, child: Text('งบ ธ.ค.', style: styleHead3)),
                    Container(
                        child: txt_m12,
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
                        width: 90,
                        child: Text('ยอดรวมไตรมาสที่ 1', style: styleHead3)),
                    Container(
                        child: txt_sum1,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน ม.ค.', style: styleHead3)),
                    Container(
                        child: txt_m01,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน ก.พ.', style: styleHead3)),
                    Container(
                        child: txt_m02,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน มี.ค.', style: styleHead3)),
                    Container(
                        child: txt_m03,
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
                        width: 90,
                        child: Text('ยอดรวมไตรมาสที่ 2', style: styleHead3)),
                    Container(
                        child: txt_sum2,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน เม.ย.', style: styleHead3)),
                    Container(
                        child: txt_m04,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน พ.ค.', style: styleHead3)),
                    Container(
                        child: txt_m05,
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
                        width: 90,
                        child: Text('งบเดือน มิ.ย.', style: styleHead3)),
                    Container(
                        child: txt_m06,
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
                        width: 90,
                        child: Text('ยอดรวมไตรมาสที่ 3', style: styleHead3)),
                    Container(
                        child: txt_sum3,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน ก.ค.', style: styleHead3)),
                    Container(
                        child: txt_m07,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน ส.ค.', style: styleHead3)),
                    Container(
                        child: txt_m08,
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
                        width: 90,
                        child: Text('แผนเบิกเดือน ก.ย.', style: styleHead3)),
                    Container(
                        child: txt_m09,
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
                        width: 90,
                        child: Text('ยอดรวมไตรมาสที่ 4', style: styleHead3)),
                    Container(
                        child: txt_sum4,
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
                        width: 90,
                        child: Text('สถานะการปฏิบัติ', style: styleHead3)),
                    Container(
                        child: txt_stwork,
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
                        width: 90,
                        child: Text('รหัสผู้สร้าง', style: styleHead3)),
                    Container(
                        child: txt_whocreate,
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
                        width: 90,
                        child: Text('วัน-เวลา ที่สร้าง', style: styleHead3)),
                    Container(
                        child: txt_createtime,
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
                        width: 90,
                        child: Text('ใครรับผิดชอบ', style: styleHead3)),
                    Container(
                        child: txt_whouse,
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
                        width: 90,
                        child: Text('วัน-เวลา ปรับปรุง', style: styleHead3)),
                    Container(
                        child: txt_lastaccess,
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
                        width: 90,
                        child:
                            Text('หน่วยงานใดกำลังปฏิบัติ', style: styleHead3)),
                    Container(
                        child: txt_unit_chk,
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
                        width: 90,
                        child: Text('สถานะการปฏิบัติ', style: styleHead3)),
                    Container(
                        child: txt_st_rx,
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
                        width: 90,
                        child: Text('สถานะจัดสรร', style: styleHead3)),
                    Container(
                        child: txt_st_malloc,
                        width: MediaQuery.of(context).size.width * 0.70

                        //width: 350,
                        ),
                  ],
                ),
              ),
              backButon,
            ],
          ),
        ),
      ),
    );
  }
}
