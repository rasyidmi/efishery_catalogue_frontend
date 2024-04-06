import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  static int convertToInt(String text, int decimalDigit) {
    if (text.isEmpty) {
      return 0;
    }
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.parse(text).toInt();
  }
}
