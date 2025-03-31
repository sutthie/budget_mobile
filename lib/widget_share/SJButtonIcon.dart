import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
//import '../global/size_config.dart';

class SJButtonIcon extends StatelessWidget {
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

  const SJButtonIcon({
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
      iconVal = "assets/images/logout_small2.png";
    else if (iconStr == 'login')
      iconVal = "assets/images/icons8-login-48.png";
    else if (iconStr == 'close')
      iconVal = "assets/images/x-button-small.png";
    else if (iconStr == 'back')
      iconVal = "assets/images/back1.png";
    else if (iconStr == 'setting')
      iconVal = "assets/images/setting-configure-repair.png";
    else if (iconStr == 'appicon')
      iconVal = "assets/images/app-document.png";
    else if (iconStr == 'exit')
      iconVal = "assets/images/exit_closethesession.png";
    else if (iconStr == 'left')
      iconVal = "assets/images/arrow-left-back-previous.png";
    else if (iconStr == 'right')
      iconVal = "assets/images/arrow_right_15604.png";
    else if (iconStr == 'add')
      iconVal = "assets/images/Plus_36851.png";
    else if (iconStr == 'save')
      iconVal = "assets/images/Save_37110.png";
    else if (iconStr == '')
      iconVal = "assets/images/app-document.png";
    else
      iconVal = iconStr;

    return Container(
      //width: double.maxFinite,
      width: (width == 1) ? double.maxFinite : width,
      height: height,

      child: ElevatedButton(
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
                child: Image.asset(
                  iconVal,
                  fit: BoxFit.cover,
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
