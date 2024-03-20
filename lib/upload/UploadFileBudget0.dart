import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import '../global/globalVar.dart';
import 'package:file_picker/file_picker.dart';

class UploadFileClass {
  File? _file;

  Future<File?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
    );

    if (result != null) {
      _file = File(result.files.single.path.toString());
      return _file;
    } else
      return null;
  }

  Future<String> UploadFile(filepath) async {
    String fileName = basename(filepath.path);
    print("file base name:$fileName");

    try {
      FormData formData = new FormData.fromMap({
        // "name": "Sutthie J.",
        // "age": 49,
        "file": await MultipartFile.fromFile(filepath.path, filename: fileName),
      });
      Response response = await Dio().post(
          "http://$ipAddress/phpFlutterBudget/UploadFile.php",
          data: formData);
      print("file upload response:$response");
      return response.toString();
    } catch (e) {
      print("expectiation caugch: $e");
      return "";
    }
  }

  Future<String> UploadFileToServer(filepath, site) async {
    String fileName = basename(filepath.path);
    print("file base name:$fileName");

    String url = "http://$ipAddress/$site/Follow/UploadFileMobile.php";

    try {
      FormData formData = new FormData.fromMap({
        // "name": "Sutthie J.",
        // "age": 49,
        "file": await MultipartFile.fromFile(filepath.path, filename: fileName),
      });

      Response response = await Dio().post(
          //"http://$ipAddress/phpFlutterBudget/UploadFile.php",
          url,
          data: formData);

      if (response.statusCode == 200) {
        // print("file upload response:$response");
        // return response.data.toString();

        // ข้อมูลการตอบสนองเป็น JSON
        Map<String, dynamic> data = response.data;
        print(data['result']); // แสดงชื่อ

        return response.data.toString();
      } else {
        //return "";
        // เกิดข้อผิดพลาด
        return response.statusCode.toString();
      }
    } catch (e) {
      print("expectiation caugch: $e");
      return "";
    }
  }

  Future<String> UploadFToSrvAddProp(filepath, site, key, val) async {
    String fileName = basename(filepath.path);
    print("file base name:$fileName");

    String url = "http://$ipAddress/$site/Follow/UploadFileMobile.php";

    FormData formData = new FormData.fromMap({
      key: val,
      // "name": "Sutthie J.",
      // "age": 49,
      "file": await MultipartFile.fromFile(filepath.path, filename: fileName),
    });

    try {
      Response response = await Dio().post(url, data: formData);

      if (response.statusCode == 200) {
        // print("file upload response:$response");
        // return response.data.toString();

        // ข้อมูลการตอบสนองเป็น JSON
        Map<String, dynamic> data = response.data;
        print(data['result']); // แสดงชื่อ

        //ret = json.decode(response.body.trim());
        //log(ret['result'] + " | " + ret["msg"]);

        return response.data.toString();
      } else {
        //return "";
        // เกิดข้อผิดพลาด
        return response.statusCode.toString();
      }
    } on DioException catch (e) {
      String errorMessage = e.message.toString();

      print("errorMessage : " + errorMessage);

      print("e.type : " + e.type.toString());

      if (e.response != null) {
        print(e.response!.statusCode.toString());
      }

      return "Error : " +
          errorMessage +
          "\n" +
          e.response!.statusCode.toString();
    }
  }
}
