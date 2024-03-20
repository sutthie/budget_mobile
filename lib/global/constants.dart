import 'package:flutter/material.dart';
import 'size_config.dart';

final bPrimaryColor = Colors.orange.shade800;
const bPrimaryLightColor = Color(0xFFFFECDF);
final bPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Colors.orange.shade500, Colors.orange.shade800],
);
const bSecondaryColor = Color(0xFF979797);
const bTextColor = Color(0xFF757575);

const bAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  //color: Colors.black,
  color: Colors.red,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String bEmailNullError = "กรุณาป้อนอีเมล์ !!!";
const String bInvalidEmailError = "กรอกอีเมล์ไม่ถูกต้อง !!!";
const String bPassNullError = "กรุณาป้อนรหัสผ่าน !!!";
const String bShortPassError = "รหัสผ่านสั้นเกินไป !!!";
const String bUserIDNullError = "กรุณาป้อน UserID !!!";
const String bShortUserIDError = "UserID สั้นเกินไป !!!";
const String bMatchPassError = "รหัสผ่านไม่ตรงกัน !!!";
const String bNameNullError = "โปรดป้อนชื่อ-นามสกุล";
const String bShortNameError = "ชื่อ-นามสกุล สั้นเกินไป !!!";
const String bPhoneNumberNullError = "โปรดป้อนเบอร์โทรศัพท์ !!!";
const String bPhoneNumberShortError = "เบอร์โทรศัพท์สั้นเกินไป !!!";
const String bAddressNullError = "โปรดป้อนที่อยู่ของคุณ !!!";
const String bAddressShortError = "ที่อยู่ของคุณสั้นเกินไป !!!";
const String bDateNullError = "กรุณาเลือกวันที่ !!!";
const String bShortDateError = "วันที่สั้นเกินไป !!!";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: bTextColor),
  );
}
