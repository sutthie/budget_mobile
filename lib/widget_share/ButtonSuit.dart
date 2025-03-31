import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:budget_mobile/styles/TextStyle.dart';
import '../styles/colors.dart';

Widget ButtonIconSVG(String txt, String iconStr, VoidCallback onPressed) {
  // if (iconStr == 'logout')
  //   iconStr = "assets/icons/Call.svg";
  // else if (iconStr == 'login')
  //   iconStr = "assets/icons/Bell.svg";
  // else
  //   iconStr = "assets/icons/Error.svg";

  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(horizontal: 25),
    child: ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(
              iconStr,
            ),
          ),
          Text(
            txt,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          Container()
        ],
      ),
      onPressed: onPressed,
    ),
  );
}

Widget resetButonMaxSize(context, radius, VoidCallback onPressed) {
  return Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(radius),
    color: red,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      highlightColor: Colors.amber, //on press button change color
      onPressed: onPressed,
      child: Text("Reset", textAlign: TextAlign.center, style: styleHeadWhite5),
    ),
  );
}

Widget IconsButton(String iconStr, width, height, VoidCallback onPressed) {
  return IconButton(
    icon: SvgPicture.asset(
      iconStr,
      width: width,
      height: height,
      //color: blue,
    ),
    onPressed: onPressed,
  );
}
