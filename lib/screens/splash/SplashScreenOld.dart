import 'dart:async';
import '../advert/AdvertScreen.dart';
import 'package:flutter/material.dart';
import '../../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = const Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return AdvertScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolorApp,
      body: Center(
        child: splashScreenIcon(),
      ),
    );
  }
}

Widget splashScreenIcon() {
  //String iconPath = "assets/icon/splash_screen_icon.svg";
  // return SvgPicture.asset(
  //   iconPath,
  // );
  return Container(
    child: Image.asset(
      "assets/banners/BeeAuto-Logo-Footer.png",
      //fit: BoxFit.cover,
      fit: BoxFit.fitWidth,
    ),
  );
}
