import 'package:flutter/material.dart';
import '../styles/colors.dart';

ButtonStyle styleButtonCustom(bgcolor) {
  //bgcolor = red;
  return ButtonStyle(backgroundColor: MaterialStateProperty.all(bgcolor));
}
