import 'package:intl/intl.dart';

class FormatMoney {
  static String money = "";

  static String setFormat(double moneys) {
    money = NumberFormat.currency(
      locale: 'th',
      symbol: '',
    ).format(moneys);

    return money;
  }
}
