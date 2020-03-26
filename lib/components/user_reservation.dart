import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loginn/fragments/reservations_fragment.dart';
import 'package:loginn/google_map_location_picker.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/style/theme.dart' as Theme;
import 'package:loginn/ui/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import '../models/profile.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
var preftoken;
Map payloadMap;
 List<GroupModel> _group;



class GroupModel {
  String text;
  int index;
  bool selected;

  GroupModel({this.text, this.index, this.selected});
}

class UseryReservation extends StatefulWidget {
  Doctor doctor;
  UseryReservation({this.doctor });

  

  @override
  _UseryReservationState createState() => _UseryReservationState();
}

File _image;

class _UseryReservationState extends State<UseryReservation> {
  
  final FocusNode userName = FocusNode();
  final FocusNode userAge = FocusNode();

  final FocusNode userGender = FocusNode();
  final FocusNode userDescription = FocusNode();



  TextEditingController _userName = TextEditingController();
  TextEditingController _userAge = TextEditingController();
  TextEditingController _userGender = TextEditingController();
  TextEditingController _userDescription = TextEditingController();
 
  int _value2 = 1;
 
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("hh:mm a");
  int _count = 1;
  //Map payload = parseJwt();
String selected;

  // Group Value for Radio Button.
  int id = 1;
  String reservationUrl= 'http://192.168.56.1:5000/api/reservations/';
  // reservationUrl = reservationUrl + payload['id'];
  @override
  void initState() {
    super.initState();
    reservationUrl=reservationUrl+'${widget.doctor.id}';
    print(reservationUrl);
  }
  @override
  Widget build(BuildContext context) {
     _group = [
    GroupModel(
        text: "Saturday" + "\n" +  '${widget.doctor.workingDaysandHours.saturday}', index: 1, selected: true),
    GroupModel(
        text: "Sunday" + "\n" + '${widget.doctor.workingDaysandHours.sunday}', index: 2, selected: false),
    GroupModel(
        text: "Monday" + "\n" + '${widget.doctor.workingDaysandHours.monday}', index: 3, selected: false),
    GroupModel(
        text: "Tuseday" + "\n" +'${widget.doctor.workingDaysandHours.tuesday}', index: 4, selected: false),
    GroupModel(
        text: "Wensday" + "\n" + '${widget.doctor.workingDaysandHours.wednesday}', index: 5, selected: false),
    GroupModel(
        text: "Thursday" + "\n" + '${widget.doctor.workingDaysandHours.thursday}', index: 6, selected: false),
    GroupModel(
        text: "Friday" + "\n" +'${widget.doctor.workingDaysandHours.friday}', index: 7, selected: false),
  ];
 
    return Scaffold(
     


      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text( AppLocalizations.of(context).bookreservationtitle,
         
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: 30.0, left: 9.0, right: 9.0, top: 10.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            elevation: 5.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: Text(
                                     AppLocalizations.of(context).bookreservationtitle,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context).lname,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            focusNode: userName,
                                            controller: _userName,
                                            decoration:  InputDecoration(
                                              labelText:AppLocalizations.of(context).enterpatientname,
                                            
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context).patientage,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 130.5),
                                        Text(
                                          AppLocalizations.of(context).gender,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child:  TextFormField(
                                            focusNode: userAge,
                                            controller: _userAge,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration: InputDecoration(
                                             labelText:AppLocalizations.of(context).patientage),
                                          ),
                                        ),
                                        SizedBox(width: 10.0),
                                        Flexible(
                                          child: TextField(
                                            focusNode: userGender,
                                            controller: _userGender,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration:   InputDecoration(
                                                labelText: AppLocalizations.of(context).gender),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                             AppLocalizations.of(context).description,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Flexible(
                                          child: TextField(
                                            focusNode: userDescription,
                                            controller: _userDescription,
                                            decoration:  InputDecoration(
                                                labelText: AppLocalizations.of(context).enterpatientdescription,
                                                   ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 25.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context).date,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: Column(
                                    children: <Widget>[
                                      makeRadioTiles(),
                                      
                                    ],
                                    
                                  ),
                                  
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                 child:Text(selected== null? "nothing":selected,)
                                  
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: MaterialButton(
                                highlightColor: Colors.transparent,
                                color: Theme.Colors.maincolor,
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                   AppLocalizations.of(context).reservationbtn,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () => {
                                     userReservation(context),
                                    }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
 Widget makeRadioTiles() {
return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:_group.map((fruit)=>Row(
    children: <Widget>[
      Radio(value: fruit.index,
      groupValue:id ,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: (value){
        setState(() {
          id=value;
          selected=fruit.text;
        });
      },),
      Text(fruit.text),
    ],
  )).toList(),
  );
 }
 String _decodeBase64(String str) {
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
  void userReservation(BuildContext context) async {

   SharedPreferences prefs = await SharedPreferences.getInstance();
    var preftoken = prefs.getString('token');
    print(preftoken);
    Map<String, dynamic> parseJwt(token) {
      print(token);
      final parts = token.split('.');
      if (parts.length != 3) {
        throw Exception('invalid token');
      }

      final payload = _decodeBase64(parts[1]);
      final payloadMap = json.decode(payload);
      if (payloadMap is! Map<String, dynamic>) {
        throw Exception('invalid payload');
      }

      return payloadMap;
    }

    Map payload = parseJwt(preftoken);
    //print(payload);
    var userid = payload['id'];
    var booking;
  var doctorid='${widget.doctor.id}';
      print('Doctor ID: ${widget.doctor.id}');
       
 booking=selected;
 print(booking);
print(userid);
 dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    dynamic bodyToSend = {
    'doctor':'$doctorid',
    'patient':'$userid',
    'statusDescription':_userDescription.text,
    'age':_userAge.text,
    'gender':_userGender.text,
    'bookingDate':'$booking',
      };
      var body = json.encode(bodyToSend);
      print("BODY: ${bodyToSend.toString()}");
    var response = await post(reservationUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      print("DoID $doctorid");
      var route = MaterialPageRoute(
        builder: (BuildContext context) => MainPage(),
      );
      await Navigator.of(context).push(route);
    } else {
      print(response);
      print(payload.toString());
    
    }
      }
}