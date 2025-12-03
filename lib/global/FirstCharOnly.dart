import 'package:flutter/services.dart';

class FirstCharNotDigitFormatter extends TextInputFormatter {
  FirstCharNotDigitFormatter();

  final RegExp _digitRegExp = RegExp(r'\d');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final firstChar = newValue.text.substring(0, 1);
    if (_digitRegExp.hasMatch(firstChar)) {
      return oldValue;
    }

    return newValue;
  }
}
