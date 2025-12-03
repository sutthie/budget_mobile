import 'dart:convert';

import 'package:http/http.dart' as http;

import 'GetYearBudget.dart';
import 'globalVar.dart';

class GetHoliday {
  static const Map<String, dynamic> _emptyResult = {'count': 0, 'dates': []};

  int years = GetYearBudget.getYearBudget();

  //======================get getExpType=============================
  Future<Map<String, dynamic>> getAllHoliday(String years) async {
    final url = "http://$ipAddress/FlutterBudget/GetAllHoliday.php";

    try {
      final response = await http.post(Uri.parse(url), body: {"years": years});
      if (response.statusCode != 200) {
        return _emptyResult;
      }

      final trimmed = response.body.trim();
      if (trimmed.isEmpty) {
        return _emptyResult;
      }

      final decoded = json.decode(trimmed);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      return _emptyResult;
    } catch (_) {
      return _emptyResult;
    }
  }
}
