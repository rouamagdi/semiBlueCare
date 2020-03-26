import 'dart:async';
import 'package:loginn/style/theme.dart' as Theme;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loginn/ui/language.dart';
import 'login_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 2160, allowFontScaling: false);
    Timer(Duration(seconds: 3), () {
      _onSplashEnd();
    });
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       // backgroundColor: Theme.Colors.maincolor,
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
  
 
      child: Image.asset("assets/img/splash.png" ,fit: BoxFit.cover),
    ));
  }

  _onSplashEnd() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => Login()));
  }
}
