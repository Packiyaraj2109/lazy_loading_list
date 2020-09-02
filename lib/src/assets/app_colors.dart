import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  static Color appBackgroundColor = Colors.white;
  static Color themeColor = Colors.blue;
  static Color textcolor = Colors.white;
  static Color boldtextColor = Colors.blue;
  static Color bordercolor = Colors.blue;
  static Color hintcolor = Colors.grey[700];
  static Gradient gradient = LinearGradient(
    colors: [Colors.blue[500], Colors.blue[200]],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Gradient buttongradient = LinearGradient(
    colors: [Colors.blue[200], Colors.blue[500]],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
