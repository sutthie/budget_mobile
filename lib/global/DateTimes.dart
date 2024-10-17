import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:intl/intl.dart';

class DateTimes {
  List<String> MonthTh = [
    "ม.ค.",
    "ก.พ.",
    "มี.ค.",
    "เม.ย.",
    "พ.ค.",
    "มิ.ย.",
    "ก.ค.",
    "ส.ค.",
    "ก.ย.",
    "ต.ค.",
    "พ.ย.",
    "ธ.ค."
  ];

  List<String> MonthThFull = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม"
  ];

  String selyear = "";
  String dateRet = "";
  int dayn = 0, monthn = 0, yearn = 0;

//=========================================================

  DateTime DateTimeNow() {
    DateTime now = DateTime.now();
    return now;
  }

  String DateNowYMD() {
    DateTime now = DateTime.now();

    dayn = now.day;
    monthn = now.month;
    yearn = now.year;

    String dateRet =
        yearn.toString() + "-" + monthn.toString() + "-" + dayn.toString();

    return dateRet;
  }

  String DateNowDDMMYY() {
    DateTime now = DateTime.now();
    //DateFormat thaiDateFormat = DateFormat('dd MMMM yyyy');
    DateFormat DateFormat1 = DateFormat('dd-MM-yyyy');
    dateRet = DateFormat1.format(now);

    return dateRet;
  }

  String DateLongNow() {
    DateTime now = DateTime.now();
    DateFormat DateFormat1 = DateFormat('dd MMMM yyyy');
    //DateFormat DateFormat1 = DateFormat('dd-MM-yyyy');
    dateRet = DateFormat1.format(now);

    return dateRet;
  }

  String DateThaiNow() {
    DateTime now = DateTime.now();

    dayn = now.day;
    monthn = now.month;
    yearn = now.year + 543;

    dateRet = dayn.toString() +
        " " +
        MonthTh[monthn - 1].toString() +
        " " +
        yearn.toString();

    return dateRet;
  }

  String DateThaiNowFull() {
    DateTime now = DateTime.now();

    dayn = now.day;
    monthn = now.month;
    yearn = now.year + 543;

    dateRet = dayn.toString() +
        " " +
        MonthThFull[monthn - 1].toString() +
        " " +
        yearn.toString();

    return dateRet;
  }

  String ConvertDateDB(DateTime dt) {
    dayn = dt.day;
    monthn = dt.month;
    yearn = dt.year;

    dateRet = yearn.toString() +
        " " +
        MonthTh[monthn].toString() +
        " " +
        dayn.toString();

    return dateRet;
  }

  String ConvertDateThaiNow(DateTime now) {
    dayn = now.day;
    monthn = now.month - 1;
    yearn = now.year + 543;

    dateRet = dayn.toString() +
        " " +
        MonthTh[monthn].toString() +
        " " +
        yearn.toString();

    return dateRet;
  }

  String ConvDateThaiToDateDB(String dt) {
    List<String> dtemp = dt.split(" ");

    String dayn = dtemp[0];

    //===========month==============
    String monthn = "";
    switch (dtemp[1]) {
      case "ม.ค.":
        monthn = "1";
        break;
      case "ก.พ.":
        monthn = "2";
        break;
      case "มี.ค.":
        monthn = "3";
        break;
      case "เม.ย.":
        monthn = "4";
        break;
      case "พ.ค.":
        monthn = "5";
        break;
      case "มิ.ย.":
        monthn = "6";
        break;
      case "ก.ค.":
        monthn = "7";
        break;
      case "ส.ค.":
        monthn = "8";
        break;
      case "ก.ย.":
        monthn = "9";
        break;
      case "ต.ค.":
        monthn = "10";
        break;
      case "พ.ย.":
        monthn = "11";
        break;
      case "ธ.ค.":
        monthn = "12";
        break;
    }
    //==============================
    int yearn = int.parse(dtemp[2]) - 543;

    dateRet = yearn.toString() + "-" + monthn + "-" + dayn;

    return dateRet;
  }

  String getMonthThai() {
    String mth = "";
    int iMonth = DateTime.now().month;

    mth = MonthTh[iMonth];

    return mth;
  }

  TextStyle styleLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
    //decorationColor: Colors.yellowAccent.shade100,
    backgroundColor: Colors.white,
  );

  Widget ddlYearNew() {
// init year now
    int yearNow = DateTime.now().year.toInt() + 543;
    List<int> listyear = [for (var i = yearNow - 5; i <= yearNow; i++) i];
    return DropdownButton(
      value: yearNow,
      items: listyear.map((int item) {
        return DropdownMenuItem<int>(
          child: Text(' $item '),
          value: item,
        );
      }).toList(),
      onChanged: (value) {
        selyear = value.toString();
        log(value.toString());
      },
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      //style: TextStyle(color: Colors.green, fontSize: 16),
      style: styleLabel,
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 40,
    );
  }
}
