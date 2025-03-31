import 'package:flutter/material.dart';
import '../../components/coustom_bottom_nav_bar.dart';
import '../../../global/enums.dart';
import '../../widget_share/SideMenuLeft.dart';
import 'components/body.dart';
import '../../../styles/colors.dart';
//import '../../styles/TextStyle_Bfriend.dart';

class MainScreen extends StatelessWidget {
  static String routeName = "/mainscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuLeft(),
      appBar: AppBar(
        title: const Text(
          'ระบบเร่งรัด สส.ทหาร',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: lightpurple,
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
