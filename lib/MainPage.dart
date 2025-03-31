import 'package:budget_mobile/global/globalVar.dart';
import 'package:flutter/material.dart';
import 'widget_share/SideMenuLeft.dart';

class MainPage extends StatelessWidget {
  static String routeName = "/mainpage";

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("MediaQuery size: $size");

    return Scaffold(
      drawer: SideMenuLeft(),
      appBar: AppBar(
        title: const Text(
          titleApp,
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.cyan[200],
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints.expand(height: 100, width: 400),
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
                ownerApp,
                style: TextStyle(color: Colors.brown, fontSize: 13),
              ),
              // ปรับ layout เพิ่มเติมตามแนวการถือถ้าจำเป็น
              // if (orientation == Orientation.landscape)
              //   const Text("Landscape Mode")
              // else
              //   const Text("Portrait Mode"),
            ],
          );
        },
      ),
    );
  }
}
