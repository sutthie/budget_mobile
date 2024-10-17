import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:bfriendapp/styles/TextStyle_Bfriend.dart';
import 'package:flutter/cupertino.dart';

Future<String> cupertDialog(context, func) async {
  String ret = "";
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Welcome'),
          content: const Text('Cupertino Dialog, Is it nice?'),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                func(context, "Yes", "");
                ret = "Yes";
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            CupertinoDialogAction(
              onPressed: () {
                func(context, "No", "");
                ret = "No";
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      });

  return ret;
}
