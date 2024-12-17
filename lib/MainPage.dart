import 'package:flutter/material.dart';
import 'widget_share/SideMenuLeft.dart';

class MainPage extends StatelessWidget {
  static String routeName = "/mainpage";

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuLeft(),
      appBar: AppBar(
        title: const Text(
          'หน้าหลัก',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.cyan[200],
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints.expand(height: 100, width: 400),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10), // Add border radius here
              ),
              child: ClipRRect(
                // Clip the image to match the container's border radius
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/budget-banner.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          const Text(
            'CopyRight 2021-2025 by FS1.Sutthie J.',
            style: TextStyle(color: Colors.brown, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
