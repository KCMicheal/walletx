import 'package:flutter/material.dart';
import 'size_config.dart';

class GlobalTextStyles {

  static TextStyle regularText({required color, double fontSize = 16}) {
    return TextStyle(
        color: color,
        fontSize: SizeConfig.textAdjusted(fontSize + 3));
  }

  static TextStyle medium({required color, double fontSize = 16}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: SizeConfig.textAdjusted(fontSize + 3));
  }

  static TextStyle bold({required color, double fontSize = 16}) {
    return TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: SizeConfig.textAdjusted(fontSize + 3));
  }
}
