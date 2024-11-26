//page User
import '../chat/ChatPerson.dart';
//Login Screen
import '../loginscreen.bak';
//page Admin
import '../admin/ShowAcc.dart';
import 'package:flutter/material.dart';
import '../WelcomeScreen.dart';

var route = <String, WidgetBuilder>{
  '/welcome': (BuildContext context) => WelcomeScreen(),
  '/account': (BuildContext context) => ShowAccount(),
  '/chat': (BuildContext context) => ChatPerson(
        title: '',
      ),
  '/login': (BuildContext context) => LoginScreen(),
};
