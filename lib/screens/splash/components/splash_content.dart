import 'package:flutter/material.dart';
import '../../../styles/TextStyle.dart';
import '../../../global/constants.dart';
import '../../../global/size_config.dart';
import '../../../styles/colors.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "BfriendAuto",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(34),
            color: bPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(text!,
            textAlign: TextAlign.center,
            //style: TextStyle(fontWeight: FontWeight.normal),
            style: styleSmalless(bluedark)),
        Spacer(flex: 1),
        Image.asset(
          image!,
          //height: getProportionateScreenHeight(265),
          // width: getProportionateScreenWidth(235),
          height: getProportionateScreenHeight(295),
          //width: MediaQuery.of(context).size.width,
          width: getProportionateScreenWidth(350),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
