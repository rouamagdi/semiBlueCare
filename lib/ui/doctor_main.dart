import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loginn/fragments/doc_sub.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/ui/doctor_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fragments/doc_consult.dart';
import '../fragments/doc_home.dart';
import '../localizations.dart';
import 'doctor_details.dart';
import '../models/doctor_model.dart';

Map<String, dynamic> payloadMap;
String doctorUrl = 'http://192.168.56.1:5000/api/freelancers/user/';
Future<String> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

String decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Future<Map<String, dynamic>> parseJwt() async {
  await loadData().then((onValue) {
    final parts = onValue.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = decodeBase64(parts[1]);
    payloadMap = json.decode(payload);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
  });
  return payloadMap;
}

class DoctorPage extends StatefulWidget {
  @override
  _DoctorPageState createState() => _DoctorPageState();
}
Future doctorReservation;
Doctor doctorData;

final scaffoldKey = GlobalKey<ScaffoldState>();
String doctorAllReservationUrl='http://192.168.56.1:5000/api/reservations/orders/';
class _DoctorPageState extends State<DoctorPage> {
  Map<String, dynamic> _payload;
  List<Widget> _fragments = [
    DocHome(),
    DoctorCon(),
    DoctorDeitals(),
    DocSubscription(),
  ];
  int _selectedIndex = 0;
  bool opend = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("In init");
    //setState(() {  
      print("In set");
    parseJwt().then((onValue) {
      print("In Jwt");
        _payload = onValue;
        if (_payload.isNotEmpty) {
          doctorUrl = "http://192.168.56.1:5000/api/freelancers/user/${_payload['id']}";
          userProfile = ApiService().getdoctor(doctorUrl);
          ApiService().getdoctor(doctorUrl).then((docData) {
            
            setState(() {
              doctorData = docData;
            doctorAllReservationUrl='http://192.168.56.1:5000/api/reservations/orders/${docData.id}';
            });
          });
          
        }
      });
   //});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _fragments.elementAt(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        fixedColor: Color(0xFF005ab3),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text( AppLocalizations.of(context).home,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text(AppLocalizations.of(context).consandarticls,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), title: Text(AppLocalizations.of(context).myaccount,)),
               BottomNavigationBarItem(icon: Icon(Icons.subscriptions), title: Text( AppLocalizations.of(context).subscription,)),
        ],
        currentIndex: _selectedIndex,
        onTap: onTabTapped,
      )),
    );
  }

  onTabTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }
}
