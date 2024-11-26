import 'dart:async';
import 'dart:convert';
import 'package:budget_mobile/models/BookUnit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import '../models/Expedite.dart';
import '../models/TBStatusSearch.dart';
import 'globalVar.dart';
import '../models/Account.dart';
import '../models/UnitName.dart';

class MySQLDB {
  FocusChange(
      /* How to Use from current focus to next focus */
      BuildContext context,
      FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

//=========================================================
  Future<String> chkLogin(String uid, String pwd) async {
    String url = "http://$ipAddress/phpFlutterBudget/FlutterLogin.php/";
    String querystring = "?userid=$uid&password=$pwd";
//  String qs = urlEncode(text: querystring);

    String uriStr = url + querystring;
    //log("uriStr : " + uriStr);

    //int ret;

    final response = await http.get(Uri.parse(uriStr));

    if (response.statusCode == 200) {
      return response.body.trim();
      //ret = int.parse(response.body);
      //log('Return Value : $ret');
    } else {
      return "";
      //log("error reponse : ${response.statusCode}");
    }
  }

//=========================================================
  Future<int> chkLoginJson(String uid, String pwd) async {
    String url = "http://$ipAddress/phpFlutterBudget/FlutterLoginJson.php";

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
    String url = "http://$ipAddress/phpFlutterBudget/FlutterLoginV2.php";

    var loginDat = <String, dynamic>{};
    loginDat['userid'] = uid;
    loginDat['password'] = pwd;

    var jsonLogin = json.encode(loginDat);

    var ret;

    try {
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
          String uid;
          String mobile;

          try {
            var acc = json.decode(dat);
            aid = acc["aid"];
            userid = acc["userid"];
            firstname = acc["firstname"]; // user , admin
            lastname = acc["lastname"];
            status = acc["status"];
            uid = acc["Uint"];
            mobile = acc["mobile"];
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

              //if (response.body == "") return "";
              token = response.body;

              log("UserID : $userid ; Token : $token");
              //======================================
              ret = {
                "aid": aid,
                "userid": userid,
                "fullname": firstname + " " + lastname,
                "status": status,
                "token": token,
                "uid": uid,
                "mobile": mobile
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
        }
        if (response.statusCode != 200) {
          log("error :" + response.statusCode.toString());
          //token = "";
          return "";
        } else
          return "";
      } else {
        return "";
      }
    } catch (e) {
      log("error :" + e.toString());
      //token = "";
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
  Future<String> AddUserJson(String unitNow, String uid, String pwd,
      String firstname, String lastname, String mobile) async {
    String url = "http://$ipAddress/phpFlutterBudget/AddUser.php";

    var Dat = <String, dynamic>{};
    Dat['userid'] = uid;
    Dat['password'] = pwd;
    Dat['firstname'] = firstname;
    Dat['lastname'] = lastname;
    Dat['mobile'] = mobile;
    Dat['uid'] = unitNow;

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
    String url = "http://$ipAddress/phpFlutterBudget/UpdateUser.php";

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
      log(ret['result'] + " | " + ret["msg"].toString());

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
    String url = "http://$ipAddress/phpFlutterBudget/DeleteAccount.php";

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
    String url = "http://$ipAddress/phpFlutterBudget/FlutterGetAccount.php";

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

//==============Book Unit=====================================
  Future<String> AddBookUnit(
      String Years,
      String Id_exp_spen,
      String List_exp_spen,
      String TitleStr,
      String BookNo,
      String Doc_unit,
      String Money,
      String Dates,
      String Secret_class,
      String Speed_class,
      String Response,
      String Units,
      String UnitName,
      String TypeJob) async {
    String url = "http://$ipAddress/phpFlutterBudget/AddBookUnit.php";

    var Dat = <String, dynamic>{};
    Dat['years'] = Years;
    Dat['id_exp_spen'] = Id_exp_spen;
    Dat['list_exp_spen'] = List_exp_spen;
    Dat['title'] = TitleStr;
    Dat['doc_unit_no'] = BookNo;
    Dat['doc_unit'] = Doc_unit;
    Dat['amout'] = Money;
    Dat['unit_date_no'] = Dates;
    Dat['secret_class'] = Secret_class;
    Dat['speed_class'] = Speed_class;
    Dat['response_person'] = Response;
    Dat['type_job'] = TypeJob;
    Dat['uid'] = Units;
    Dat['unitname'] = UnitName;

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

//==============table Status=====================================
/* txtYear.text,
             txtBookNo.text,
             txtListName.text,
             txtTitle.text,
             txtUnitName.text,
             widget.id_job,
             id_use_int,
             sent_to,
             txt_sent_to,
             dateDB, //txtDate.text,
             txt_status_job, //sel_status_job,
             txt_status_job_detail, //sel_status_job_detail,
             FileName,
             txtETC.text,
             txtResponseOriginal.text,
             txtSender.text,
             login.get('mobile'),
*/
  Future<String> SendExpediteUser(
    //send first from original to other unit
    String years,
    String doc_unit_no,
    String list_exp_spen,
    String title,
    String unitname_str,
    String id_job,
    String id_use_int,
    String sent_to,
    String sent_to_name,
    String date_sent_to,
    String status,
    String status_detail,
    String fileName,
    String etc,
    String Response_Original,
    String sender,
    String mobile,
  ) async {
    String url = "http://$ipAddress/phpFlutterBudget/SendExpediteUser.php";

    var Dat = <String, dynamic>{};
    Dat['years'] = years;
    Dat['list_exp_spen'] = list_exp_spen;
    Dat['title'] = title;
    Dat['unitname'] = unitname_str;
    Dat['doc_unit_no'] = doc_unit_no;
    Dat['id_job'] = id_job;
    Dat['id_use_int'] = id_use_int;
    Dat['sent_to'] = sent_to;
    Dat['sent_to_name'] = sent_to_name;
    Dat['date_sent_to'] = date_sent_to;
    Dat['status'] = status;
    Dat['status_detail'] = status_detail;
    Dat['doc_unit'] = fileName;
    Dat['etc'] = etc;
    Dat['response_person_original'] = Response_Original;
    Dat['sender'] = sender;
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

//============Update Status BeforSent .php====================
  Future<String> UpdateStatusBeforSent(String id_status) async {
    String url = "http://$ipAddress/phpFlutterBudget/UpdateStatusBeforSent.php";

    final response = await http.post(Uri.parse(url),
        //headers: {"Accept": "application/json"},
        body: {"id_status": id_status});

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
    } else {
      log("return statusCode Error");
      ret = {"result": "false", "msg": "No Response from Server"};

      return ret;
    }
  }

//===================SendTbStatusBetweenUnit===============
  Future<String> SendTbStatusBetweenUnit(
    //send first from original to other unit
    String years,
    String doc_unit_no,
    String list_exp_spen,
    String title,
    String unitname_str,
    String id_job,
    String id_use_int,
    String sent_to,
    String sent_to_name,
    String date_sent_to,
    String status,
    String status_detail,
    String fileName,
    String etc,
    String Response_Original,
    String sender,
    String mobile,
  ) async {
    String url =
        "http://$ipAddress/phpFlutterBudget/SendTbStatusBetweenUnit.php";

    var Dat = <String, dynamic>{};

    Dat['years'] = years;
    Dat['list_exp_spen'] = list_exp_spen;
    Dat['title'] = title;
    Dat['unitname'] = unitname_str;
    Dat['doc_unit_no'] = doc_unit_no;
    Dat['id_job'] = id_job;
    Dat['id_use_int'] = id_use_int;
    Dat['sent_to'] = sent_to;
    Dat['sent_to_name'] = sent_to_name;
    Dat['date_sent_to'] = date_sent_to;
    Dat['status'] = status;
    Dat['status_detail'] = status_detail;
    Dat['doc_unit'] = fileName;
    Dat['etc'] = etc;
    Dat['response_person_original'] = Response_Original;
    Dat['sender'] = sender;
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
  Future<List<Expedite>?> getDataExpedite() async {
    String url = "http://$ipAddress/phpFlutterBudget/FlutterGetExpedite.php";

    final response = await http.get(Uri.parse(url));
    final items =
        json.decode(response.body.trim()).cast<Map<String, dynamic>>();
    List<Expedite>? expList;

    if (response.statusCode == 200) {
      //log(response.body);
      if (response.body.isEmpty) {
        log("ไม่พบงบประมาณใดๆ!!!");
        expList = null;
      } else {
        expList = items.map<Expedite>((json) {
          return Expedite.fromJson(json);
        }).toList();
      }
      return expList;
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<List<Expedite>?> getExpSearch(String cond, String years) async {
    String url = "http://$ipAddress/phpFlutterBudget/GetExpSearch.php";

    final response =
        await http.post(Uri.parse(url), body: {"cond": cond, "years": years});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<Expedite> expList = items.map<Expedite>((json) {
          return Expedite.fromJson(json);
        }).toList();

        return expList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<List<Expedite>?> getExpSearchUnit(
      String cond, String years, String uid) async {
    String url = "http://$ipAddress/phpFlutterBudget/GetExpSearchUnit.php";

    final response = await http
        .post(Uri.parse(url), body: {"cond": cond, "years": years, "uid": uid});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<Expedite> expList = items.map<Expedite>((json) {
          return Expedite.fromJson(json);
        }).toList();

        return expList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<Expedite?> getExpDetail(String idExpSpen) async {
    Expedite exp;
    String url = "http://$ipAddress/phpFlutterBudget/GetExpDetail.php";
    //String querystring = "?id_exp_spen=$idExpSpen";
    //String qs = urlEncode(text: querystring);
    //log(urlSecret);
    Uri uriObj = Uri.parse(url);

    final response = await http.post(uriObj, body: {"id_exp_spen": idExpSpen});
    if (response.statusCode == 200) {
      if (response.body.trim() != "") {
        //final items = Expedite.fromJson(json.decode(response.body.trim())); error
        //Map items = json.decode(response.body.trim());
        final jsonRes = json.decode(response.body.trim());
        //Expedite exp = new Expedite.fromJson(jsonRes);
        if (jsonRes != null) {
          //var listExpSpen = jsonRes[0]['list_exp_spen'];
          int idlist = int.parse(jsonRes[0]["idlist"]);
          String idExpSpen = jsonRes[0]["id_exp_spen"];
          String listExpSpen = jsonRes[0]["list_exp_spen"];
          String memoTh = jsonRes[0]["memo_th"];
          double mBorder = jsonRes[0]["mborder"] == null
              ? 0.00
              : double.parse(jsonRes[0]["mborder"]);
          double mAlloc = jsonRes[0]["malloc"] == null
              ? 0.00
              : double.parse(jsonRes[0]["malloc"]);
          int status = int.parse(jsonRes[0]["status"]);
          String daystart = jsonRes[0]["daystart"];
          String daystop = jsonRes[0]["daystop"];
          String code_bud_rtarf = (jsonRes[0]["code_bud_rtarf"] == null)
              ? ''
              : jsonRes[0]["code_bud_rtarf"];
          int field_work = (jsonRes[0]["field_work"] == null)
              ? 0
              : int.parse(jsonRes[0]["field_work"]);
          int exp_type = (jsonRes[0]["exp_type"] == null)
              ? 0
              : int.parse(jsonRes[0]["exp_type"]);
          int int_group = (jsonRes[0]["int_group"] == null)
              ? 0
              : int.parse(jsonRes[0]["int_group"]);
          int unit_use = (jsonRes[0]["unit_use"] == null)
              ? 0
              : int.parse(jsonRes[0]["unit_use"]);
          int unit_oper = (jsonRes[0]["unit_oper"] == null)
              ? 0
              : int.parse(jsonRes[0]["unit_oper"]);
          int bud_type = (jsonRes[0]["bud_type"] == null)
              ? 0
              : int.parse(jsonRes[0]["bud_type"]);
          double mpay = double.parse(jsonRes[0]["mpay"]);
          double bpay_n = double.parse(jsonRes[0]["bpay_n"]);
          double bpay = double.parse(jsonRes[0]["bpay"]);
          double cpay = double.parse(jsonRes[0]["cpay"]);
          double dpay = double.parse(jsonRes[0]["dpay"]);
          double spay = double.parse(jsonRes[0]["spay"]);
          double spay_n = double.parse(jsonRes[0]["spay_n"]);
          double opay = double.parse(jsonRes[0]["opay"]);
          double tpay = double.parse(jsonRes[0]["tpay"]);
          double tlpay = double.parse(jsonRes[0]["tlpay"]);
          double stpay = double.parse(jsonRes[0]["stpay"]);
          double balan = double.parse(jsonRes[0]["balan"]);
          int years = int.parse(jsonRes[0]["years"]);
          double m10 = double.parse(jsonRes[0]["m10"]);
          double m11 = double.parse(jsonRes[0]["m11"]);
          double m12 = double.parse(jsonRes[0]["m12"]);
          double sum1 = double.parse(jsonRes[0]["sum1"]);
          double m01 = double.parse(jsonRes[0]["m01"]);
          double m02 = double.parse(jsonRes[0]["m02"]);
          double m03 = double.parse(jsonRes[0]["m03"]);
          double sum2 = double.parse(jsonRes[0]["sum2"]);
          double m04 = double.parse(jsonRes[0]["m04"]);
          double m05 = double.parse(jsonRes[0]["m05"]);
          double m06 = double.parse(jsonRes[0]["m06"]);
          double sum3 = double.parse(jsonRes[0]["sum3"]);
          double m07 = double.parse(jsonRes[0]["m07"]);
          double m08 = double.parse(jsonRes[0]["m08"]);
          double m09 = double.parse(jsonRes[0]["m09"]);
          double sum4 = double.parse(jsonRes[0]["sum4"]);
          String stwork = jsonRes[0]["stwork"];
          int whocreate = (jsonRes[0]["whocreate"] == null)
              ? 0
              : int.parse(jsonRes[0]["whocreate"]);
          String createtime = (jsonRes[0]["createtime"] == null)
              ? ''
              : jsonRes[0]["createtime"];
          int whouse = (jsonRes[0]["whouse"] == null)
              ? 0
              : int.parse(jsonRes[0]["whouse"]);
          String lastaccess = (jsonRes[0]["lastaccess"] == null)
              ? ''
              : jsonRes[0]["lastaccess"];
          String unit_chk =
              (jsonRes[0]["unit_chk"] == null) ? '' : jsonRes[0]["unit_chk"];
          String st_rx =
              (jsonRes[0]["st_rx"] == null) ? '' : jsonRes[0]["st_rx"];
          double st_malloc = (jsonRes[0]["st_malloc"] == null)
              ? 0.00
              : double.parse(jsonRes[0]["st_malloc"]);

          exp = Expedite(
            idlist: idlist,
            id_exp_spen: idExpSpen,
            list_exp_spen: listExpSpen,
            memo_th: memoTh,
            mborder: mBorder,
            malloc: mAlloc,
            status: status,
            daystart: daystart,
            daystop: daystop,
            code_bud_rtarf: code_bud_rtarf,
            field_work: field_work,
            exp_type: exp_type,
            int_group: int_group,
            unit_use: unit_use,
            unit_oper: unit_oper,
            bud_type: bud_type,
            mpay: mpay,
            bpay_n: bpay_n,
            bpay: bpay,
            cpay: cpay,
            dpay: dpay,
            spay: spay,
            spay_n: spay_n,
            opay: opay,
            tpay: tpay,
            tlpay: tlpay,
            stpay: stpay,
            balan: balan,
            years: years,
            m10: m10,
            m11: m11,
            m12: m12,
            sum1: sum1,
            m01: m01,
            m02: m02,
            m03: m03,
            sum2: sum2,
            m04: m04,
            m05: m05,
            m06: m06,
            sum3: sum3,
            m07: m07,
            m08: m08,
            m09: m09,
            sum4: sum4,
            stwork: stwork,
            whocreate: whocreate,
            createtime: createtime,
            whouse: whouse,
            lastaccess: lastaccess,
            unit_chk: unit_chk,
            st_rx: st_rx,
            st_malloc: st_malloc,
          );

          return exp;
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
        UnitName un =
            new UnitName(uint: "0", uint_name: "กรุณาเลือกหน่วยที่ต้องการ");
        unitList.add(un);

        return unitList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<List<UnitName>?> getUnitList() {
    Future<List<UnitName>?> tmplist;
    tmplist = getDataUnit();
    return tmplist;
  }

//=========================================================
  Future<Object?> fetchData(String query) async {
    String url = "http://$ipAddress/phpFlutterBudget/FlutterGetData.php";

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

//=========================================================
  Future<Account?> getAccDetail(String aid) async {
    Account acc;
    String url = "http://$ipAddress/phpFlutterBudget/GetAccDetail.php";
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
          String mobile = jsonRes["mobile"] ?? '';
          int uid = int.parse(jsonRes["Uint"]);
          int uses = int.parse(jsonRes["uses"]);
          int login =
              (jsonRes["login"] == null) ? 0 : int.parse(jsonRes["login"]);

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
    String url = "http://$ipAddress/phpFlutterBudget/GetAccSearch.php";

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
  Future<List<BookUnit>?> getBookStartSearch(String cond, String years) async {
    String url = "http://$ipAddress/phpFlutterBudget/GetBookStartSearch.php";

    final response =
        await http.post(Uri.parse(url), body: {"cond": cond, "years": years});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<BookUnit> bookList = items.map<BookUnit>((json) {
          return BookUnit.fromJson(json);
        }).toList();

        return bookList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//=========================================================
  Future<List<BookUnit>?> getBookStartSearchUnit(
      String cond, String years, String uid) async {
    String url =
        "http://$ipAddress/phpFlutterBudget/GetBookStartSearchUnit.php";

    final response = await http
        .post(Uri.parse(url), body: {"cond": cond, "years": years, "uid": uid});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<BookUnit> bookList = items.map<BookUnit>((json) {
          return BookUnit.fromJson(json);
        }).toList();

        return bookList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

  //=========================================================
  Future<BookUnit?> getBookIdJob(String id_job, String years) async {
    String url = "http://$ipAddress/phpFlutterBudget/getBookIdJob.php";

    final response = await http
        .post(Uri.parse(url), body: {"id_job": id_job, "years": years});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        BookUnit book = BookUnit.fromJson(json.decode(response.body.trim()));

        return book;
      } else {
        return null;
      }
    } else {
      return null;
      //throw Exception('Failed to load data from Server.');
    }
  }

//=====================tbl_status=======================
  Future<String> getStatusMsg(id_msg) async {
    String url = "http://$ipAddress/phpFlutterBudget/get_msg_status_detail.php";

    final response = await http.post(Uri.parse(url), body: {"id_msg": id_msg});
    if (response.statusCode == 200) {
      //log(response.body);

      if (response.body.trim() != "") {
        return response.body.trim();
      } else {
        return "";
      }
    } else {
      return "";
      //throw Exception('Failed to load data from Server.');
    }
  }

//====================== Table Status ================================

  Future<List<TBStatusSearch>?> GetTBStatusSearch(
      String cond, String years, String sent_to) async {
    String url = "http://$ipAddress/phpFlutterBudget/GetTBStatusSearch.php";

    final response = await http.post(Uri.parse(url),
        body: {"cond": cond, "years": years, "sent_to": sent_to});
    if (response.statusCode == 200) {
      print(response.body);

      if (response.body.trim() != "") {
        final items =
            json.decode(response.body.trim()).cast<Map<String, dynamic>>();

        List<TBStatusSearch> statusList = items.map<TBStatusSearch>((json) {
          return TBStatusSearch.fromJson(json);
        }).toList();

        return statusList;
      } else {
        return null;
      }
    } else {
      throw Exception('Failed to load data from Server.');
    }
  }

//===============receive from sender in tbs_status=============================
// ReceiveExpediteUser(
  // txtNoDocRx.text,
  // txtStatus.text,
  // widget.tbstatus.id_exp_spen,
  // widget.tbstatus.id_job,
  // widget.tbstatus.id_status)

  Future<String> ReceiveExpediteUser(
      String no_doc_rx,
      String status_detail,
      String id_exp_spen,
      String id_job,
      String id_status,
      String etc,
      String fullname) async {
    String url = "http://$ipAddress/phpFlutterBudget/ReceiveExpedite.php";

    var Dat = <String, dynamic>{};
    Dat['id_exp_spen'] = id_exp_spen;
    Dat['id_job'] = id_job;
    Dat['id_status'] = id_status;
    Dat['no_doc_rx'] = no_doc_rx;
    Dat['status_detail'] = status_detail;
    Dat['fullname'] = fullname;
    Dat['etc'] = etc;

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

//======================================================
  static Future<String> createTable(String tb) async {
    String url = "http://$ipAddress/phpFlutterBudget/CreateTable.php";

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

  //==============Send to Create QRCODE =====================================
  Future<String> SentURLQRCODE(String id_exp_spen, String site) async {
    String url = "http://$ipAddress/$site/qrcode/getURLFromFlutter.php";

    var Dat = <String, dynamic>{};
    Dat['id_exp_spen'] = id_exp_spen;

    final response = await http.post(Uri.parse(url),
        headers: {"Accept": "application/json"}, body: json.encode(Dat));

    if (response.statusCode == 200) {
      print("return response : " +
          response.body.trim()); // check the status code for the result

      return response.body.trim();
    } else {
      return "";
    }
  }
}
