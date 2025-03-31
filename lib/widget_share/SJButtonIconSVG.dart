import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import '../global/size_config.dart';

class SJButtonIconSVG extends StatelessWidget {
  final String iconStr;
  final String? text;
  final double width;
  final double height;
  final Function? press;
  final Color bgcolor;
  final Color txtcolor;
  final double fontSize;
  final double widthIcon;
  final double heightIcon;
  final double radius;

  const SJButtonIconSVG({
    Key? key,
    this.text,
    required this.width,
    required this.height,
    this.press,
    required this.bgcolor,
    required this.txtcolor,
    required this.radius,
    required this.iconStr,
    required this.widthIcon,
    required this.heightIcon,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String iconVal = "";

    if (iconStr == 'logout')
      iconVal = "assets/icons/logout_icon.svg";
    else if (iconStr == 'login')
      iconVal = "assets/icons/login_mini_icon.svg";
    else if (iconStr == 'close')
      iconVal = "assets/icons/Close.svg";
    else if (iconStr == 'back')
      iconVal = "assets/icons/Back ICon.svg";
    else if (iconStr == 'setting')
      iconVal = "assets/icons/Settings.svg";
    else if (iconStr == 'appicon')
      iconVal = "assets/icons/app_icon.svg";
    else if (iconStr == 'exit')
      iconVal = "assets/icons/icon-exit.svg";
    else if (iconStr == 'left')
      iconVal = "assets/icons/arrow_button_left.svg";
    else if (iconStr == 'right')
      iconVal = "assets/icons/arrow_button_right.svg";
    else if (iconStr == 'add')
      iconVal = "assets/icons/add.svg";
    else if (iconStr == 'save')
      iconVal = "assets/icons/Save.svg";
    else if (iconStr == '')
      iconVal = "assets/icons/app_icon.svg";
    else
      iconVal = iconStr;

    return Container(
      //width: double.maxFinite,
      width: (width == 1) ? double.maxFinite : width,
      height: height,
      child: ElevatedButton(
        // style: ButtonStyle(
        //   backgroundColor:
        //       MaterialStateProperty.all<Color>(bgcolor), // All states
        //   // foregroundColor:
        //   //     MaterialStateProperty.all<Color>(Colors.white), // All states
        //   elevation:
        //       MaterialStateProperty.all<double>(15.0), // Set elevation too
        // ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          backgroundColor: bgcolor,
          elevation: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: widthIcon,
                height: heightIcon,
                child: SvgPicture.asset(
                  iconVal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: txtcolor),
              ),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
