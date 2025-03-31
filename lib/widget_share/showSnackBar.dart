import 'package:flutter/material.dart';
// import 'package:bfriendapp/styles/TextStyle_Bfriend.dart';

void showSnackBar(context, String text, String ans) {
  final SnackBar snackBar = SnackBar(
      duration: const Duration(milliseconds: 500),
      backgroundColor: ans.compareTo('Yes') == 0 ? Colors.green : Colors.red,
      content: Row(
        children: <Widget>[
          Icon(
            ans.compareTo('Yes') == 0 ? Icons.favorite : Icons.watch_later,
            color: ans.compareTo('Yes') == 0 ? Colors.pink : Colors.yellow,
            size: 24.0,
            semanticLabel: text,
          ),
          Text(text)
        ],
      ));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
