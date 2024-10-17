import 'package:budget_mobile/styles/TextStyle.dart';
import 'package:budget_mobile/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class test_url_launcher extends StatefulWidget {
  const test_url_launcher({super.key});

  @override
  State<test_url_launcher> createState() => _test_url_launcherState();
}

class _test_url_launcherState extends State<test_url_launcher> {
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
                      TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(fullUrl)).onError(
                            (error, stackTrace) {
                              print("Url is not valid!");
                              return false;
                            },
                          );
                        },
                        child: Text('Open link 1 Work'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          launchURL(fullUrl);
                        },
                        child: Text('Openlink User Fuction'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            if (!await launchUrl(Uri.parse(fullUrl))) {
                              throw 'Could not launch $fullUrl';
                            }
                          },
                          icon: const Icon(Icons.add_link),
                          label: const Text('View Url Work')),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            Uri uri = Uri.parse("https://www.google.co.th");
                            if (!await launchUrl(uri)) {
                              throw 'Could not launch $fullUrl';
                            }
                          },
                          icon: const Icon(Icons.add_link),
                          label: const Text('Open Url : www')),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            Uri uri = Uri.parse(
                                "http://10.130.230.64/budget1/index.htm");
                            if (!await launchUrl(uri)) {
                              throw 'Could not launch $fullUrl';
                            }
                          },
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

  launchURL(url) async {
    Uri uri = Uri.parse(fullUrl);
    if (await launchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      throw 'Could not launch $fullUrl';
    }
  }
}
