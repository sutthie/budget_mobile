import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Test Read QRCode'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String strQrCode = '';
  bool showScanner = false;

  //======widget user===================

  Widget ShowScanner() {
    return Container(
      child: SizedBox(
        width: 200,
        height: 200,
        child: QRBarScannerCamera(
          onError: ((context, error) => Text(error.toString())),
          qrCodeCallback: (code) {
            print(code);
            setState(() {
              strQrCode = code.toString();
              showScanner = false;
            });
          },
        ),
      ),
    );
  }

  Widget buttonScan() {
    return ElevatedButton(
      //style: style,
      onPressed: () {
        setState(() {
          showScanner = true;
        });
      },
      child: Icon(Icons.camera),
    );
  }

  Widget Label_Result_Qr() {
    return Text('Result Scan QR Code : ' + strQrCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          showScanner ? ShowScanner() : Container(),
          const Text(
            'Test Read QR Code:',
          ),
          Label_Result_Qr(),
          buttonScan(),
        ],
      ),
    );
  }
}
