import 'package:flutter/cupertino.dart';

class AppImages {
  static Image appLogo({double width,double  height}) {
    return Image.asset(
      'lib/src/assets/images/todo_logo.png',
      width: width ?? null,
      height: height ?? null,
    );
  }
}
