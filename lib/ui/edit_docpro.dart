import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/ui/doctor_details.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../google_map_location_picker.dart';
import '../localizations.dart';
import '../style/theme.dart' as Theme;
import 'doctor_details.dart';
import 'doctor_profile.dart';

var preftoken;
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
  print("payload: ${payloadMap.toString()}");
  return payloadMap;
}

class EditDoctorProfile extends StatefulWidget {
  Doctor doctor;
  EditDoctorProfile({this.doctor});
  @override
  _EditDoctorProfileState createState() => _EditDoctorProfileState();
}

var textEditingControllersTitle = <TextEditingController>[];
var textEditingControllersSource = <TextEditingController>[];
var textEditingControllersAwardDate = <TextEditingController>[];

var textEditingControllersTitleDB = <TextEditingController>[];
var textEditingControllersSourceDB = <TextEditingController>[];
var textEditingControllersAwardDateDB = <TextEditingController>[];

var textFields = <TextField>[];

class _EditDoctorProfileState extends State<EditDoctorProfile> {
  Map<String, dynamic> _payload;
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  final FocusNode doctorName = FocusNode();
  final FocusNode doctorNationality = FocusNode();
  File _image;
  File _image1;

  final FocusNode doctorrDescription = FocusNode();
  final FocusNode doctorSpeicalization = FocusNode();
  final FocusNode doctorPrice1 = FocusNode();
  final FocusNode doctorPrice2 = FocusNode();
  final FocusNode doctorPrice3 = FocusNode();
  final FocusNode doctorSpecilaist = FocusNode();
  final FocusNode doctorResource = FocusNode();
  final FocusNode doctorDate = FocusNode();
  final FocusNode doctorExperiences = FocusNode();
  final FocusNode doctorPhoneNumber = FocusNode();
  final FocusNode satday = FocusNode();
  final FocusNode sunday = FocusNode();
  final FocusNode monday = FocusNode();
  final FocusNode tuesday = FocusNode();
  final FocusNode wedday = FocusNode();
  final FocusNode thuday = FocusNode();
   final FocusNode friday = FocusNode();
  TextEditingController _doctorName = TextEditingController();
  TextEditingController _satday = TextEditingController();
   TextEditingController _sunday = TextEditingController();
   TextEditingController _monday = TextEditingController();
   TextEditingController _tuesday = TextEditingController();
   TextEditingController _wedday = TextEditingController();
   TextEditingController _thuday = TextEditingController();
    TextEditingController _friday = TextEditingController();
  TextEditingController _doctorNationality = TextEditingController();
  TextEditingController _doctorDescription = TextEditingController();
  TextEditingController _doctorSpecialization = TextEditingController();
  TextEditingController _doctorPrice1 = TextEditingController();
  TextEditingController _doctorPrice2 = TextEditingController();
  TextEditingController _doctorPrice3 = TextEditingController();
  TextEditingController _doctorResource = TextEditingController();
  TextEditingController _doctorDate = TextEditingController();
  TextEditingController _doctorSpecilaist = TextEditingController();
  TextEditingController _doctorExperiences = TextEditingController();
  TextEditingController _doctorPhoneNumber = TextEditingController();
 
  List<Widget> list = List();
  List<Widget> qual = List();
  LocationResult _pickedLocation;
  List<Qualifications> qualifications = [];
  var count = 1;

  final formKey = GlobalKey<FormState>();
  final String freelancerUrl = 'http://192.168.56.1:5000/api/freelancers';
  String qualificationUrl =
      'http://192.168.56.1:5000/api/freelancers/qualifications';
  String freeUrl = 'http://192.168.56.1:5000/api/freelancers/user/';

  //List<SessionPrice> priceList ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print("INSI");
      print("Qual: ${qual.length}");
      print("List: ${list.length}");
      print("Title: ${textEditingControllersTitle.length}");
      print("Source: ${textEditingControllersSource.length}");
      print("Award: ${textEditingControllersAwardDate.length}");
      print("INEI");
      /*textEditingControllersTitle.removeRange(0, textEditingControllersTitle.length-1);
      textEditingControllersSource.removeRange(0, textEditingControllersSource.length-1);
      textEditingControllersAwardDate.removeRange(0, textEditingControllersAwardDate.length-1);*/
      textEditingControllersTitle.clear();
      textEditingControllersSource.clear();
      textEditingControllersAwardDate.clear();
      qual.clear();
      list.clear();
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      parseJwt().then((onValue) {
        print("onValueNew: $onValue");
        _payload = onValue;
        if (_payload.isNotEmpty) {
          print("Hello 2");
          print(_payload.toString());
          freeUrl = freeUrl + _payload['id'];
          userProfile = ApiService().getdoctor(freeUrl);
        }
      });

      //userProfile = ApiService().getdoctor(freeUrl);
      //print(freeUrl);
    });

    //userQual = ApiService().getQualification(qualificationUrl);
    //print(userProfile.toString());
  }

  @override
  Widget build(BuildContext context) {
    Future imageSelectorGallery() async {
      var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );

      setState(() {
        _image = image;
      });
    }

    Future imageSelectorGallery1() async {
      var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );

      setState(() {
        _image = image;
      });
    }

    //display image selected from camera
    Future imageSelectorCamera() async {
      var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );

      setState(() {
        _image = image;
      });
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            AppLocalizations.of(context).doctordata,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          /* child: Column(
            children: <Widget>[ */
          child: FutureBuilder(
              future: userProfile,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return CircularProgressIndicator();
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    if (snapshot.hasData == false) {
                      print("No data in snapshot");
                      return Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Card(
                                    elevation: 5.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Container(
                                      width: 380.0,
                                      height: 190.0,
                                      child:
                                          Stack(fit: StackFit.loose, children: <
                                              Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 140.0,
                                              height: 140.0,
                                              child: _image == null
                                                  ? Image.asset(
                                                      'assets/img/user.png')
                                                  : Image.file(_image),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: 80.0, left: 90.0),
                                            child: Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xFF005ab3),
                                                  radius: 25.0,
                                                  child: IconButton(
                                                    icon:
                                                        Icon(Icons.camera_alt),
                                                    color: Colors.white,
                                                    onPressed:
                                                        imageSelectorCamera,
                                                  ),
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 5.0, left: 80.0),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Color(0xFF005ab3),
                                                      radius: 25.0,
                                                      child: IconButton(
                                                        icon: Icon(
                                                            Icons.wallpaper),
                                                        color: Colors.white,
                                                        onPressed:
                                                            imageSelectorGallery,
                                                      ),
                                                    )),
                                              ],
                                            )),
                                      ]),
                                    )),
                              ],
                            ),
                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: 30.0,
                                    left: 9.0,
                                    right: 9.0,
                                    top: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Card(
                                      elevation: 5.0,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .personalinformation,
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .sname,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      //initialValue: "Ahmad",
                                                      focusNode: doctorName,
                                                      controller: _doctorName,

                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .susername,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                                 Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .sphone,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      //initialValue: "Ahmad",
                                                      focusNode: doctorPhoneNumber,
                                                      controller: _doctorPhoneNumber,

                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .susername,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .nationality,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: RaisedButton(
                                                      onPressed: () async {
                                                        LocationResult result =
                                                            await showLocationPicker(
                                                          context,
                                                          "AIzaSyCptAR5E12DUPUrcxfsoyS1bA4viu-r1zc",
                                                          initialCenter: LatLng(
                                                              31.1975844,
                                                              29.9598339),
                                                          automaticallyAnimateToCurrentLocation:
                                                              true,
                                                          //                      mapStylePath: 'assets/mapStyle.json',
                                                          myLocationButtonEnabled:
                                                              true,
                                                          layersButtonEnabled:
                                                              true,
                                                          //                      resultCardAlignment: Alignment.bottomCenter,
                                                        );
                                                        print(
                                                            "result = $result");
                                                        setState(() =>
                                                            _pickedLocation =
                                                                result);
                                                      },
                                                      child:
                                                          Text('Pick location'),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 30.0,
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        _pickedLocation
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 7.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode:
                                                          doctorNationality,
                                                      controller:
                                                          _doctorNationality,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .nationality,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .description,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode:
                                                          doctorrDescription,
                                                      controller:
                                                          _doctorDescription,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .description,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .specialization,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode:
                                                          doctorSpeicalization,
                                                      controller:
                                                          _doctorSpecialization,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .specialization,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .priceoffsession,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        " for One person",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode: doctorPrice1,
                                                      controller: _doctorPrice1,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .priceoffsession,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        " for Two person",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode: doctorPrice2,
                                                      controller: _doctorPrice2,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .priceoffsession,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        " for Three person",
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode: doctorPrice3,
                                                      controller: _doctorPrice3,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .priceoffsession,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)
                                                        .qualifications,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 100.0),
                                                  FlatButton(
                                                    color: Colors.blue,
                                                    textColor: Colors.white,
                                                    disabledColor: Colors.grey,
                                                    disabledTextColor:
                                                        Colors.black,
                                                    shape: CircleBorder(),
                                                    onPressed: () {
                                                      setState(() {
                                                        var textEditingControllerT =
                                                            TextEditingController();
                                                        textEditingControllersTitle
                                                            .add(
                                                                textEditingControllerT);

                                                        var textEditingControllerS =
                                                            TextEditingController();
                                                        textEditingControllersSource
                                                            .add(
                                                                textEditingControllerS);
                                                        var textEditingControllerA =
                                                            TextEditingController();
                                                        textEditingControllersAwardDate
                                                            .add(
                                                                textEditingControllerA);
                                                        qual.add(
                                                          Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      textEditingControllerT,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText: AppLocalizations.of(
                                                                            context)
                                                                        .specialization,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Flexible(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      textEditingControllerS,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText: AppLocalizations.of(
                                                                            context)
                                                                        .source,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Flexible(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      textEditingControllerA,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    labelText:
                                                                        AppLocalizations.of(context)
                                                                            .year,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });

                                                      //setState(() {});
                                                    },
                                                    child: Icon(Icons.add),
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode:
                                                          doctorSpecilaist,
                                                      controller:
                                                          _doctorSpecilaist,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .specialization,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode: doctorResource,
                                                      controller:
                                                          _doctorResource,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .source,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.0),
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode: doctorDate,
                                                      controller: _doctorDate,
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .year,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          list.isNotEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 25.0,
                                                    right: 25.0,
                                                    top: 2.0,
                                                    bottom: 20.0,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, index) {
                                                            print("List");
                                                            Widget widget =
                                                                list.elementAt(
                                                                    index);
                                                            return widget;
                                                          },
                                                          itemCount:
                                                              list.length,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          qual.isNotEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 25.0,
                                                    right: 25.0,
                                                    top: 2.0,
                                                    bottom: 20.0,
                                                  ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemBuilder:
                                                              (context, index) {
                                                            print("Qual");
                                                            Widget widget =
                                                                qual.elementAt(
                                                                    index);
                                                            return widget;
                                                          },
                                                          itemCount:
                                                              qual.length,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                      AppLocalizations.of(                   context)      .experience,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0,
                                                  bottom: 20),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextField(
                                                      focusNode:
                                                          doctorExperiences,
                                                      controller:
                                                          _doctorExperiences,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .experience,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            "working Days:",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0
                                                      ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "saturday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                             satday,
                                                          controller:
                                                              _satday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "sunday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                             sunday,
                                                          controller:
                                                              _sunday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "monday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                            monday,
                                                          controller:
                                                              _monday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "tuseday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              tuesday,
                                                          controller:
                                                              _tuesday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "wensday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              wedday,
                                                          controller:
                                                              _wedday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "thursday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              thuday,
                                                          controller:
                                                              _thuday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                             Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "friday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              friday,
                                                          controller:
                                                              _friday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .album,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .images,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.0, left: 2.0),
                                            child:
                                                Container(), //buildGridView()
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .videos,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 30.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                      child: MaterialButton(
                                          highlightColor: Colors.transparent,
                                          color: Theme.Colors.loginGradientEnd,
                                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 42.0),
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19.0,
                                                  fontFamily: "WorkSansBold"),
                                            ),
                                          ),
                                          onPressed: () => {
                                                doctorEditProfile(context),
                                              }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          print("Has Data: List Length => ${list.length}");
                          list.clear();
                          textEditingControllersTitleDB.clear();
                          textEditingControllersSourceDB.clear();
                          textEditingControllersAwardDateDB.clear();
                          Doctor freelancer = snapshot.data;
                          _doctorName.text = freelancer.freelancerName;
                          _doctorPhoneNumber.text=freelancer.phoneNumber.toString();
                          _doctorDescription.text = freelancer.summary;
                          _doctorSpecialization.text =
                              freelancer.specialization;
                          _doctorExperiences.text = freelancer.experiences;
                          _doctorNationality.text = freelancer.nationality;
                          _doctorPrice1.text =
                              freelancer.sessionPrice.forOnePatient.toString();
                          _doctorPrice2.text =
                              freelancer.sessionPrice.forTwoPatients.toString();
                          _doctorPrice3.text = freelancer.sessionPrice.forThreePatients.toString();
                        /*  _satday.text=freelancer.workingDaysandHours.saturday;
                          _sunday.text=freelancer.workingDaysandHours.sunday;
                          _monday.text=freelancer.workingDaysandHours.monday;
                          _tuesday.text=freelancer.workingDaysandHours.tuesday;
                          _thuday.text=freelancer.workingDaysandHours.thursday;
                          _wedday.text=freelancer.workingDaysandHours.wednesday;
                          _friday.text=freelancer.workingDaysandHours.friday;*/
                          if (freelancer.qualifications.isNotEmpty) {
                            _doctorSpecilaist.text =
                                freelancer.qualifications[0].title;
                            _doctorResource.text =
                                freelancer.qualifications[0].source;
                            _doctorDate.text =
                                freelancer.qualifications[0].awardDate;
                            for (var i = 0;
                                i < freelancer.qualifications.length - 1;
                                i++) {
                              var textEditingController1 =
                                  TextEditingController();
                              var textEditingController2 =
                                  TextEditingController();
                              var textEditingController3 =
                                  TextEditingController();
                              print("i: $i");
                              textEditingControllersTitleDB
                                  .add(textEditingController1);
                              textEditingControllersSourceDB
                                  .add(textEditingController2);
                              textEditingControllersAwardDateDB
                                  .add(textEditingController3);
                              list.add(
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                        controller:
                                            textEditingControllersTitleDB
                                                .elementAt(i),
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)
                                                  .specialization,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Flexible(
                                      child: TextField(
                                        controller:
                                            textEditingControllersSourceDB
                                                .elementAt(i),
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context)
                                                  .source,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    Flexible(
                                      child: TextField(
                                        controller:
                                            textEditingControllersAwardDateDB
                                                .elementAt(i),
                                        decoration: InputDecoration(
                                          labelText:
                                              AppLocalizations.of(context).year,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              textEditingControllersTitleDB[i].text =
                                  freelancer.qualifications[i].title;
                              textEditingControllersSourceDB[i].text =
                                  freelancer.qualifications[i].source;
                              textEditingControllersAwardDateDB[i].text =
                                  freelancer.qualifications[i].awardDate;
                            }
                          }
                          print(
                              "Length DB: ${textEditingControllersTitleDB.length}");
                          print(
                              "Length New: ${textEditingControllersTitle.length}");
                          return Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Card(
                                        elevation: 5.0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Container(
                                          width: 380.0,
                                          height: 190.0,
                                          child: Stack(
                                              fit: StackFit.loose,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      width: 140.0,
                                                      height: 140.0,
                                                      child: _image == null
                                                          ? Image.asset(
                                                              'assets/img/user.png')
                                                          : Image.file(_image),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 80.0, left: 90.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Color(0xFF005ab3),
                                                          radius: 25.0,
                                                          child: IconButton(
                                                            icon: Icon(Icons
                                                                .camera_alt),
                                                            color: Colors.white,
                                                            //onPressed: imageSelectorCamera,
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5.0,
                                                                    left: 80.0),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF005ab3),
                                                              radius: 25.0,
                                                              child: IconButton(
                                                                icon: Icon(Icons
                                                                    .wallpaper),
                                                                color: Colors
                                                                    .white,
                                                                //onPressed: imageSelectorGallery,
                                                              ),
                                                            )),
                                                      ],
                                                    )),
                                              ]),
                                        )),
                                  ],
                                ),
                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 30.0,
                                        left: 9.0,
                                        right: 9.0,
                                        top: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Card(
                                          elevation: 5.0,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.0,
                                                    bottom: 20.0,
                                                    left: 25.0,
                                                    right: 25.0),
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .personalinformation,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .sname,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextFormField(
                                                          //initialValue: "Ahmad",
                                                          focusNode: doctorName,
                                                          controller:
                                                              _doctorName,

                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .susername,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                                                                   Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 25.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .sphone,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 25.0,
                                                  right: 25.0,
                                                  top: 2.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: TextFormField(
                                                      //initialValue: "Ahmad",
                                                      focusNode: doctorPhoneNumber,
                                                      controller: _doctorPhoneNumber,

                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)
                                                                .susername,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .nationality,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: RaisedButton(
                                                          onPressed: () async {
                                                            LocationResult
                                                                result =
                                                                await showLocationPicker(
                                                              context,
                                                              "AIzaSyCptAR5E12DUPUrcxfsoyS1bA4viu-r1zc",
                                                              initialCenter:
                                                                  LatLng(
                                                                      31.1975844,
                                                                      29.9598339),
                                                              automaticallyAnimateToCurrentLocation:
                                                                  true,
                                                              //                      mapStylePath: 'assets/mapStyle.json',
                                                              myLocationButtonEnabled:
                                                                  true,
                                                              layersButtonEnabled:
                                                                  true,
                                                              //                      resultCardAlignment: Alignment.bottomCenter,
                                                            );
                                                            print(
                                                                "result = $result");
                                                            setState(() =>
                                                                _pickedLocation =
                                                                    result);
                                                          },
                                                          child: Text(
                                                              'Pick location'),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 30.0,
                                                      top: 5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            _pickedLocation
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 7.5,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorNationality,
                                                          controller:
                                                              _doctorNationality,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .nationality,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .description,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorrDescription,
                                                          controller:
                                                              _doctorDescription,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .description,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .specialization,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorSpeicalization,
                                                          controller:
                                                              _doctorSpecialization,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: AppLocalizations
                                                                    .of(context)
                                                                .specialization,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .priceoffsession,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            " for One person",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorPrice1,
                                                          controller:
                                                              _doctorPrice1,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: AppLocalizations
                                                                    .of(context)
                                                                .priceoffsession,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            " for Two person",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorPrice2,
                                                          controller:
                                                              _doctorPrice2,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: AppLocalizations
                                                                    .of(context)
                                                                .priceoffsession,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                  
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            " for Three person",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorPrice3,
                                                          controller:
                                                              _doctorPrice3,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: AppLocalizations
                                                                    .of(context)
                                                                .priceoffsession,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .qualifications,
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 100.0),
                                                      FlatButton(
                                                        color: Colors.blue,
                                                        textColor: Colors.white,
                                                        disabledColor:
                                                            Colors.grey,
                                                        disabledTextColor:
                                                            Colors.black,
                                                        shape: CircleBorder(),
                                                        onPressed: () {
                                                          setState(() {
                                                            var textEditingControllerS =
                                                                TextEditingController();
                                                            textEditingControllersSource
                                                                .add(
                                                                    textEditingControllerS);
                                                            print(
                                                                "S Length: ${textEditingControllersSource.length}");

                                                            var textEditingControllerT =
                                                                TextEditingController();
                                                            textEditingControllersTitle
                                                                .add(
                                                                    textEditingControllerT);

                                                            print(
                                                                "T Length: ${textEditingControllersTitle.length}");

                                                            var textEditingControllerA =
                                                                TextEditingController();
                                                            textEditingControllersAwardDate
                                                                .add(
                                                                    textEditingControllerA);
                                                            print(
                                                                "A Length: ${textEditingControllersAwardDate.length}");
                                                            qual.add(
                                                              Row(
                                                                children: <
                                                                    Widget>[
                                                                  Flexible(
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          textEditingControllerT,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            AppLocalizations.of(context).specialization,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Flexible(
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          textEditingControllerS,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            AppLocalizations.of(context).source,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          10.0),
                                                                  Flexible(
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          textEditingControllerA,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            AppLocalizations.of(context).year,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          });

                                                          //setState(() {});
                                                        },
                                                        child: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorSpecilaist,
                                                          controller:
                                                              _doctorSpecilaist,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: AppLocalizations
                                                                    .of(context)
                                                                .specialization,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorResource,
                                                          controller:
                                                              _doctorResource,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .source,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode: doctorDate,
                                                          controller:
                                                              _doctorDate,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .year,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              list.isNotEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 25.0,
                                                        right: 25.0,
                                                        top: 2.0,
                                                        bottom: 20.0,
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                print(
                                                                    "Data From Backend");
                                                                Widget widget =
                                                                    list.elementAt(
                                                                        index);
                                                                return widget;
                                                              },
                                                              itemCount:
                                                                  list.length,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              qual.isNotEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 25.0,
                                                        right: 25.0,
                                                        top: 2.0,
                                                        bottom: 20.0,
                                                      ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                print(
                                                                    "New Data");
                                                                Widget widget =
                                                                    qual.elementAt(
                                                                        index);
                                                                return widget;
                                                              },
                                                              itemCount:
                                                                  qual.length,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                    "",//  AppLocalizations.of(         context)  .experience,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 2.0,
                                                      bottom: 20),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              doctorExperiences,
                                                          controller:
                                                              _doctorExperiences,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .experience,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                               Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0
                                                      ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            "working Days:",
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0
                                                      ),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "saturday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                             satday,
                                                          controller:
                                                              _satday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "sunday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                             sunday,
                                                          controller:
                                                              _sunday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "monday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                            monday,
                                                          controller:
                                                              _monday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "tuseday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              tuesday,
                                                          controller:
                                                              _tuesday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "wensday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              wedday,
                                                          controller:
                                                              _wedday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                   Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "thursday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              thuday,
                                                          controller:
                                                              _thuday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                             Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        "friday",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Flexible(
                                                        child: TextField(
                                                          focusNode:
                                                              friday,
                                                          controller:
                                                              _friday,
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      "enter Time of opening and closing"),
                                                        ),
                                                      ),
                                                    ],
                                                  )),

                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .album,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .images,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 5.0, left: 2.0),
                                                child:
                                                    Container(), //buildGridView()
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 25.0,
                                                      right: 25.0,
                                                      top: 25.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .videos,
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 30.0),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                          ),
                                          child: MaterialButton(
                                              highlightColor:
                                                  Colors.transparent,
                                              color:
                                                  Theme.Colors.loginGradientEnd,
                                              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 42.0),
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19.0,
                                                      fontFamily:
                                                          "WorkSansBold"),
                                                ),
                                              ),
                                              onPressed: () => {
                                                    doctorEditProfile(context),
                                                  }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    }
                }
              }),
          /*  ],
          ), */
        ));
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //    var dir = await path_provider.getTemporaryDirectory();

    await _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
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

  void doctorEditProfile(BuildContext context) async {
    print("INS");
    print("Qual: ${qual.length}");
    print("List: ${list.length}");
    print("Title${textEditingControllersTitle.length}");
    print("Source${textEditingControllersSource.length}");
    print("Award${textEditingControllersAwardDate.length}");
    print("INE");
    //post body
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var preftoken = prefs.getString('token');
    print(preftoken);
    Map<String, dynamic> parseJwt(token) {
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
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    dynamic bodyToSend;
    if (_satday.text.isNotEmpty||_sunday.text.isNotEmpty) {
     bodyToSend = {
      //'avatar': _image != null ? 'data:image/png;base64,' +  base64Encode(_image.readAsBytesSync()) : '',
      'userid': '$userid',
      'freelancerName': _doctorName.text,
      'phoneNumber':_doctorPhoneNumber.text.toString(),
      'summary': _doctorDescription.text,
      'nationality': _doctorNationality.text,
      'experiences': _doctorExperiences.text,
      'location': _pickedLocation.toString(),
      'specialization': _doctorSpecialization.text,

      'forOnePatient': _doctorPrice1.text,
      'forTwoPatients': _doctorPrice2.text,
      'forThreePatients': _doctorPrice3.text,
      'saturday':_satday.text,
      'sunday':_sunday.text,
      'monday':_monday.text,
      'tuesday':_tuesday.text,
      'wednesday':_wedday.text,
      'thursday':_thuday.text,
      'friday':_friday.text,
    };
    
      
    }
    var body = json.encode(bodyToSend);
    var response = await post(freelancerUrl, body: body, headers: headers);
    if (response.statusCode == 200) {
      dynamic qualBodyToSend;
      var qualBody;
      var qualResponse;
      if (_doctorSpecilaist.text.isNotEmpty &&
          _doctorResource.text.isNotEmpty &&
          _doctorDate.text.isNotEmpty) {
        qualBodyToSend = {
          'userid': '$userid',
          'title': _doctorSpecilaist.text,
          'source': _doctorResource.text,
          'awardDate': _doctorDate.text,
        };
        qualBody = json.encode(qualBodyToSend);
        qualResponse =
            await post(qualificationUrl, body: qualBody, headers: headers);
        if (qualResponse.statusCode == 200) {
          print(qualResponse.statusCode);
        } else {
          print(qualResponse.statusCode);
        }
      }
      for (var i = 0; i < textEditingControllersTitle.length; i++) {
        print("ROW NUMBER: $i");
        print(textEditingControllersTitle.length);
        if (textEditingControllersTitle[i].text.isNotEmpty &&
            textEditingControllersSource[i].text.isNotEmpty &&
            textEditingControllersAwardDate[i].text.isNotEmpty) {
          qualBodyToSend = {
            'userid': '$userid',
            'title': textEditingControllersTitle[i].text,
            'source': textEditingControllersSource[i].text,
            'awardDate': textEditingControllersAwardDate[i].text,
          };
          qualBody = json.encode(qualBodyToSend);
          qualResponse = await postQual(headers, qualBody, qualificationUrl);
          if (qualResponse.statusCode == 200) {
            print("Success");
            print(qualResponse.statusCode);
          } else {
            print(qualResponse.statusCode);
          }
        } else {
          print("Fail");
        }
      }
      list.clear();
      qual.clear();
      textEditingControllersTitle = [];
      textEditingControllersSource = [];
      textEditingControllersAwardDate = [];
      textEditingControllersTitleDB = [];
      textEditingControllersSourceDB = [];
      textEditingControllersAwardDateDB = [];
      /*var route = MaterialPageRoute(
        builder: (BuildContext context) => DoctorDeitals(),
      );*/
      await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DoctorDeitals()));
    } else {
      print(response.statusCode);
    }
    //textEditingControllersTitle.removeRange(0, textEditingControllersTitle.length-1);
  }
}

Future postQual(headers, qualBody, qualificationUrl) async {
  var qualResponse =
      await post(qualificationUrl, body: qualBody, headers: headers);
  return qualResponse;
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
