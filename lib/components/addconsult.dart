import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import '../models/login_model.dart';
import '../style/theme.dart' as Theme;
import '../ui/MainPage.dart';

final String consultUrl = 'http://192.168.56.1:5000/api/consultations';
final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddConsult extends StatefulWidget {
  final ResponseBody response;

  //in the constructor, require a Response
  AddConsult({Key key, @required this.response}) : super(key: key);

  @override
  _AddConsultState createState() => _AddConsultState();
}

File _image;

class _AddConsultState extends State<AddConsult> {


  final FocusNode body = FocusNode();

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
           AppLocalizations.of(context).addconsult,
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
                                                 AppLocalizations.of(context).consultcontent,
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
                                                decoration: InputDecoration(
                                                labelText:  AppLocalizations.of(context).description,
                                                   
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
                                            consultPostData(context),
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

  void consultPostData(BuildContext context) async {
    //post body
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('token',token);
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

    dynamic bodyToSend = {'consultationBody': _body.text, 'id': payload['id']};
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    var body = json.encode(bodyToSend);
    //print(body);
    //request
    var response = await post(consultUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    print(response.body);
    var givenToken = state['token'];
    var token = givenToken;
    print(token);

    if (response.statusCode == 200) {
      print(response.statusCode);
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => MainPage(),
      );
      await Navigator.of(context).push(route);
    }
  }
}
