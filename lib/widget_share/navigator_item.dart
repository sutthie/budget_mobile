import 'package:flutter/material.dart';
import '../admin/account_screen.dart';
import '../admin/ShowAcc.dart';
import '../screens/home/MainScreen.dart';
import '../chat/ChatPerson.dart';

class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", "assets/icons/shop_icon.svg", 0, MainScreen()),
  NavigatorItem(
      "Explore",
      "assets/icons/explore_icon.svg",
      1,
      ChatPerson(
        title: '',
      )),
  NavigatorItem("Cart", "assets/icons/cart_icon.svg", 2, ShowAccount()),
  NavigatorItem("Account", "assets/icons/account_icon.svg", 4, AccountScreen()),
];
