import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/models/center_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import 'doctor_details.dart';
import 'edit_hospro.dart';

var preftoken;
Map payloadMap;
List<Spcialists> specailist;
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

Map<String, dynamic> parseJwt() {
  loadData().then((onValue) {
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

class HospitalDeitals extends StatefulWidget {
  @override
  _HospitalDeitalsState createState() => _HospitalDeitalsState();
}

Future hospitalProfile;

class _HospitalDeitalsState extends State<HospitalDeitals> {
  @override
  BuildContext context;
  //ApiService apiService;

  Map payload = parseJwt();
  String centerUrl = 'http://192.168.56.1:5000/api/centers/user/';
  @override
  void initState() {
    super.initState();
    centerUrl = centerUrl + payload['id'];
    print(centerUrl);
    hospitalProfile = ApiService().getCenter(centerUrl);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditHospitalProfile()));
              },
            ),
          ],
        ),
        body: SafeArea(
            child: FutureBuilder(
                future: hospitalProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      Centery center = snapshot.data;
                      specailist=center.spcialists;
                      return buildhospitalProfile(context, center);
                    }
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    //print(snapshot.data.toString());
                    return Center(
                      child: Text("Your profile isn't completed yet\n" +
                          "Complete your profile data\nPress edit button\n"),
                    );
                  }
                })));
  }

  Widget buildhospitalProfile(context, data) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/img/hos.png",
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            data.centerName,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.black54),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Text(
                    'AL Madenah',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
                  child: Icon(
                    Icons.alarm,
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Text(
                    data.openingTime,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(width: 5.0),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
              child: Text(
                AppLocalizations.of(context).description,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Text(
                data.summary,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              child: Text(
                AppLocalizations.of(context).informationhos,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 20),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                    child: Text(
                      AppLocalizations.of(context).absorptivecapacity,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  
                     Text(data.maximumNumberOfPatients.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0,8.0,0),
                    child: Text(
                      AppLocalizations.of(context).medicalstaff,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Text(data.staff.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
              child: Text(
                AppLocalizations.of(context).openingdate,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Text(data.openDate, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 20),
        Text(
          AppLocalizations.of(context).specialistshos,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        SizedBox(height: 10),
       Flexible(
          child: Row(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                
                  itemBuilder: (context, index) {
                    specailist = data.spcialists;
                    //print(specailist[0].specialistName);
                    return Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(specailist[index].specialistName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 16)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(specailist[index].specialty,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 16)),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(specailist[index].nationality,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 16)),
                        )
                      ],
                    );
                  },
                    itemCount: specailist.length,
                ),
              ),
            ],
          ),
        )

        /* InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DoctorDeitals()));
            },
            child: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 30,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/img/egyflag.png"),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Omer taj elsir",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 16)),
                ),
                Expanded(
                  flex: 3,
                  child: Text("Bones sergent",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 16)),
                ),
              ],
            ),
          ),*/
      ],
    );
  }
}
