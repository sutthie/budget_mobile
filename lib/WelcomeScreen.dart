import 'package:flutter/material.dart';

import 'widget_share/SideMenuLeft.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuLeft(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35.0),
        child: AppBar(
          title: const Text('หน้าหลัก'),
        ),
      ),
      backgroundColor: Colors.cyan[200],
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/BeeAuto-Logo-Footer.png", //assets/image/welcome.jpg
                //fit: BoxFit.cover,
                //fit: BoxFit.fitWidth,
                width: 190,
              ),
              Image.asset(
                "assets/image/welcome.jpg",
                width: MediaQuery.of(context).size.width * 0.9,
                //fit: BoxFit.cover,
                //fit: BoxFit.fitWidth,
              ),
              const Text(
                'CopyRight 2021-2023 by Sutthie J.',
                style: TextStyle(color: Colors.brown, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
