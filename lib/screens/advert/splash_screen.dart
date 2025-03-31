import 'package:flutter/material.dart';
import '../advert/components/body.dart';
import '../../../global/size_config.dart';

class AdvertScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
