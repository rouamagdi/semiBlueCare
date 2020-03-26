import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = Color(0xFF000102);
  static const Color loginGradientEnd = Color(0xFF304d6d);
  static const Color maincolor = Color(0xFF304D6D);
  static const Color secondrycolor = Color(0xFF82A0BC);
  static const Color secondrycolor2 = Color(0xFF86D1EE);
  static const Color secondrycolor3 = Color(0xFF545E75);

  static const primaryGradient = LinearGradient(
    colors: [loginGradientStart, loginGradientEnd],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
