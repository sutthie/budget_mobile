import 'package:flutter/widgets.dart';

class HideKeyBoard {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
