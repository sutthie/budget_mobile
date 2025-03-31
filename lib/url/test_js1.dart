import 'package:budget_mobile/styles/TextStyle.dart';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';

class test_js1 extends StatefulWidget {
  const test_js1({super.key});

  @override
  State<test_js1> createState() => _test_js1_State();
}

class _test_js1_State extends State<test_js1> {
  //Map<String, PreviewData> datas = {};
//http://10.130.230.64/budget1/Follow/doc/5754_ข้าราชการไทยยุคใหม่เข้า รพเอกชน ได้แล้ว.pdf
  String fn = 'S__328314.jpg';
  String fn1 =
      '641111-0307.8-2140-ขอเบิกเงินเพื่อใช้ในการจัดประชุมบูรณาการคำของบประมาณรายจ่าย งป.pdf';
  //String fn ='5754_%E0%B8%82%E0%B9%89%E0%B8%B2%E0%B8%A3%E0%B8%B2%E0%B8%8A%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B9%84%E0%B8%97%E0%B8%A2%E0%B8%A2%E0%B8%B8%E0%B8%84%E0%B9%83%E0%B8%AB%E0%B8%A1%E0%B9%88%E0%B9%80%E0%B8%82%E0%B9%89%E0%B8%B2%20%E0%B8%A3%E0%B8%9E%E0%B9%80%E0%B8%AD%E0%B8%81%E0%B8%8A%E0%B8%99%20%E0%B9%84%E0%B8%94%E0%B9%89%E0%B9%81%E0%B8%A5%E0%B9%89%E0%B8%A7.pdf';
  String urlStr = 'http://10.130.230.64/budget1/Follow/doc/';
  // late String fullUrl = urlStr + Uri.encodeComponent(fn);
  late String fullUrl = urlStr + Uri.encodeComponent(fn1);
  late String fullUrlnoEncode = urlStr + fn1;

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text(widget.title),
        title: Text(
          "ปรับปรุงข้อมูลผู้ใช้",
          style: styleHeadWhite4,
        ),
      ),
      backgroundColor: lightyellow2,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.9,
            alignment: Alignment.center,
            color: lightgreen2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_link),
                          label: const Text('Test Alert')),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {},
                          icon: const Icon(Icons.add_link),
                          label: const Text('Open Url : www')),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {},
                          icon: const Icon(Icons.add_link),
                          label: const Text('Open Budget Web App')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
