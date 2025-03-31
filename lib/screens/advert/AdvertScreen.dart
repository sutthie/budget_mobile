import 'package:flutter/material.dart';
import './components/body.dart';
import '../../../global/size_config.dart';
//import '../../styles/colors.dart';

class AdvertScreen extends StatelessWidget {
  static String routeName = "/advert";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //body: SafeArea(child: Body()),
      body: Body(),
    );
  }
}
