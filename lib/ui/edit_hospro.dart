import 'dart:convert';
import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/components/goverment.dart';
import 'package:loginn/google_map_location_picker.dart';
import 'package:loginn/models/center_model.dart';
import 'package:loginn/style/theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import '../models/profile.dart';
import 'hospital_details.dart';
var preftoken;
Map payloadMap;
List<Spcialists> specailist;
class HospitalType {
  String name;
  int index;
  HospitalType({this.name, this.index});
}
String selected;

  // Group Value for Radio Button.
  int id = 1;
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

Future hospitalProfile;


class EditHospitalProfile extends StatefulWidget {
  Profile profile;

  EditHospitalProfile({this.profile});

  @override
  _EditHospitalProfileState createState() => _EditHospitalProfileState();
}
List<Widget> list = List();
  List<Widget> qual = List();
File _image;
var textEditingControllersSpecialistName = <TextEditingController>[];
var textEditingControllerspSecialty = <TextEditingController>[];
var textEditingControllersNationality = <TextEditingController>[];
class _EditHospitalProfileState extends State<EditHospitalProfile> {
  final FocusNode centerName = FocusNode();
  final FocusNode centerTime = FocusNode();

  final FocusNode centerLocation = FocusNode();
  final FocusNode centerDescription = FocusNode();
  final FocusNode centerCapacity = FocusNode();
  final FocusNode centerLanuchDate = FocusNode();
  final FocusNode centerSpecilaist = FocusNode();
  final FocusNode centerMedicalStaff = FocusNode();

  LocationResult _pickedLocation;
String radioItem = '';
  TextEditingController _centerName = TextEditingController();
  TextEditingController _centerTime = TextEditingController();
  TextEditingController _centerDescription = TextEditingController();
  TextEditingController _centerCapcity = TextEditingController();
  TextEditingController _centerLanuch = TextEditingController();
  TextEditingController _centerStaff = TextEditingController();
  TextEditingController _centerMedicalStaff = TextEditingController();
  TextEditingController _centerSpecialist = TextEditingController();
  TextEditingController _centerSpecialistName = TextEditingController();
  TextEditingController _centerSpecialistspecailzation = TextEditingController();
  TextEditingController _centerSpecialistnationality = TextEditingController();
  TimeOfDay time;
  List<Widget> list = List();
  bool _isFieldNameValid;
  final formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("hh:mm a");
  int _count = 1;
  String specailistrUrl = 'http://192.168.56.1:5000/api/centers/spcialists';
   Map payload = parseJwt();
  String centerUrl = 'http://192.168.56.1:5000/api/centers/user/';
   List<HospitalType> fList = [
    HospitalType(
      index: 1,
      name: "goverment",
    ),
    HospitalType(
      index: 2,
      name: "Private",
    ),];
   @override
   initState() {
    // TODO: implement initState
    super.initState();
     centerUrl = centerUrl + payload['id'];
    print(centerUrl);
     hospitalProfile = ApiService().getCenter(centerUrl);
    setState(() {

 
      
     });}
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
          "",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
       child: FutureBuilder(
              future: hospitalProfile,
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
                  Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Column(
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
                                  Stack(fit: StackFit.loose, children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 140.0,
                                      height: 140.0,
                                      child: _image == null
                                          ? Image.asset('assets/img/user.png')
                                          : Image.file(_image),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 80.0, left: 90.0),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFF005ab3),
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            color: Colors.white,
                                            onPressed: imageSelectorCamera,
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
                                                icon: Icon(Icons.wallpaper),
                                                color: Colors.white,
                                                onPressed: imageSelectorGallery,
                                              ),
                                            )),
                                      ],
                                    )),
                              ]),
                            )),
                      ],
                    ),
                  ),
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
                                    AppLocalizations.of(context).centerinformation,
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
                                           AppLocalizations.of(context).sname,
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
                                            focusNode: centerName,
                                            controller: _centerName,
                                            decoration:  InputDecoration(
                                              labelText:   AppLocalizations.of(context).sname,
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
                                          "type",
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
                                        
                               _buildRadio(),
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
                                              AppLocalizations.of(context).location,
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
                                          child: RaisedButton(
                                            onPressed: () async {
                                              LocationResult result =
                                                  await showLocationPicker(
                                                context,
                                                "AIzaSyCptAR5E12DUPUrcxfsoyS1bA4viu-r1zc",
                                                initialCenter: LatLng(
                                                    31.1975844, 29.9598339),
                                                automaticallyAnimateToCurrentLocation:
                                                    true,
//                      mapStylePath: 'assets/mapStyle.json',
                                                myLocationButtonEnabled: true,
                                                layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                                              );
                                              //print("result = $result");
                                              setState(() =>
                                                  _pickedLocation = result);
                                            },
                                            child: Text('Pick location'),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 30.0, top: 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              _pickedLocation.toString(),
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
                                            focusNode: centerDescription,
                                            controller: _centerDescription,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration:  InputDecoration(
                                                labelText:  AppLocalizations.of(context).description,),
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
                                              AppLocalizations.of(context).time,
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
                                          child: DateTimeField(
                                            decoration: InputDecoration(
                                              labelText:
                                                    AppLocalizations.of(context).enterTimeofopeningandcloseing,
                                            ),
                                            focusNode: centerTime,
                                            controller: _centerTime,
                                            format: format1,
                                            
                                            onShowPicker:
                                                (context, currentValue) async {
                                              var time = await showTimePicker(
                                                context: context,
                                                
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        currentValue ??
                                                            DateTime.now()),
                                                            
                                              );
                                              
                                              return DateTimeField.convert(
                                                  time);
                                                  
                                                  
                                            },
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
                                            AppLocalizations.of(context).absorptivecapacity,
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
                                            focusNode: centerCapacity,
                                            controller: _centerCapcity,
                                            decoration:  InputDecoration(
                                                labelText:  AppLocalizations.of(context).absorptivecapacity,),
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
                                                 AppLocalizations.of(context).openingdate,
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
                                          child: DateTimeField(
                                            decoration: InputDecoration(
                                              labelText:  AppLocalizations.of(context).openingdate,
                                               
                                            ),
                                            focusNode: centerLanuchDate,
                                            controller: _centerLanuch,
                                            format: format,
                                            onShowPicker:
                                                (context, currentValue) {
                                              return showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1900),
                                                  initialDate: currentValue ??
                                                      DateTime.now(),
                                                  lastDate: DateTime(2100));
                                            },
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
                                                 AppLocalizations.of(context).medicalstaff,
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
                                            focusNode: centerMedicalStaff,
                                            controller: _centerMedicalStaff,
                                            decoration:  InputDecoration(
                                                labelText:   AppLocalizations.of(context).enternumberofthemedicalstaffincenter,
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
                                           AppLocalizations.of(context).specialistshos,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 30.0),
                                        FlatButton(
                                            color: Colors.blue,
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            shape: CircleBorder(),
                                            onPressed: () {
                                              var textEditingController1 =
                                                  new TextEditingController();
                                              textEditingControllersSpecialistName
                                                  .add(textEditingController1);
                                              var textEditingController2 =
                                                  new TextEditingController();
                                              textEditingControllerspSecialty
                                                  .add(textEditingController2);
                                              var textEditingController3 =
                                                  new TextEditingController();
                                              textEditingControllersNationality
                                                  .add(textEditingController3);
                                              list.add(
                                                Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            textEditingController1,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .specialistshosname,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            textEditingController2,
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
                                                        controller:
                                                            textEditingController3,
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
                                                ),
                                              );

                                              setState(() {});
                                            },
                                            child: Icon(Icons.add),
                                          ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                     child:Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            _centerSpecialistName,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .specialistshosname,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            _centerSpecialistspecailzation ,
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
                                                        controller:
                                                            _centerSpecialistnationality,
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
                                                ),),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 2.0,
                                    bottom: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            Widget widget =
                                                list.elementAt(index);
                                            return widget;
                                          },
                                          itemCount: list.length,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                color: Theme.Colors.loginGradientEnd,
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    AppLocalizations.of(context).save,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () => {
                                     hospitalEditProfile(context)
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
        ); 
        } else {
        if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          print(snapshot.data);
                          Centery center=snapshot.data;
                          _centerName.text= center.centerName;
                         
                          _centerTime.text=center.openingTime;
                          _centerCapcity.text=center.maximumNumberOfPatients.toString();
                          _centerDescription.text=center.summary;
                          _centerLanuch.text=center.openDate;
                          _centerMedicalStaff.text=center.staff.toString();
                            if (center.spcialists.isNotEmpty) {
                          _centerSpecialistName.text=center.spcialists[0].specialistName;
                          _centerSpecialistspecailzation.text=center.spcialists[0].specialty;
                          _centerSpecialistnationality.text=center.spcialists[0].nationality;
                            for (var i = 0;
                                i < center.spcialists.length - 1;
                                i++) {
                              var textEditingController1 =
                                  TextEditingController();
                              var textEditingController2 =
                                  TextEditingController();
                              var textEditingController3 =
                                  TextEditingController();
                                     print("i: $i");
                              textEditingControllersSpecialistName
                                  .add(textEditingController1);
                              textEditingControllerspSecialty
                                  .add(textEditingController2);
                              textEditingControllersNationality
                                  .add(textEditingController3);
                              list.add(
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: TextField(
                                        controller:
                                            textEditingControllersSpecialistName
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
                                            textEditingControllerspSecialty
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
                                            textEditingControllersNationality
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
                              textEditingControllersSpecialistName[i].text =
                                  center.spcialists[i].specialistName;
                              textEditingControllerspSecialty[i].text =
                                 center.spcialists[i].specialty;
                              textEditingControllersNationality[i].text =
                                 center.spcialists[i].nationality;
                            }
                          }
                          print(
                              "Length DB: ${textEditingControllersSpecialistName.length}");
                          print(
                              "Length New: ${textEditingControllerspSecialty.length}");
                       
     return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Column(
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
                                  Stack(fit: StackFit.loose, children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 140.0,
                                      height: 140.0,
                                      child: _image == null
                                          ? Image.asset('assets/img/user.png')
                                          : Image.file(_image),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 80.0, left: 90.0),
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFF005ab3),
                                          radius: 25.0,
                                          child: IconButton(
                                            icon: Icon(Icons.camera_alt),
                                            color: Colors.white,
                                            onPressed: imageSelectorCamera,
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
                                                icon: Icon(Icons.wallpaper),
                                                color: Colors.white,
                                                onPressed: imageSelectorGallery,
                                              ),
                                            )),
                                      ],
                                    )),
                              ]),
                            )),
                      ],
                    ),
                  ),
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
                                    AppLocalizations.of(context).centerinformation,
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
                                           AppLocalizations.of(context).sname,
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
                                            focusNode: centerName,
                                            controller: _centerName,
                                            decoration:  InputDecoration(
                                              labelText:   AppLocalizations.of(context).sname,
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
                                          "type",
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
                                        
                               _buildRadio(),
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
                                              AppLocalizations.of(context).location,
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
                                          child: RaisedButton(
                                            onPressed: () async {
                                              LocationResult result =
                                                  await showLocationPicker(
                                                context,
                                                "AIzaSyCptAR5E12DUPUrcxfsoyS1bA4viu-r1zc",
                                                initialCenter: LatLng(
                                                    31.1975844, 29.9598339),
                                                automaticallyAnimateToCurrentLocation:
                                                    true,
//                      mapStylePath: 'assets/mapStyle.json',
                                                myLocationButtonEnabled: true,
                                                layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
                                              );
                                              //print("result = $result");
                                              setState(() =>
                                                  _pickedLocation = result);
                                            },
                                            child: Text('Pick location'),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 30.0, top: 5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              _pickedLocation.toString(),
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
                                            focusNode: centerDescription,
                                            controller: _centerDescription,
                                            keyboardType:
                                                TextInputType.multiline,
                                            decoration:  InputDecoration(
                                                labelText:  AppLocalizations.of(context).description,),
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
                                              AppLocalizations.of(context).time,
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
                                          child: DateTimeField(
                                            decoration: InputDecoration(
                                              labelText:
                                                    AppLocalizations.of(context).enterTimeofopeningandcloseing,
                                            ),
                                            focusNode: centerTime,
                                            controller: _centerTime,
                                            format: format1,
                                            
                                            onShowPicker:
                                                (context, currentValue) async {
                                              var time = await showTimePicker(
                                                context: context,
                                                
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        currentValue ??
                                                            DateTime.now()),
                                                            
                                              );
                                              
                                              return DateTimeField.convert(
                                                  time);
                                                  
                                                  
                                            },
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
                                            AppLocalizations.of(context).absorptivecapacity,
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
                                            focusNode: centerCapacity,
                                            controller: _centerCapcity,
                                            decoration:  InputDecoration(
                                                labelText:  AppLocalizations.of(context).absorptivecapacity,),
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
                                                 AppLocalizations.of(context).openingdate,
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
                                          child: DateTimeField(
                                            decoration: InputDecoration(
                                              labelText:  AppLocalizations.of(context).openingdate,
                                               
                                            ),
                                            focusNode: centerLanuchDate,
                                            controller: _centerLanuch,
                                            format: format,
                                            onShowPicker:
                                                (context, currentValue) {
                                              return showDatePicker(
                                                  context: context,
                                                  firstDate: DateTime(1900),
                                                  initialDate: currentValue ??
                                                      DateTime.now(),
                                                  lastDate: DateTime(2100));
                                            },
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
                                                 AppLocalizations.of(context).medicalstaff,
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
                                            focusNode: centerMedicalStaff,
                                            controller: _centerMedicalStaff,
                                            decoration:  InputDecoration(
                                                labelText:   AppLocalizations.of(context).enternumberofthemedicalstaffincenter,
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
                                           AppLocalizations.of(context).specialistshos,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 30.0),
                                        FlatButton(
                                            color: Colors.blue,
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            shape: CircleBorder(),
                                            onPressed: () {
                                              var textEditingController1 =
                                                  new TextEditingController();
                                              textEditingControllersSpecialistName
                                                  .add(textEditingController1);
                                              var textEditingController2 =
                                                  new TextEditingController();
                                              textEditingControllerspSecialty
                                                  .add(textEditingController2);
                                              var textEditingController3 =
                                                  new TextEditingController();
                                              textEditingControllersNationality
                                                  .add(textEditingController3);
                                              list.add(
                                                Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            textEditingController1,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .specialistshosname,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            textEditingController2,
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
                                                        controller:
                                                            textEditingController3,
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
                                                ),
                                              );

                                              setState(() {});
                                            },
                                            child: Icon(Icons.add),
                                          ),
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0, right: 25.0, top: 2.0),
                                     child:Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            _centerSpecialistName,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              AppLocalizations.of(
                                                                      context)
                                                                  .specialistshosname,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.0),
                                                    Flexible(
                                                      child: TextField(
                                                        controller:
                                                            _centerSpecialistspecailzation ,
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
                                                        controller:
                                                            _centerSpecialistnationality,
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
                                                ),),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 2.0,
                                    bottom: 20.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            Widget widget =
                                                list.elementAt(index);
                                            return widget;
                                          },
                                          itemCount: list.length,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                color: Theme.Colors.loginGradientEnd,
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    AppLocalizations.of(context).save,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () => {
                                     hospitalEditProfile(context)
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
        );}}}}
                         } ),
    ));
  }
   Widget _buildRadio(){
return Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:fList.map((hospital)=>Row(
    children: <Widget>[
      Radio(value: hospital.index,
      groupValue:id ,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onChanged: (value){
        setState(() {
          id=value;
          selected=hospital.name;
        });
      },),
      Text(hospital.name),
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
  void hospitalEditProfile(BuildContext context) async {
     dynamic bodyToSend ;
     final String centerUrl = 'http://192.168.56.1:5000/api/centers';
    
    //post body
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var preftoken = prefs.getString('token');
    print(preftoken);
        Map<String, dynamic> parseJwt(token) {
        //print(token);
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
var type=selected;
if(selected =="goverment"){



print(type);
     bodyToSend = {
      //'avatar': _image != null ? 'data:image/png;base64,' +  base64Encode(_image.readAsBytesSync()) : '',
      'userid':'$userid',
      'centerName': _centerName.text,
      'summary':_centerDescription.text,
      'maximumNumberOfPatients':_centerCapcity.text,
      'openingTime':_centerTime.text,
      'openDate':_centerLanuch.text,
      //'location'_pickedLocation.toString(),
      'staff':_centerMedicalStaff.text,
     'isGovernmental':true,
     'isPrivate':false
    };}else{
        bodyToSend = {
      //'avatar': _image != null ? 'data:image/png;base64,' +  base64Encode(_image.readAsBytesSync()) : '',
      'userid':'$userid',
      'centerName': _centerName.text,
      'summary':_centerDescription.text,
      'maximumNumberOfPatients':_centerCapcity.text,
      'openingTime':_centerTime.text,
      'openDate':_centerLanuch.text,
      //'location'_pickedLocation.toString(),
      'staff':_centerMedicalStaff.text,
     'isGovernmental':false,
     'isPrivate':true
    };
    }
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
     
    var body = json.encode(bodyToSend);
    //print(body);
    //request
    var response = await post(centerUrl, body: body, headers: headers);
    //var state = json.decode(response.body);
    //token
    /*var givenToken = state['token'];
    var token = givenToken;
    print(token);*/
 
print(bodyToSend.toString());
    if (response.statusCode == 200) {
      dynamic qualBodyToSend;
    var qualBody;
    var qualResponse;
    qualBodyToSend = {
        'userid': '$userid',
        'specialistName': _centerSpecialistName.text,
        'specialty': _centerSpecialistspecailzation.text,
        'nationality': _centerSpecialistnationality.text,
      };
      print(qualBodyToSend.toString());
      qualBody = json.encode(qualBodyToSend);
  qualResponse = await post(specailistrUrl, body: qualBody, headers: headers);
   
    for (var i = 0; i < textEditingControllersSpecialistName.length; i++) {
      

if (qualResponse.statusCode == 200) {
        print(qualResponse.statusCode);
      } else {
        print(qualResponse.statusCode);
      }
      qualBodyToSend = {
        'userid': '$userid',
        'specialistName': textEditingControllersSpecialistName[i].text,
        'specialty': textEditingControllerspSecialty[i].text,
        'nationality': textEditingControllersNationality[i].text,
      };
      print(qualBodyToSend.toString());
      qualBody = json.encode(qualBodyToSend);
      qualResponse = await postQual(headers, qualBody, specailistrUrl);
      if (qualResponse.statusCode == 200) {
        print(qualResponse.statusCode);
      } else {
        print(qualResponse.statusCode);
      }
    }

      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => HospitalDeitals(),
      );
      await Navigator.of(context).push(route);
    } else {
      print(response.statusCode);
      print(centerUrl);
    }
  }
  Future postQual(headers, qualBody, qualificationUrl) async {
  var qualResponse =
      await post(specailistrUrl, body: qualBody, headers: headers);
  return qualResponse;
}
}
