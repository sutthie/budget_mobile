import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

//import 'dart:developer';
import '../global/globalVar.dart';
import '../models/UnitName.dart';

class GetUnitName {
  Future<String> GetUnitStr(String uid) async {
    String url = "http://$ipAddress/phpFlutterBudget/GetUnitStr.php";

    if (uid.isNotEmpty) {
      var queryCom = <String, dynamic>{};
      queryCom['uid'] = uid;

      var jsonQuery = json.encode(queryCom);

      final response = await http.post(Uri.parse(url),
          headers: {"Accept": "application/json"}, body: jsonQuery);

      //print("response.body : " + response.body); // check the status code for the result

      var ret;
      if (response.statusCode == 200) {
        //print("return response : " + response.body.toString()); // check the status code for the result
        //int ret = int.parse(response.body.trim());

        if (response.body.trim() != "")
          ret = response.body.trim().toString();
        else
          ret = "";

        return ret;
      } else
        return "";
    } else
      return "";
  }

  Future<List<UnitName>?> getDataUnit() async {
    String url = "http://$ipAddress/phpFlutterBudget/GetUnitName.php";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //log(response.body.trim());

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<UnitName> unitList = items.map<UnitName>((json) {
          return UnitName.fromJson(json);
        }).toList();

        //log(unitList.toString());

        return unitList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }
}
