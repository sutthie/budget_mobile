import 'package:flutter/material.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/reset_button.dart';
import '../../../components/form_error.dart';
import '../../../screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/cupertino.dart';
import 'package:simple_radio_group/simple_radio_group.dart';
//import '../../../widget_share/showSnackBar.dart'; // how to use => showSnackBar(context, 'Clear TextFormField!', 'Yes');
import '../../../global/constants.dart';
import '../../../global/size_config.dart';

import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

//enum _sex { man, woman }

class _SignUpFormState extends State<SignUpForm> {
  late DateFormat dateFormat;

  final _publicDate = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? fullname;
  String? email;
  String? password;
  String? tel;
  String? address;
  String? dates;
  String? sex;

  // ignore: non_constant_identifier_names
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];

// TextField password hidden text or show text
  bool pwdText = true; // true=hidden
  bool pwdTextConfirm = true;

  @override
  void initState() {
    super.initState();

    // กำหนดรูปแบบการจัดการวันที่และเวลา มีเพิ่มเติมเล็กน้อยในในท้ายบทความ
    //Intl.defaultLocale = 'th';
    Intl.defaultLocale = 'en';
    initializeDateFormatting();
    // dateFormat = DateFormat.yMMMd('th');
    //dateFormat = DateFormat('วันที่ d เดือน MMM ปี y', 'th');
    //dateFormat = DateFormat('yyyy-MM-dd', 'en');
    dateFormat = DateFormat('dd-MM-yyyy', 'en');
  }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(new Duration(days: 180)),
      //firstDate: DateTime(2023, 1),
      //lastDate: DateTime(2023, 6),    year,month
      //lastDate: DateTime(2025),
      lastDate: DateTime(DateTime.now().year + 2),
      //lastDate: DateTime.now().add(new Duration(days: 7)),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        //dates = newDate.toString();
        // _publicDate.value = TextEditingValue(
        //     text: DateFormat('yyyy-MM-dd').format(newDate).toString());
        _publicDate.value = TextEditingValue(
            text: DateFormat('dd-MM-yyyy').format(newDate).toString());
        //dates = _publicDate.value.toString();
      });
    }
  }

  Future<void> _cupertinoDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Welcome'),
            content: const Text('Cupertino Dialog, Is it nice?'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  _formKey.currentState!.reset();
                  Navigator.pop(context, 'Yes');
                },
                child: const Text('Yes'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: const Text('No'),
              ),
            ],
          );
        })) {
      case 'Yes':
        //showSnackBar(context, 'Clear TextFormField!', 'Yes');
        _formKey.currentState!.reset();
        break;
      case 'No':
        //showSnackBar(context, 'Cancel Clear TextFormField', 'No');
        break;
    }
  }

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
          buildFullnameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildTelephoneFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildDateFormField(),
          SizedBox(height: getProportionateScreenHeight(9)),
          Card(
              //color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 3, //mirror
              child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 5),
                          Text('เพศ'),
                        ],
                      ),
                      Row(children: [buildSexFormField()]),
                    ],
                  ))),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "ลงทะเบียน",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen

                print(fullname);
                print(email);
                print(password);
                print(tel);
                print(address);
                print(dates);
                print(sex);

// add new account

                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          ResetButton(
            text: "ล้างข้อมูล",
            press: () {
              //_formKey.currentState!.reset();
              _cupertinoDialog();
            },
          ),
        ],
      ),
    );
  }

  buildSexFormField() {
    return SimpleRadioGroup<String>(
      onChanged: (newValue) {
        sex = newValue;
        print(sex);
      },
      direction: Axis.horizontal,
      //direction: Axis.vertical,
      //initialValue: "Option 1",
      validator: (String? option) {
        if (option == null) {
          return "กรุณาเลือกเพศ";
        }
        return null;
      },
      options: const [
        "ชาย",
        "หญิง",
        "ไม่ระบุ",
      ],
    );
  }
  // Widget buildSexFormField() {
  //   return Column(
  //     children: <Widget>[
  //       ListTile(
  //         title: const Text('ชาย'),
  //         leading: Radio(
  //           groupValue: _sex,
  //           value: _sex.man,
  //           onChanged: (value) {
  //             setState(() {
  //               sex = value.toString();
  //             });
  //           },
  //         ),
  //       ),
  //       ListTile(
  //         title: const Text('หญิง'),
  //         leading: Radio(
  //           groupValue: _sex,
  //           value: _sex.woman,
  //           onChanged: (value) {
  //             setState(() {
  //               sex = value.toString();
  //             });
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  TextFormField buildDateFormField() {
    return TextFormField(
      controller: _publicDate,
      onSaved: (newValue) => dates = newValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "วันเดือนปีเกิด",
        hintText: "เลือก วัน-เดือน-ปี เกิด",
        //icon: Icon(Icons.date_range_outlined),
        //suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        suffixIcon: Icon(Icons.date_range_outlined),
      ),
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: bDateNullError);
      //   }
      //   dates = value;
      // },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bDateNullError);
          return "";
        } else
          removeError(error: bDateNullError);

        return null;
      },
      onTap: _selectDate,
      readOnly: true,
    );
  }

  TextFormField buildFullnameFormField() {
    return TextFormField(
      //obscureText: true,
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bNameNullError);
        } else if (value.length >= 8) {
          removeError(error: bShortNameError);
        }
        fullname = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bNameNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: bShortNameError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "ชื่อ-นามสกุล",
        hintText: "ป้อน ชื่อ-นามสกุล",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildTelephoneFormField() {
    return TextFormField(
      //obscureText: true,
      //controller: _title,
      //autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      onSaved: (newValue) => tel = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bPhoneNumberNullError);
        } else if (value.length >= 10) {
          removeError(error: bPhoneNumberShortError);
        }
        tel = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bPhoneNumberNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: bPhoneNumberShortError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "เบอร์โทรศัพท์",
        hintText: "ป้อนเบอร์โทรศัพท์",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: pwdTextConfirm,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: bMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: bMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "Confirm Password",
        hintText: "ยืนยันรหัสผ่านอีกครั้ง",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              pwdTextConfirm = !pwdTextConfirm;
            });
          },
          child: Icon(pwdTextConfirm ? Icons.visibility_off : Icons.visibility),
        ),
        //CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: pwdText,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bPassNullError);
        } else if (value.length >= 8) {
          removeError(error: bShortPassError);
        }
        password = value;
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "Password",
        hintText: "ป้อนรหัสผ่าน",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              pwdText = !pwdText;
            });
          },
          child: Icon(pwdText ? Icons.visibility_off : Icons.visibility),
        ),
        //CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: bInvalidEmailError);
        }
        return null;
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
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "Email",
        hintText: "ป้อนอีเมล์",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      //obscureText: true,
      maxLines: 3,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: bAddressNullError);
        } else if (value.length >= 50) {
          removeError(error: bAddressShortError);
        }
        address = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: bAddressNullError);
          return "";
        } else if (value.length < 50) {
          addError(error: bAddressShortError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: new BorderRadius.circular(25.7),
        ),
        labelText: "ที่อยู่",
        hintText: "ป้อนที่อยู่",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
