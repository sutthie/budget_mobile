import 'package:flutter/material.dart';
import 'global/size_config.dart';
import 'styles/colors.dart';
import 'styles/TextStyle.dart';

import './widget_share/SJButton.dart';
import 'widget_share/SJButtonIcon.dart';
import 'widget_share/SJButtonIconSVG.dart';

class TestSJComponet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = SizeConfig.screenWidth;

    return Scaffold(
      //key: _scaffoldstate,
      appBar: AppBar(
        title: Text('Test Upload File', style: styleHeadWhite5),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed: () {}, child: Text('ทดสอบ TextButton')),
          SJButton(
            text: "ทดสอบสร้างปุ่ม SJButton",
            press: () {},
            bgcolor: green,
            txtcolor: red,
            //width: 1, // full size
            width: width * 0.9,
            height: 60,
            radius: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SJButtonIcon(
              text: "ทดสอบสร้างปุ่ม SJButtonIcon",
              fontSize: 25,
              bgcolor: red,
              iconStr: '',
              radius: 20,
              txtcolor: yellow,
              widthIcon: 50,
              heightIcon: 50,
              //width: 1, //full size
              width: 400,
              height: 130,
              press: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SJButtonIconSVG(
              text: "ทดสอบสร้างปุ่ม SJButtonIconSVG",
              fontSize: 25,
              bgcolor: yellow,
              iconStr: 'login',
              radius: 10,
              txtcolor: purple,
              widthIcon: 50,
              heightIcon: 50,
              //width: 1=full size
              width: 450,
              //width: 1,
              height: 150,
              press: () {},
            ),
          ),
        ],
      ),
    );
  }
}
