import 'package:flutter/material.dart';
//import '../../components/coustom_bottom_nav_bar.dart';
//import '../../../global/enums.dart';
import '../../widget_share/SideMenuLeftAdmin.dart';
import '../../../styles/colors.dart';
import '../../styles/TextStyle.dart';

class AdminSystem extends StatelessWidget {
  static String routeName = "/adminsystem";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuLeftAdmin(),
      appBar: AppBar(
        title: const Text(
          'J6 Budget App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: lightpurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/icon_win42.jpg",
            width: MediaQuery.of(context).size.width * 0.5,
            //fit: BoxFit.cover,
            //fit: BoxFit.fitWidth,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'หน้าบริหารระบบ สำหรับแอดมิน !!!',
                style: styleCustom('', 23.0, purple, true),
              ),
            ),
          ),
        ],
      ),
      //bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
