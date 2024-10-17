import 'package:flutter/material.dart';
import '../../../global/size_config.dart';
//import 'categories.dart';
//import 'discount_banner.dart';
import 'home_header.dart';
//import 'special_offers.dart';
import '../../../styles/colors.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //SizedBox(height: getProportionateScreenHeight(20)),
            Container(
                color: bgcolorApp,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeHeader(),
                )),
            SizedBox(height: getProportionateScreenWidth(10)),
            //DiscountBanner(),
            //Categories(),
            //SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            Text(''),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
