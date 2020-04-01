import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/models/doctor_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../fragments/doc_consult.dart';
import '../fragments/home_fragment.dart';
import '../fragments/reservations_fragment.dart';
import '../localizations.dart';

Map<String, dynamic> payloadMap;

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
class MainPage extends StatefulWidget {
  Doctor doctor;
  @override
  _MainPageState createState() => _MainPageState();
}
Future userReservation;
final scaffoldKey = GlobalKey<ScaffoldState>();
String doctorUrl = 'http://192.168.56.1:5000/api/freelancers/user/';
  String userAllReservationUrl='http://192.168.56.1:5000/api/reservations/requests/';
  String userUrl='http://192.168.56.1:5000/api/users/current';
Future doctorProfile;
Doctor doctorData;
class _MainPageState extends State<MainPage> {
  Map<String, dynamic> _payload;
  List<Widget> _fragments = [
    HomeFragment(),
    DoctorCon(),
    ReservationsFragment(),
    
  ];
  int _selectedIndex = 0;
  bool opend = false;
 String freelancerUrl = 'http://192.168.56.1:5000/api/freelancers/';
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     parseJwt().then((onValue) {
      print("In Jwt");
        _payload = onValue;
        if (_payload.isNotEmpty) {
          userAllReservationUrl = "http://192.168.56.1:5000/api/reservations/requests/${_payload['id']}";
          userUrl='http://192.168.56.1:5000/api/users/current/${_payload['id']}';
      print(userAllReservationUrl);
            ApiService().getdoctor(doctorUrl).then((docData) {
            
            setState(() {
              doctorData = docData;
         //   doctorAllReservationUrl='http://192.168.56.1:5000/api/reservations/orders/${docData.id}';
            });
          });
        }
      });
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
              icon: Icon(Icons.library_books), title: Text( AppLocalizations.of(context).consandarticls,)),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text( AppLocalizations.of(context).reservation,)),
         
        ],
        currentIndex: _selectedIndex,
        onTap: (int selectedIndex) {
          setState(() {
            _selectedIndex = selectedIndex;
          });
        },
      )),
    );
  }
}
