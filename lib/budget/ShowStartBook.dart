import '../global/DateTimes.dart';
import '../global/ManageLogin.dart';
import '/styles/colors.dart';
import 'package:flutter/material.dart';
//import 'Dialog.dart';
import '../models/BookUnit.dart';
import '../global/MySQLService.dart';
import '../global/ResponseMessage.dart';
import '../global/GetYearBudget.dart';
import 'package:budget_mobile/styles/TextStyle.dart';
import '../global/FormatMoney.dart';
//import 'StartExpedite.dart';
import 'StartExpediteUser.dart';

var login;

class ShowStartBook extends StatefulWidget {
  static String routeName = "/showstartbook";

  @override
  _GetBudgetState createState() => _GetBudgetState();
}

class _GetBudgetState extends State<ShowStartBook>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  //String cond = "";

  // ====declare var========
  late Future<List<BookUnit>?> datList;

  //==========dropdown init======
  // Default Drop Down Item.
  //String dropdownValue = '2565';
  // To show Selected Item in Text.
  String selyear = "";
  String uid = "0";
  //late String uid;
// init year now
  GetYearBudget yb = new GetYearBudget();
  late int yearNow;

  DateTimes DT = DateTimes();
  late DateTime dateTmp;
  String dateF = "";

  //int yearNow = DateTime.now().year.toInt() + 543;
  late List<int> listyear;

  Future<List<BookUnit>?> getDataList(
      String txtsearch, String ddlyear, String id_use_int) {
    Future<List<BookUnit>?> dat;
    MySQLDB mydb = new MySQLDB();
    dat = mydb.getBookStartSearchUnit(txtsearch, ddlyear, id_use_int);
    return dat;
  }

  //=====Controller Text===========
  final txtSearch = TextEditingController();

  Future<List<BookUnit>?> GetBoxData() async {
    Future<List<BookUnit>?> tmplist;

    // init data
    yearNow = yb.getYearBudget();
    listyear = [for (var i = yearNow - 5; i <= yearNow; i++) i];

    selyear = yearNow.toString();

    ManageLogin _login = ManageLogin();
    login = await _login.DefineBox();
    uid = login.get("uid");

    tmplist = getDataList(txtSearch.text.trim(), selyear, uid);

    return tmplist;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    datList = GetBoxData();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleHead = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    );

    TextStyle styleLabel = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      //decorationColor: Colors.yellowAccent.shade100,
      backgroundColor: Colors.white,
    );

    TextStyle styleInput = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 16.0,
      color: Colors.black,
    );

//Create ListView using data get from service
    Widget listBookWidget(context, snapshot) {
      //final String idExpSpen = "";
      if (snapshot.data != null && snapshot.data.length > 0) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            BookUnit book = snapshot.data[index];

            dateTmp = DateTime.parse(book.unit_date_no);

            dateF = DT.ConvertDateThaiNow(dateTmp);

            return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text('${book.title}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                    )),
                              ),
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
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                  'ที่หนังสือ : ${book.doc_unit_no} | วันที่ : ${dateF} ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    //fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Row(
                                          children: [
                                            Text(
                                                'จำนวนเงิน : ${FormatMoney.setFormat(book.amout)} บาท',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  //fontWeight: FontWeight.bold
                                                )),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          // Text('สถานะ : ${book.send}',
                                          //     style: TextStyle(
                                          //         fontSize: 18,
                                          //         fontWeight: FontWeight.bold)),
                                          if (book.send == '0')
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      2.0, 0, 0, 0),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.indigo)),
                                                child: Text(
                                                  "ส่ง",
                                                  style: styleHeadYellow3,
                                                ),
                                                onPressed: () {
                                                  //
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          StartExpediteUser(
                                                              id_exp_spen: book
                                                                  .id_exp_spen,
                                                              id_job: book
                                                                  .id_job
                                                                  .toString(),
                                                              sel_year:
                                                                  selyear),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  )),
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(15),
                color: white, // Set background color for the SizedBox
                child: Text(
                  "ไม่พบข้อมูลใดๆ!!!\nกรุณากดปุ่ม ย้อนกลับ หรือ Reset",
                  style: styleError20,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
    }

// call from Body Part in Scaffold
// Main Display ListView call listExpenWidget for create ListView
    Widget BookWidget(data) {
      return FutureBuilder(
          //future: mydb.getExpSearch("", years),
          future: data,
          builder: (context, tbDBSnap) {
            switch (tbDBSnap.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              /* case ConnectionState.done:
            return */
              default:
                if (tbDBSnap.hasError)
                  return new Text('Error: ${tbDBSnap.error}');
                else
                  return listBookWidget(context, tbDBSnap);
            }
          });
    }

    Widget txtsearch() {
      return TextField(
        style: styleInput,
        //autofocus: true,
        controller: txtSearch,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
            filled: true,
            fillColor: Colors.yellowAccent.shade100,
            hintText: "ค้นหา",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(2.0))),
        onSubmitted: (v) {
          //_fieldFocusChange(context, _focus, _nextFocus);
        },
      );
    }

    final ddlYearNew = DropdownButton(
      value: yearNow,
      items: listyear.map((int item) {
        return DropdownMenuItem<int>(
          child: Text('$item'),
          value: item,
        );
      }).toList(),
      onChanged: (value) {
        selyear = value.toString();
        //if not found alert no found
        datList = getDataList(txtSearch.text.trim(), selyear, uid);

        ResponseMessage resp = new ResponseMessage();

        datList.then((ret_value) {
          if (ret_value == null) {
            resp.Alert(context, "ไม่พบข้อมูล", "ไม่พบข้อมูลของปีที่เลือก !!!");
          }
          setState(() {
            yearNow = value as int;
          });
        });
      },
      //hint: Text("เลือกปีงบประมาณ"),
      disabledHint: Text("Disabled"),
      elevation: 8,
      //style: TextStyle(color: Colors.green, fontSize: 16),
      style: styleLabel,
      icon: Icon(Icons.arrow_drop_down_circle),
      iconDisabledColor: Colors.red,
      iconEnabledColor: Colors.blue,
      iconSize: 30,
    );

//======widget button==========
    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
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
          //getDropDownItem();
          setState(() {
            // datList =
            //     getDataList(txtSearch.text.trim(), yearNow.toString(), uid);
            datList = getDataList(txtSearch.text.trim(), selyear, uid);
          });
        },
        child: Text("ค้นหา",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    final backButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.blue,
      child: MaterialButton(
        //minWidth: MediaQuery.of(context).size.width,
        minWidth: 45,
        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
        highlightColor: Colors.amber, //on press button change color
        onPressed: () {
          //Navigator.of(context).pop();
//  Navigator.of(context).pushNamedAndRemoveUntil(MainPage.routeName, (Route<dynamic> route) => false);
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/mainpage', (Route<dynamic> route) => false);
        },
        child: Text("ย้อนกลับ",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    final ResetButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(20.0),
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
            yearNow = yb.getYearBudget();
            datList = getDataList("", yearNow.toString(), uid);
          });
        },
        child: Text("Reset",
            textAlign: TextAlign.center,
            style: styleInput.copyWith(color: Colors.white, fontSize: 14
                //fontWeight: FontWeight.bold
                )),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "งบประมาณประจำปี",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('เลือกปีงบประมาณ', style: styleHead),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.all(3),
                width: 75,
                height: 33,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1),
                ),
                child: Center(
                  // Center the DropdownButton horizontally
                  child: ddlYearNew,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('ค้นหา', style: styleHead),
              ),
              Container(width: 170.0, child: txtsearch()),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: searchButon,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ResetButon,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: backButon,
              )
              //ddlYear,
              //txtsearch,
            ],
          ),
          Flexible(fit: FlexFit.tight, child: BookWidget(datList)),
        ],
      ),
    );
  }
}
