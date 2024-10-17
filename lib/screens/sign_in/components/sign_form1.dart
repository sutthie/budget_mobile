import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../helper/keyboard.dart';
import '../../../screens/forgot_password/forgot_password_screen.dart';
import '../../../screens/login_success/login_success_screen.dart';
import '../../login_success/login_false_screen.dart';
import '../../../components/default_button.dart';
import '../../../global/constants.dart';
import '../../../global/size_config.dart';
// import 'package:bfriendapp/global/globalVar.dart';
import '../../../global/MySQLService.dart';

// import 'package:bfriendapp/styles/TextStyle_Bfriend.dart';
var box;

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  final FocusNode focus_email = FocusNode();
  final FocusNode focus_pwd = FocusNode();

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
              color: Colors.lightBlue.shade50, child: buildEmailFormField()),
          SizedBox(height: getProportionateScreenHeight(30)),
          Container(
              color: Colors.lightBlue.shade50, child: buildPasswordFormField()),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: bPrimaryColor,
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
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print("email : " + email! + "\n");
                print("password : " + password! + "\n");

                //check in database by Rest API PHP

                mysql.chkLoginToken(email!, password!).then((result) async {
                  //String msg;

                  if (result.trim() == "") {
                    //msg = "Login False!!!";

                    //print("Result Authen : ${msg}");

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
                    box = await Hive.openBox('GlobalData');
                    box.put('aid', dat["aid"]);
                    box.put('userid', dat['userid']);
                    box.put('uid', dat['uid']);
                    box.put('fullname', dat['fullname']);
                    box.put('email', dat['email']);
                    box.put('status', dat["status"]);
                    box.put('token', dat["token"]);
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      focusNode: focus_pwd,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bPassNullError);
        } else if (value.length >= 8) {
          removeError(error: bShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: bShortPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: focus_email,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: bInvalidEmailError);
        }
        return null;
      },
      onFieldSubmitted: (value) {
        mysql.FocusChange(context, focus_email, focus_pwd);
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: bInvalidEmailError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.white),
        //   borderRadius: BorderRadius.circular(25.7),
        // ),
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
