import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginn/fragments/doc_consult.dart';

import 'package:loginn/style/theme.dart' as Theme;
import 'package:loginn/ui/doctor_details.dart';
import 'package:loginn/ui/doctor_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import '../models/login_model.dart';
import 'doctor_articls.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddArticls extends StatefulWidget {
  final ResponseBody response;

  //in the constructor, require a Response
  AddArticls({Key key,  this.response}) : super(key: key);

  @override
  _AddArticlsState createState() => _AddArticlsState();
}

File _image;

class _AddArticlsState extends State<AddArticls> {
  final String articlsUrl = 'http://192.168.56.1:5000/api/articles';
  final FocusNode title = FocusNode();
  final FocusNode body = FocusNode();

  TextEditingController _title = TextEditingController();
  TextEditingController _body = TextEditingController();
  List<Widget> list = List();
  bool _isFieldNameValid;
  final formKey = GlobalKey<FormState>();

  int _count = 1;

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
     

      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
         AppLocalizations.of(context).addarticl,
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
                                Column(
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context).articlname,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0,
                                            right: 25.0,
                                            top: 2.0,
                                            bottom: 30),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                focusNode: title,
                                                controller: _title,
                                                decoration:
                                                    InputDecoration(
                                                  labelText:   AppLocalizations.of(context).articlname,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
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
                                                  AppLocalizations.of(context).articlcontent,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Flexible(
                                              child: TextField(
                                                focusNode: body,
                                                controller: _body,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                decoration:
                                                     InputDecoration(
                                                labelText: AppLocalizations.of(context).enterarticlcontent,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40.0),
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
                                          AppLocalizations.of(context).publishbtn,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.0,
                                              fontFamily: "WorkSansBold"),
                                        ),
                                      ),
                                      onPressed: () => {
                                            articlsPostData(context),
                                          }),
                                ),
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
      ),
    );
  }

  void articlsPostData(BuildContext context) async {
    //post body
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('token',token);
    var preftoken = prefs.getString('token');
    print(preftoken);
    dynamic bodyToSend = {'title': _title.text, 'body': _body.text};
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(articlsUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    var token = givenToken;
    print(token);

    if (response.statusCode == 200) {
      print(response.statusCode);
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => DoctorDeitals(),
      );
      await Navigator.of(context).push(route);
    }
  }
}
