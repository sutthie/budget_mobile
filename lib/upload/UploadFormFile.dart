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
        "name": "Sutthie J.",
        "age": 49,
        "file": await MultipartFile.fromFile(filepath.path, filename: fileName),
      });
      Response response = await Dio().post(
          "http://$ipAddress/phpFlutterBudget/UploadFormFile.php",
          data: formData);
      print("file upload response:$response");
      return response.toString();
    } catch (e) {
      print("expectiation caugch: $e");
      return "";
    }
  }
}
