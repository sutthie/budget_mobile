import 'package:intl/intl.dart';

class FormatMoney {
  static String money = "";

  static String formatCurrencyfromDouble(double moneys) {
    money = NumberFormat.currency(locale: 'th', symbol: '').format(moneys);

    return money;
  }

  static String formatCurrencyfromStr(String moneys) {
    final fmt = NumberFormat("#,##0.00", "en_US");
    return fmt.format(moneys);
  }
}
