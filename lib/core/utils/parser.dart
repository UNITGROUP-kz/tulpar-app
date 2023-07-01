import 'package:easy_localization/easy_localization.dart';

class Parser {
  static int toInt(value) {
    switch(value.runtimeType) {
      case String: {
        return int.parse(value);
      }
      case double: {
        return value.toInt();
      }
      case int: {
        return value;
      }
      default: return 0;
    }
  }

  static double toDouble(value) {
    switch(value.runtimeType) {
      case String: {
        return double.parse(value);
      }
      case int: {
        return value.toDouble();
      }
      case double: {
        return value;
      }
      default: return 0.0;
    }
  }

  static String toPrice(value) {
    try {
      String cleanedInput = value.replaceAll(',', '').trim();
      double number = double.parse(cleanedInput);
      String formattedNumber = NumberFormat.decimalPattern().format(number);
      return formattedNumber;
    } catch(e) {
      print(e);
    }
    return '';

  }

}