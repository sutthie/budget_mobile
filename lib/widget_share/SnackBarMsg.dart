import 'package:flutter/material.dart';

/*
How to Use

  SnackBarMsg snackMsg = SnackBarMsg();
  -snackMsg.showSnackBarMsg(response.data['message'], this.context);
  -snackMsg.showSnackBarMsg(response.data['message'], context);
*/

class SnackBarMsg {
//=========================================================
  showSnackBarMsg(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info),
          Text('${msg}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    ));
  }
}
