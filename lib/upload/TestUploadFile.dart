import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../global/globalVar.dart';
import '../widget_share/SnackBarMsg.dart';

class TestUploadFile extends StatefulWidget {
  static String routeName = "/TestUploadFile";

  @override
  _TestUploadFileState createState() => _TestUploadFileState();
}

class _TestUploadFileState extends State<TestUploadFile> {
  @override
  void initState() {
    super.initState();
  }

  SnackBarMsg snackMsg = SnackBarMsg();

  File? _file;
  //final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path.toString());
      });
    }
  }

  void _UploadFile(filepath) async {
    String fileName = basename(filepath.path);
    print("file base name:$fileName");

    try {
      FormData formData = new FormData.fromMap({
        "name": "Sutthie J.",
        "age": 49,
        "file": await MultipartFile.fromFile(filepath.path, filename: fileName),
      });
      Response response = await Dio().post(
          "http://$ipAddress/phpFlutterBudget/TestUploadFile.php",
          data: formData);
      print("file upload response:$response");

      snackMsg.showSnackBarMsg(response.data['message'], this.context);
    } catch (e) {
      print("expectiation caugch: $e");
    }
  }

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
                  _UploadFile(_file);
                }
              },
            ),
            Text(_file?.path ?? ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getFile,
        tooltip: 'Select File',
        child: Icon(Icons.add),
      ),
    );
  }
}
