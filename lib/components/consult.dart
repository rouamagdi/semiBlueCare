import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:loginn/components/addconsult.dart';
import 'package:loginn/components/addconsult.dart';
import 'package:loginn/components/api_services.dart';

import 'package:loginn/models/consult_model.dart';
import 'package:loginn/models/consult_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localizations.dart';
import '../style/theme.dart' as Theme;

List<Widget> list = new List();

final String commentUrl =
    'http://192.168.56.1:5000/api/consultations/comment/:id';
String y;


class ConsultDetails extends StatefulWidget {
  Consult consult;

  int index;

  ConsultDetails({
    this.consult,
    this.index,
  });

  @override
  _ConsultDetailsState createState() => _ConsultDetailsState();
}

bool _isVisible = true;
var preftoken;
String x;

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

//void testmy() {
Future<String> shared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  x = prefs.getString('token');
  print(x);
  //return x.toString();
}
//}

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

//Map payload1 = parseJw();

class _ConsultDetailsState extends State<ConsultDetails> {
  @override
  BuildContext context;
  ApiService apiService;

  var userInput = '';
  var responseOutput = '';
  var listItem;
  FocusNode body = FocusNode();

  TextEditingController _body = TextEditingController();
 ScrollController _scrollController = new ScrollController();

  List<Consult> consult = [];
   @override
    void initState() {
      super.initState();
      setState(() {
         print("IN Consult");
      apiService = ApiService();
      body = FocusNode();
      });
     
    }
  @override
  Widget build(BuildContext context) {
    String commentUrl =
        'http://192.168.56.1:5000/api/consultations/';
    commentUrl = commentUrl + '${widget.consult.id}';
   

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(AppLocalizations.of(context).consult,
            style: TextStyle(
              color: Colors.white,
              //  fontFamily: GoogleFonts.tajawal().fontFamily,
            )),
      ),
      body: 
          Column(
            children: <Widget>[
              SizedBox(height: 10),

              Text(
                '${widget.consult.consultationBody}',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    //   fontFamily: GoogleFonts.tajawal().fontFamily,
                    color: Colors.black54),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  (true)
                      ? Flexible(
                          child: TextField(
                            focusNode: body,
                            controller: _body,
                            keyboardType: TextInputType.multiline,
                            onSubmitted: (value) {
                              _body.text = value;
                            },
                            decoration: InputDecoration(
                              labelText:
                                  AppLocalizations.of(context).addcomment,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              SizedBox(height: 10),
              FlatButton(
                highlightColor: Colors.transparent,
                color: Theme.Colors.loginGradientEnd,
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    AppLocalizations.of(context).replybtn,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      //   fontFamily: GoogleFonts.tajawal().fontFamily,
                    ),
                  ),
                ),
                onPressed: () => {
                  commentPostData(context),
                },
              ),
              SizedBox(height: 30),
              Expanded(
                              child: Row(
                  children: <Widget>[
                    Flexible(
                      child: FutureBuilder(
                        future: apiService.getComments(commentUrl),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Comment>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null) {
                              List<Comment> comment = snapshot.data;
                              return ListView.builder(
                                reverse: true,
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: comment.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Card(
                                            elevation: 10,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(comment[index]
                                                          .commentBody)
                                                    ]))));
                                  });
                            }
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

  void commentPostData(BuildContext context) async {
    //post body
    var msg = _body.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('token',token);
    var preftoken = prefs.getString('token');

    //print(preftoken);

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

  
    // print(fullUrl);
    Map payload = parseJwt(preftoken);
    dynamic bodyToSend = {'commentBody': _body.text, 'id': payload['id']};
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    var body = json.encode(bodyToSend);
    //print(body);
    //request
    final String commentUrl =
        'http://192.168.56.1:5000/api/consultations/comment/';
    final String fullUrl = commentUrl + '${widget.consult.id}';
    var response = await post(fullUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    var token = givenToken;
    //print(token);

    if (response.statusCode == 200) {
      // print(response.statusCode);

      //Navigator.of(context).pushNamed('/secondScreen');
      setState(() {
        _body.clear();

        //responseOutput = state['_body'];
        //  userInput = msg;
        //   _body.clear();
      });
    }
  }

  ok() {
    // Map payload1 = parseJwt(shared());

    //print(x);
    Map payload = parseJwt(preftoken);
    print(payload);
  }

  Widget _buildListView1(List consults) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    );
  }
}
