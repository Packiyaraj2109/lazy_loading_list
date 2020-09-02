import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static Color appBackgroundColor = Color(0xFFEEEEEE);
  static Color scaffoldBackgroundColor = Color(0xFFEEEEEE);
  static Color iconColor = Colors.white;
  static Color themeColor = Colors.orange;
  static Color textColor = Colors.white;
  static Color borderColor = Colors.white;
  static Color boldtextColor = Colors.orange;
  static Color bottomsheet = Color(0xFFEF6C00);
  static Gradient gradient = LinearGradient(
    colors: [Colors.orange[700], Colors.orange[400]],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Gradient buttongradient = LinearGradient(
    colors: [Colors.orange[400], Colors.orange[700]],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
