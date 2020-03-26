import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart';
import 'package:loginn/ui/login_page.dart' as prefix0;
import './login_page.dart';
import 'package:loginn/ui/login_page.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../localizations.dart';
import '../LocaleHelper.dart';
import '../LocaleHelper.dart';
import '../localizations.dart';
import '../models/login_model.dart';
import '../style/theme.dart' as Theme;
import '../ui/MainPage.dart';



class Language extends StatefulWidget {
 @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =  SpecificLocalizationDelegate(Locale("en"));
  }

 onLocaleChange(Locale locale){
    setState((){
     
      _specificLocalizationDelegate =  SpecificLocalizationDelegate(locale);
    });
  }
onLanguageEnd() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => prefix0.Login()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       localizationsDelegates: [
       GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
     new FallbackCupertinoLocalisationsDelegate(),
       //app-specific localization
        _specificLocalizationDelegate
     ],

      supportedLocales: [Locale('en'),Locale('ar')],
     locale: _specificLocalizationDelegate.overriddenLocale ,
   theme: ThemeData(
      backgroundColor: Colors.white,
      ),
     
      home: Container(
        color: Colors.white,
      
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 500.0,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 30.0,
                                left: 15.0,
                                right: 9.0,
                                top: 10.0),
                            child: Column(
                              children: <Widget>[
                               
                                 new FlatButton(
              child: new Text("English"), color: AppLocalizations == "en" ? Colors.grey : Colors.blue, onPressed: (){
                  this.setState((){
                    helper.onLocaleChanged( Locale("en"));
                     onLanguageEnd();
                  });
              },
            ),

            new FlatButton(
              child: Text("عربى"),color:  AppLocalizations == "ar" ? Colors.grey : Colors.blue,onPressed: (){
                this.setState((){
                    helper.onLocaleChanged( Locale("ar"));
                      onLanguageEnd();
                  }
                  );
                  
              },
            )
                                  
                                
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        
      ),
    );
    
  }
  
}