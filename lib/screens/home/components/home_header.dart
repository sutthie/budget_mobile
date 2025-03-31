import 'package:flutter/material.dart';
import '../../../global/size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import '../../../screens/home/MainScreen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: SearchField(),
          ),
          // IconBtnWithCounter(
          //   svgSrc: "assets/icons/Cart Icon.svg",
          //   numOfitem: 3,
          //   press: () => Navigator.pushNamed(context, ''),
          // ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: IconBtnWithCounter(
              svgSrc: "assets/icons/Bell.svg",
              numOfitem: 3,
              //press: () {},
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                    //builder: (context) => AdvertScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
