import 'dart:convert';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../global/GetUnitName.dart';
import '../../../helper/keyboard.dart';
import '../../../screens/forgot_password/forgot_password_screen.dart';
import '../../../screens/login_success/login_success_screen.dart';
import '../../login_success/login_false_screen.dart';
import '../../../components/default_button.dart';
import '../../../global/constants.dart';
import '../../../global/size_config.dart';
import '../../../global/globalVar.dart';
import '../../../global/MySQLService.dart';

// import 'package:bfriendapp/styles/TextStyle_Bfriend.dart';
var box;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? userid;
  String? password;

  bool? remember = false;
  final List<String?> errors = [];

  final FocusNode focus_userid = FocusNode();
  final FocusNode focus_pwd = FocusNode();
  //final FocusNode buttonLoginFocus = FocusNode();

  MySQLDB mysql = MySQLDB();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    //mysql.FocusChange(context, this.focus_userid, this.focus_userid);
    focus_userid.requestFocus();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(color: lightpurple, child: buildUserIdFormField()),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(color: lightpurple, child: buildPasswordFormField()),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: orange,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text(
                "Remember me",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: Colors.red),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "เข้าระบบ",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                print("userid : " + userid! + "\n");
                print("password : " + password! + "\n");

                //check in database by Rest API PHP

                mysql.chkLoginToken(userid!, password!).then((result) async {
                  String msg = "";

                  if (result.trim() == "") {
                    msg = "Login False!!!";

                    print("Result Authen : ${msg}");

                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, LoginFalseScreen.routeName);
                  } else {
                    //msg = "Login Success!!!";

                    //print("Result Authen : ${msg}");

                    var dat = json.decode(result.trim());
                    // from Node.js Server
                    //   ret = {
                    //   "aid": aid,
                    //   "userid": userid,
                    //   "status": status,
                    //   "token": token
                    // };

                    //Token = dat["token"];
                    //UserID = dat["userid"];
                    //Email = dat["email"];
                    //Aid = dat["aid"];

//=================set Hive for Global Data===================
                    await Hive.initFlutter();
                    box = await Hive.openBox('LoginData');
                    box.put('aid', dat["aid"]);
                    box.put('userid', dat['userid']);
                    box.put('uid', dat['uid']);
                    box.put('fullname', dat['fullname']);
                    box.put('email', dat['email']);
                    box.put('status', dat["status"]);
                    box.put('token', dat["token"]);
//=================Get Unitname===============================
                    String uid = dat['uid'];
                    var unit = GetUnitName();
                    //unitStr = unit.GetUnitStr(uid).toString();
                    unit.GetUnitStr(uid).then((value) {
                      box.put('unitname', value);
                      CurrentUnitName = value;
                    });
//============================================================
                    // print("Aid : " + Aid);
                    // print("UserID : " + UserID);
                    // print("Fullname : " + dat["fullname"]);
                    // print("Status : " + dat["status"]); // user , admin
                    // print("Token : " + Token);

                    // if all are valid then go to success screen
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildUserIdFormField() {
    return TextFormField(
      initialValue: 'test200',
      keyboardType: TextInputType.text,
      focusNode: focus_userid,
      onFieldSubmitted: (ValueKey) => focus_pwd.requestFocus(),
      onSaved: (newValue) => userid = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bUserIDNullError);
        } else if (value.length >= 4) {
          removeError(error: bShortUserIDError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bUserIDNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: bShortUserIDError);
          return "";
        }
        return null;
      },
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(22),
        ),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(25.7),
        // ),
        labelText: "UserID",
        labelStyle: TextStyle(fontSize: 22.0, color: red),
        hintText: "Enter your userid",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      initialValue: 'test200',
      focusNode: focus_pwd,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bPassNullError);
        } else if (value.length >= 6) {
          removeError(error: bShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: bShortPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20.0),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(22),
        ),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 22.0, color: red),
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
