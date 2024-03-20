import 'package:budget_mobile/widget_share/SideMenuLeftAdmin.dart';
import 'package:flutter/material.dart';
//import 'widget_share/SideMenuLeft.dart';

class MainPageAdmin extends StatelessWidget {
  static String routeName = "/mainpageadmin";
  const MainPageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuLeftAdmin(),
      appBar: AppBar(
        title: const Text('หน้าหลัก(Admin)'),
      ),
      backgroundColor: Colors.cyan[200],
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints.expand(
                  height: 100, width: 400), // protect over width
              child: Image.asset(
                "assets/images/budget-banner.jpg",
                //fit: BoxFit.cover,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Text(
            'CopyRight 2021-2024 by Sutthie J.',
            style: TextStyle(color: Colors.brown, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
