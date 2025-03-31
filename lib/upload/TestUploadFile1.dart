import 'package:flutter/material.dart';
import 'dart:io';
//import '../global/globalVar.dart';
import '../widget_share/SnackBarMsg.dart';
import 'UploadFile.dart';

class TestUploadFile1 extends StatefulWidget {
  static String routeName = "/TestUploadFile1";

  @override
  _TestUploadFile1State createState() => _TestUploadFile1State();
}

class _TestUploadFile1State extends State<TestUploadFile1> {
  File? _file;
  //final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();

  UploadFileClass upc = UploadFileClass();

  @override
  void initState() {
    super.initState();
  }

  SnackBarMsg snackMsg = SnackBarMsg();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldstate,
      appBar: AppBar(
        title: const Text('Test Upload File'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("UPLOAD"),
              onPressed: () {
                if (_file == null) {
                  snackMsg.showSnackBarMsg(
                      "Please Select FileName for Upload!!!", context);
                } else {
                  upc.UploadFile(_file).then((value) {
                    print(value);
                  });
                }
              },
            ),
            Text(_file?.path ?? ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          upc.getFile().then((value) {
            setState(() {
              _file = value;
            });
          });
        },
        tooltip: 'Select File',
        child: Icon(Icons.add),
      ),
    );
  }
}
