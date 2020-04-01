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
import 'package:loginn/ui/user_profile.dart';
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

class UserProfile extends StatefulWidget {
  Doctor doctor;
  UserProfile({this.doctor});
  @override
  _UserProfileState createState() => _UserProfileState();
}




class _UserProfileState extends State<UserProfile> {
  Map<String, dynamic> _payload;
  List<Object> images = List<Object>();
  Future<File> _imageFile;

  final FocusNode doctorName = FocusNode();
  final FocusNode doctorNationality = FocusNode();
  File _image;
  File _image1;
 LocationResult _pickedLocation;
  final FocusNode name = FocusNode();
  final FocusNode phone = FocusNode();
  final FocusNode address = FocusNode();
 
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
   TextEditingController _address = TextEditingController();
  
 
 
 

  final formKey = GlobalKey<FormState>();
  final String userUrl = 'http://192.168.56.1:5000/api/freelancers';
 

  //List<SessionPrice> priceList ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
     
      parseJwt().then((onValue) {
        print("onValueNew: $onValue");
        _payload = onValue;
        if (_payload.isNotEmpty) {
          print("Hello 2");
          print(_payload.toString());
         // freeUrl = freeUrl + _payload['id'];
         // userProfile = ApiService().getdoctor(freeUrl);
        }
      });

      
    });

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
                                                      focusNode: name,
                                                      controller: _name,

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
                                                          phone,
                                                      controller:
                                                          _phone,
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
                         
                          
                         
                          Doctor freelancer = snapshot.data;
                         
                       
                        
                          
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
                                                          focusNode: name,
                                                          controller:
                                                              _name,

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
                                                              phone,
                                                          controller:
                                                              _phone,
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
  }
    //textEditingControllersTitle.removeRange(0, textEditingControllersTitle.length-1);
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
