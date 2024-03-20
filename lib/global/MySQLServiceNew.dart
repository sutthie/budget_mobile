// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'globalVar.dart';
import '../models/Products.dart';
import '../models/Account.dart';

class MySQLDB {
  FocusChange(
      /* How to Use from current focus to next focus */
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<String> chkLogin(String uid, String pwd) async {
    String url = "http://$ipAddress/phpFlutter/FlutterLoginV2.php";

    var loginDat = <String, dynamic>{};
    loginDat['userid'] = uid;
    loginDat['password'] = pwd;

    var jsonLogin = json.encode(loginDat);

    var ret;

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: jsonLogin);

    log("response.body : " +
        response.body.trim()); // check the status code for the result

    if (response.statusCode == 200) {
      String dat = response.body.trim();

      if (dat != "") {
        // check data return
        String aid;
        String userid;
        String status;
        String firstname;
        String lastname;
        String email;

        var acc = json.decode(dat);
        aid = acc["aid"];
        userid = acc["userid"];
        firstname = acc["firstname"]; // user , admin
        lastname = acc["lastname"];
        status = acc["status"];
        email = acc["email"];

        ret = {
          "aid": aid,
          "userid": userid,
          "fullname": firstname + " " + lastname,
          "status": status,
          "email": email,
          //"logon": true
        };

        return json.encode(ret);
      } else {
        //ret = {"logon": false};

        //return json.encode(ret);
        return "";
      }
    } else
      return "";
  }

//=========================================================
  Future<int> chkLoginJson(String uid, String pwd) async {
    String url = "http://$ipAddress/phpFlutter/FlutterLoginJson.php";

    var loginDat = <String, dynamic>{};
    loginDat['userid'] = uid;
    loginDat['password'] = pwd;

    var jsonLogin = json.encode(loginDat);

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: jsonLogin);

    log("response.body : " +
        response.body.trim()); // check the status code for the result

    if (response.statusCode == 200) {
      var ret = json.decode(response.body.trim());

// check data return
      //log("ret['result'] : " + ret["result"]);

      return ret["result"];
    } else {
      return 0;
    }
  }

//=========================================================
  Future<String> chkLoginToken(String uid, String pwd) async {
    String url = "http://$ipAddress/phpFlutter/FlutterLoginV2.php";

    var loginDat = <String, dynamic>{};
    loginDat['userid'] = uid;
    loginDat['password'] = pwd;

    var jsonLogin = json.encode(loginDat);

    var ret;

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: jsonLogin);

    log("response.body : " +
        response.body.trim()); // check the status code for the result

    if (response.statusCode == 200) {
      String dat = response.body.trim();

      if (dat != "") {
        // check data return
        String aid;
        String userid;
        String status;
        String token;
        String firstname;
        String lastname;

        try {
          var acc = json.decode(dat);
          aid = acc["aid"];
          userid = acc["userid"];
          firstname = acc["firstname"]; // user , admin
          lastname = acc["lastname"];
          status = acc["status"];
          //uid = acc["Uint"] ?? "";
          token = "";
        } catch (e) {
          log("error :" + e.toString());

          return "";
        }
        //========Create Token==================

        url = "http://$url_node/get_token/" + userid;
        try {
          final response = await http.post(Uri.parse(url));

          if (response.statusCode == 200) {
            log("response.body : " + response.body);
            token = response.body;

            log("UserID : $userid ; Token : $token");
            //======================================
            ret = {
              "aid": aid,
              "userid": userid,
              "fullname": firstname + " " + lastname,
              "status": status,
              "token": token,
            };

            //return ret.toString();
            return json.encode(ret);
          } else
            //token = "";
            return "";
        } catch (e) {
          log("error :" + e.toString());
          //token = "";
          return "";
        }
      } else
        return "";
    } else {
      return "";
    }
  }

//=========================================================
  Future<String> CheckTokenExpirePost(String token) async {
    String status = "";
    String url = "http://$url_node/check_token_expire/" + token;

    log("receive token : " + token);

    try {
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        if (response.body != "") {
          print("response.body : " + response.body);
          //status = "true";
          status = response.body;
        } else
          status = "";
      } else {
        status = "";
      }
    } catch (e) {
      log("error :" + e.toString());
      status = "";
    }

    var ret = {"status": status, "token": token};

    return json.encode(ret);
  }

//=========================================================
  FutureOr<String> CheckTokenExpireBearer(String token) async {
    //bool status;
    //String data = "";
    String ret = "";

    String url = "http://$url_node/check_token_expire_bearer";

    log("receive token : " + token);

    final response = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      print(response);

      ret = response.toString();
    }
    return ret;
  }

//=========================================================
  Future<String> AddUserJson(String uid, String pwd, String firstname,
      String lastname, String mobile) async {
    String url = "http://$ipAddress/phpFlutter/AddUser.php";

    var Dat = <String, dynamic>{};
    Dat['userid'] = uid;
    Dat['password'] = pwd;
    Dat['firstname'] = firstname;
    Dat['lastname'] = lastname;
    Dat['mobile'] = mobile;

    var datAdd = json.encode(Dat);

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: datAdd);

    //log("response.body : " + response.body); // check the status code for the result

    var ret;
    if (response.statusCode == 200) {
      log("return response : " +
          response.body
              .trim()
              .toString()); // check the status code for the result
      //int ret = int.parse(response.body.trim());
      ret = json.decode(response.body.trim());
      //log("return value : ${ret}");
      // check data return
      log(ret['result'] + " | " + ret["msg"]);

      return response.body.trim();

      //return 1;
      //return ret;
    } else {
      log("return statusCode Error");
      ret = {"result": "false", "msg": "No Response from Server"};

      return ret;
    }
  }

//=========================================================
  Future<String> UpdateUser(Dat) async {
    String url = "http://$ipAddress/phpFlutter/UpdateUser.php";

    // Dat = <String, dynamic>{};
    // Dat['userid'] = uid;
    // Dat['password'] = pwd;
    // Dat['firstname'] = firstname;
    // Dat['lastname'] = lastname;
    // Dat['mobile'] = mobile;

    var datUpdate = json.encode(Dat);

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: datUpdate);

    //log("response.body : " + response.body); // check the status code for the result

    var ret;
    if (response.statusCode == 200) {
      log("return response : " +
          response.body
              .trim()
              .toString()); // check the status code for the result

      ret = json.decode(response.body.trim());
      // check data return
      log(ret['result'] + " | " + ret["msg"]);

      return response.body.trim();

      //return 1;
      //return ret;
    } else {
      log("return statusCode Error");
      ret = {"result": "false", "msg": "No Response from Server"};

      return ret;
    }
  }

//=========================================================
  Future<String> DeleteUser(Dat) async {
    String url = "http://$ipAddress/phpFlutter/DeleteAccount.php";

    // Dat = <String, dynamic>{};
    // Dat['userid'] = uid;
    // Dat['password'] = pwd;
    // Dat['firstname'] = firstname;
    // Dat['lastname'] = lastname;
    // Dat['mobile'] = mobile;

    var datUpdate = json.encode(Dat);

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: datUpdate);

    //log("response.body : " + response.body); // check the status code for the result

    var ret;
    if (response.statusCode == 200) {
      log("return response : " +
          response.body
              .trim()
              .toString()); // check the status code for the result

      ret = json.decode(response.body.trim());
      // check data return
      log(ret['result'] + " | " + ret["msg"]);

      return response.body.trim();

      //return 1;
      //return ret;
    } else {
      log("return statusCode Error");
      ret = {"result": "false", "msg": "No Response from Server"};

      return ret;
    }
  }

//=========================================================
  Future<List<Account>> getDataAccount() async {
    String url = "http://$ipAddress/phpFlutter/FlutterGetAccount.php";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      //log(response.body);

      final items =
          json.decode(response.body.trim()).cast<Map<String, dynamic>>();

      List<Account> studentList = items.map<Account>((json) {
        return Account.fromJson(json);
      }).toList();

      return studentList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<Object?> fetchData(String query) async {
    String url = "http://$ipAddress/phpFlutter/FlutterGetData.php";

    var queryCom = <String, dynamic>{};
    queryCom['userid'] = query;

    var jsonQuery = json.encode(queryCom);

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: jsonQuery);

    if (response.statusCode == 200) {
      var ret = json.decode(response.body.trim());
      log(ret);
      return ret;
    } else {
      log("error reponse : ${response.statusCode}");
      return null;
    }
  }

//===============================================================
  Future<Account?> getAccDetail(String aid) async {
    Account acc;
    String url = "http://$ipAddress/phpFlutter/GetAccDetail.php";
    //String querystring = "?id_exp_spen=$idExpSpen";
    //String qs = urlEncode(text: querystring);
    //log(urlSecret);

    final response = await http.post(Uri.parse(url), body: {"aid": aid});
    if (response.statusCode == 200) {
      if (response.body.trim() != "") {
        //final items = Expedite.fromJson(json.decode(response.body.trim())); error
        //Map items = json.decode(response.body.trim());
        final jsonRes = json.decode(response.body.trim());
        //Expedite exp = new Expedite.fromJson(jsonRes);
        if (jsonRes != null) {
          //var listExpSpen = jsonRes[0]['list_exp_spen'];
          String userid = jsonRes["userid"];
          String password = jsonRes["passwords"];
          String firstname = jsonRes["firstname"];
          String lastname = jsonRes["lastname"];
          String mobile = jsonRes["mobile"];
          int uid = jsonRes["Uint"];
          int uses = jsonRes["uses"];
          int login = jsonRes["login"];

          acc = new Account(
              aid: aid,
              userid: userid,
              passwords: password,
              firstname: firstname,
              lastname: lastname,
              mobile: mobile,
              uid: uid,
              login: login,
              uses: uses);

          return acc;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      throw Exception('Response Error : ${response.statusCode}');
      //return null;
      //log("error reponse : ${response.statusCode}");
    }
  }

//=========================================================

  Future<List<Account>?> getAccSearch(String cond, String uid) async {
    String url = "http://$ipAddress/phpFlutter/GetAccSearch.php";

    final response =
        await http.post(Uri.parse(url), body: {"cond": cond, "uid": uid});
    if (response.statusCode == 200) {
      //log(response.body.trim());

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<Account> accList = items.map<Account>((json) {
          return Account.fromJson(json);
        }).toList();

        //log(accList.toString());

        return accList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================

  Future<List<Products>?> getProductSearch(String cond) async {
    String url = "http://$ipAddress/phpFlutter/GetProductSearch.php";

    final response = await http.post(Uri.parse(url), body: {"cond": cond});
    if (response.statusCode == 200) {
      //log(response.body.trim());

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<Products> proList = items.map<Products>((json) {
          return Products.fromJson(json);
        }).toList();

        //log(proList.toString());

        return proList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//===============getProductDetail(pid)===========================
  Future<Products?> getProductDetail(int pid) async {
    Products pro;
    String url = "http://$ipAddress/phpFlutter/GetProductDetail.php";
    //String querystring = "?id_exp_spen=$idExpSpen";
    //String qs = urlEncode(text: querystring);
    //log(urlSecret);

    final response =
        await http.post(Uri.parse(url), body: {"pid": pid.toString()});
    if (response.statusCode == 200) {
      if (response.body.trim() != "") {
        //final items = Expedite.fromJson(json.decode(response.body.trim())); error
        //Map items = json.decode(response.body.trim());
        final jsonRes = json.decode(response.body.trim());
        //Expedite exp = new Expedite.fromJson(jsonRes);
        if (jsonRes != null) {
          int pid = int.parse(jsonRes[0]["pid"]);
          int pgid = int.parse(jsonRes[0]["pgid"]);
          String productname = jsonRes[0]["productname"];
          String description = jsonRes[0]["description"];
          double price = double.parse(jsonRes[0]["price"]);
          String discountstr = jsonRes[0]["discountStr"] ?? "";

          pro = new Products(
            pid: pid,
            pgid: pgid,
            productname: productname,
            description: description,
            price: price,
            discountStr: discountstr,
            images: [],
            reviews: [],
          );

          return pro;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      throw Exception('Response Error : ${response.statusCode}');
      //return null;
      //log("error reponse : ${response.statusCode}");
    }
  }

//==============================================
  static Future<String> createTable(String tb) async {
    String url = "http://$ipAddress/phpFlutter/CreateTable.php";

    Uri uriObj = Uri.parse(url);

    try {
      var map = <String, dynamic>{};
      map['tbName'] = tb;

      final response = await http.post(uriObj, body: map);
      log('Create Table Response : ${response.body.trim()}');
      return response.body;
    } catch (e) {
      return "error";
    }
  }
}
