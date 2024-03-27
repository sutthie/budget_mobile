import 'AddUser.dart';
import 'package:budget_mobile/admin/AdminSystem.dart';
import 'package:budget_mobile/styles/colors.dart';
//import 'package:budget_mobile/routes.dart';
import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//import '../global/GetUnitName.dart';
import '../global/MySQLService.dart';
import '../global/ResponseMessage.dart';
import '../global/globalVar.dart';
import '../models/Account.dart';
import '../models/UnitName.dart';
import 'EditAccDetail.dart';
//import 'ShowAccDetail.dart';

String Aid = "";

class ShowAccount extends StatefulWidget {
  static String routeName = "/showacc";
  @override
  _ShowAccountState createState() => _ShowAccountState();
}

class _ShowAccountState extends State<ShowAccount>
    with SingleTickerProviderStateMixin {
//============init Box==============================
  // var box;

  // String UserID = "";
  // String Token = "";
  // String FullName = "";
  // //String Email = "";
  // String Status = "";

  MySQLDB mydb = MySQLDB();

  _ShowAccountState() {
    //DefineBox();
  }

  //=================set Hive for Global Data===================
  // await Hive.initFlutter();
  // box = await Hive.openBox('LoginData');
  // box.put('aid', dat["aid"]);
  // box.put('userid', dat['userid']);
  // box.put('uid', dat['uid']);
  // box.put('fullname', dat['fullname']);
  // box.put('email', dat['email']);
  // box.put('status', dat["status"]);
  // box.put('token', dat["token"]);
//============================================================

  // DefineBox() async {
  //   await Hive.initFlutter();
  //   box = await Hive.openBox('LoginData');
  //   // get from Hive
  //   Aid = box.get('aid');
  //   UserID = box.get('userid');
  //   Status = box.get('status');
  //   FullName = box.get('fullname');
  //   // Email = box.get('email');
  //   Token = box.get('token');
  // }

//=====define TextEditingController======
//===============defind var/object==================
  //String seluid = "0";
  //String unitNow = "0";
  late String seluid; // for search or filter
  late String? unitNow; // for set ddl

  late Future<List<Account>?> datList;
  late Future<List<UnitName>?> unitList;
  late UnitName utmp;

  // late AnimationController _animationController;

  //=========Controller Text==============
  final txtSearch = TextEditingController();

//=============method class state===========
  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(vsync: this);
    AnimationController(vsync: this);
    // init data

    //unitNow = "30";
    unitNow = null;
    seluid = "";

    unitList = mydb.getUnitList();
    //debugPrint(unitList.toString());

    datList = getDataList(txtSearch.text.trim(), unitNow ?? '');

    // setState(() {
    //   unitNow = null;
    //   datList = getDataList(txtSearch.text.trim(), unitNow ?? '');
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   log("Work by didChangeDependencies");
  // }

  // @override
  // void didUpdateWidget(covariant ShowAccount oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   log("Work by didUpdateWidget");
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   log("Deactivate Page Widget");
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _animationController.dispose();
  //   log("Dispose Page Widget");
  // }

  Future<List<Account>?> getDataList(String txtsearch, String uid) {
    Future<List<Account>?> tmplist;
    tmplist = mydb.getAccSearch(txtsearch, uid);
    return tmplist;
  }

  // void setDropDownItem(String v) {
  //   setState(() {
  //     unitNow = v;
  //   });
  // }

//==========defind widget style=============
  TextStyle styleHead = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.purple,
  );

  TextStyle styleLabel = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
    color: Colors.green.shade900,
    //color: Colors.red,
    fontWeight: FontWeight.bold,
    //decorationColor: Colors.yellowAccent.shade100,
    backgroundColor: Colors.white,
  );

  TextStyle styleDropDownList = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18.0,
    color: Colors.green.shade900,
    //color: Colors.red,
    fontWeight: FontWeight.bold,
    //decorationColor: Colors.yellowAccent.shade100,
    //backgroundColor: white,
    backgroundColor: lightyellow2,
  );

  TextStyle styleError = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
    //color: Colors.green.shade900,
    color: Colors.red,
    fontWeight: FontWeight.bold,
    //decorationColor: Colors.yellowAccent.shade100,
    backgroundColor: Colors.white,
  );

  TextStyle styleNormal = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "แสดงข้อมูลแอคเค้าท์",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            //fontFamily: 'Montserrat',
            //fontWeight: FontWeight.bold
          ),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: mainBody(),
      //body: fb,
    );
  }

  Widget mainBody() {
//==========defind var====================
    //MySQLDB db = MySQLDB();
    var fb = buildFutureBuilder(datList);

//==========defind widget====================
    final txtsearch = TextField(
      style: styleNormal,
      //autofocus: true,
      controller: txtSearch,
      decoration: InputDecoration(
        focusColor: blue,
        contentPadding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        filled: true,
        fillColor: Colors.yellowAccent.shade100,
        hintText: "ค้นหา",
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        //border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        //OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)))
      ),
      onSubmitted: (v) {
        //_fieldFocusChange(context, _focus, _nextFocus);
      },
    );

    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.greenAccent.shade700,
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        minWidth: 70,
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        //highlightColor: Colors.amber, //on press button change color
        highlightColor:
            Colors.greenAccent.shade400, //on press button change color
        onPressed: () {
          //Navigator.of(context).pop();
          //MessageDialog dlg = new MessageDialog();
          //dlg.msgBox(context, txtSearch.text);
          //cond = txtSearch.text;
          setState(() {
            //datList = getDataList(txtSearch.text.trim(), seluid.toString());
            datList = getDataList(txtSearch.text.trim(), unitNow ?? '');
          });
        },
        child: Text("ค้นหา",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    final backButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.blue,
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        minWidth: 45,
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          //Navigator.of(context).pop();
          Navigator.of(context).pushNamedAndRemoveUntil(
              AdminSystem.routeName, (Route<dynamic> route) => false);
        },
        child: Text("หน้าหลัก",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    final ResetButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(15.0),
      color: Colors.redAccent,
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        minWidth: 45,
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          //Navigator.of(context).pop();
          txtSearch.text = "";
          setState(() {
            unitNow = null;
            datList = getDataList("", unitNow ?? '');
          });
        },
        child: Text("Reset",
            textAlign: TextAlign.center,
            style: styleNormal.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    //==========end defind widget====================

    return Column(
      children: [
        Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
              child: Text('เลือกหน่วยงาน', style: styleHead),
            ),
            //ddlUnit,
            Padding(
              padding: EdgeInsets.fromLTRB(6, 6, 0, 0),
              child: Container(
                  color: lightyellow2,
                  //width: 300.0,
                  child: ddlUnit(unitList)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(3, 6, 0, 0),
              child: IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  Navigator.pushNamed(context, AddUser.routeName);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Text('ค้นหา', style: styleHead),
                  Container(
                      width: 140.0,
                      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: txtsearch),
                  searchButon,
                  SizedBox(
                    width: 3,
                  ),
                  backButon,
                  SizedBox(
                    width: 3,
                  ),
                  ResetButon
                ],
              ),
            ),

            //ddlYear,
            //txtsearch,
          ],
        ),

        Flexible(
          fit: FlexFit.tight,
          child: fb,
        )

        //SizedBox(  // can define heigh of ListView
        //height: 400, // constrain height
        //  child: fb,
        //)
        //Expanded(
        //  child: fb,
        //child: buildFutureBuilder(datList),
        //),

        //ddlYear,
        //txtsearch,
      ],
    );
  }

  Widget ddlUnit(udata) {
    return FutureBuilder<List<UnitName>?>(
        future: udata,
        builder: (context, snapshot) {
          //(BuildContext context, AsyncSnapshot<List<UnitName>?> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return DropdownButton(
            //return DropdownButton<String>(
            items: snapshot.data
                ?.map((item) => DropdownMenuItem(
                      //?.map((item) => DropdownMenuItem<String>(
                      child: Text(item.uint_name),
                      value: item.uint,
                    ))
                .toList(),
            value: unitNow,
            //value: null,
            onChanged: (un) {
              setState(() {
                unitNow = un.toString();
              });
              // ignore: unused_local_variable
              var msg = new ResponseMessage();
              //msg.Alert(context, "เลือกหน่วยงาน", unitNow.toString());
            },
            //isExpanded: true,
            hint: Text('เลือกหน่วยที่ต้องการ'),
            disabledHint: Text("Disabled"),
            elevation: 8,
            style: styleDropDownList,
            //style: Theme.of(context).textTheme.labelMedium,
            //style: Theme.of(context).textTheme.bodyText2,
            //dropdownColor: Colors.white,
            dropdownColor: lightyellow2,
            //focusColor: Colors.yellow.shade100,
            focusColor: white,
            icon: Icon(Icons.arrow_drop_down_circle),
            iconDisabledColor: Colors.red,
            iconEnabledColor: Colors.blue,
            iconSize: 30,
          );
        });
  }

  Widget buildFutureBuilder(data) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          /* case ConnectionState.done:
          return */
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return listAccountWidget(context, snapshot);
            }
        }
      },
    );
  }
}

Widget listAccountWidget(context, snapshot) {
  //List<String> datList = snapshot.data;
  if (snapshot.data != null && snapshot.data.length > 0) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        Account acc = snapshot.data[index];
        return GestureDetector(
          onTap: () {
            //msgBox(context, '${acc.userid}');
            Aid = acc.aid;
            //msgBox(context, '${spen.list_exp_spen}');
            //Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditAccDetail(Aid),
                //builder: (context) => ShowAccountDetail(Aid),
                //builder: (context) => ShowBudgetDetail('${spen.list_exp_spen}'),
              ),
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    //height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              '${index += 1}. ${acc.firstname} ${acc.lastname} => UserId : ${acc.userid}',
                              style: const TextStyle(fontSize: 16.0)),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                        color: Colors.blue[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                // var msg = new ResponseMessage();
                                // msg.Alert(
                                //     context, "รหัสผ่าน", '${acc.passwords}');

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditAccDetail(Aid),
                                  ),
                                );
                              },
                              child: Text('รหัสผ่าน : ${acc.passwords}',
                                  style: TextStyle(fontSize: 14))),
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  } else
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "ไม่พบข้อมูลใดๆ กดปุ่ม Reset",
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
          backgroundColor: Colors.grey.shade100,
        ),
      ),
    );
}
