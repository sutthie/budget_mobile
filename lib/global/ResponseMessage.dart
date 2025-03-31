import 'package:flutter/material.dart';

/*
How to Use

 var msg = new ResponseMessage();
    msg.Alert(
        context, "Status Application", "Seession Expired. Please Login!!!");
*/

class ResponseMessage {
//=========================================================
  Alert(context, String title, String txt) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        //title: const Text('ทดสอบ Dialog',
        title: Text('${title}',
            style: TextStyle(
                fontFamily: 'Montserrat', fontSize: 18.0, color: Colors.red)),
        content: Text("${txt} !!!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              //exit(0);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
