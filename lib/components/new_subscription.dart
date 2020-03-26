import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/fragments/doc_sub.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/models/subscribe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show Client;
import '../localizations.dart';
import '../models/login_model.dart';
import '../style/theme.dart' as Theme;
import '../ui/MainPage.dart';
String doctorUrl = 'http://192.168.56.1:5000/api/freelancers/user/';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
 List<PeriodModel> _period;
class PeriodModel {
  String text;
  int index;
  bool selected;

  PeriodModel({this.text, this.index, this.selected});
}
class NewSubscription extends StatefulWidget {
 Doctor doctor;

  //in the constructor, require a Response
  NewSubscription({Key key, @required this.doctor}) : super(key: key);

  @override
  _NewSubscriptionState createState() => _NewSubscriptionState();
}
Future country;
File _image;
Doctor doctorData;
class _NewSubscriptionState extends State<NewSubscription> {
  final FocusNode body = FocusNode();
Map<String, dynamic> _payload;
  TextEditingController _body = TextEditingController();
  List<Widget> list = List();
  bool _isFieldNameValid;
  final formKey = GlobalKey<FormState>();
Country country;
  int _count = 1;

  int _radioValue1 = -1;

  var _countries = [
    'Sudan',
    'KSA',
    'Egypt',
    'Somalia',
  ];
String selected;
 int result=0;
int counter1=1;
int counter2=30;
int counter3=365;
List data = List();
String doctorid;
String countriesUrl='http://192.168.56.1:5000/api/countries';
 Client client = Client();
Future<String> getCountry() async {
    final response = await client.get(Uri.encodeFull(countriesUrl), headers: {"Accept": "application/json"});
   var resBody = json.decode(response.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucess";
    
  }
  // Group Value for Radio Button.
  int id = 1;
  String _mySelection;
  String _currentValueSelect = "KSA";
   String radioButtonItem = 'day';
    var item;
    void _handleRadioValueChange1(value) {}

  void _onCDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentValueSelect = newValueSelected;
      print(_currentValueSelect);
    });
  }
  @override
  void initState() {
    super.initState();
this.getCountry();
print("In init");
    //setState(() {  
      print("In set");
    parseJwt().then((onValue) {
      print("In Jwt");
        _payload = onValue;
        if (_payload.isNotEmpty) {
          doctorUrl = "http://192.168.56.1:5000/api/freelancers/user/${_payload['id']}";
    ApiService().getdoctor(doctorUrl).then((docData) {
            
            setState(() {
              doctorData = docData;
            doctorid='${docData.id}';
            print(doctorid);
            });
          });
             }
      });
   //});
  }
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).subperiod,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Type",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold, color: Theme.Colors.loginGradientEnd,),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          focusNode: body,
                          controller: _body,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "0",
                          ),
                        ),
                      ),
                    ),
                     makeRadioTiles(),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).country,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).city,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: DropdownButton(
                          items: data.map((item) {
                            return DropdownMenuItem(
                              value: item['_id'].toString(),
                              
                              child: Text(item['countryName']),
                              
                            );
                          }).toList(),
                          onChanged:  (newVal) {
            setState(() {
              _mySelection = newVal;
            });
          },
                          value: _mySelection,
                          
                        ),
                      ),
                    ),
                    Expanded(child: Padding(padding: EdgeInsets.all(8))),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: DropdownButton<String>(
                          items: _countries.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            _onCDropDownItemSelected(newValueSelected);
                          },
                          value: _currentValueSelect,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).citywhereyouaregoingtopay,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).amount,
                        style: TextStyle(
                          color: Theme.Colors.loginGradientEnd,
                          fontWeight: FontWeight.bold
                          
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "2500",
                        style: TextStyle(
                          color: Theme.Colors.loginGradientEnd,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0,
                          
                        ),
                      ),
                    ),
                    Text(
                        AppLocalizations.of(context).sar,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          
                        ),
                      ),
                  ],
                ),
                MaterialButton(
                    highlightColor: Colors.transparent,
                    color: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        AppLocalizations.of(context).subbtn,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            ),
                      ),
                    ),
                    onPressed: () => {
                          subscribePostData(context),
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }
Widget makeRadioTiles() {
 return Column(
      children: <Widget>[
       
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
      
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'day';
                  id = 1;
                   int period=int.parse(_body.text),
                 result=counter1 * period;
                print(result);
                });
              },
            ),
            Text(
              'day',
              style: new TextStyle(fontSize: 12.0),
            ),
 
            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                 
                setState(() {
                  radioButtonItem = 'month';
                  id = 2;
                  int period=int.parse(_body.text);
                   result=counter2 * period;
                 
                  print(result);
                });
              },
            ),
            Text(
              'month',
              style: new TextStyle(
                fontSize: 12.0,
              ),
            ),
            
            Radio(
              value: 3,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'year';
                  id = 3;
                   int period=int.parse(_body.text);
                  result=counter3 * period;
                  print(result);
                });
              },
            ),
            Text(
              'year',
              style: new TextStyle(fontSize: 12.0),
            ),
          ],
        ),
      ],
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

  void subscribePostData(BuildContext context) async {
    String countryid= _mySelection;
    print(countryid);
    String subscribtionUrl='http://192.168.56.1:5000/api/subscriptions/$countryid';
    print(subscribtionUrl);
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


    dynamic bodyToSend = {

      'userid':'$doctorid',
      'differenceBetweenDates':'$result'};
    dynamic headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $preftoken'
    };
    var body = json.encode(bodyToSend);
    //print(body);
    //request
    var response = await post(subscribtionUrl, body: body, headers: headers);
    

    if (response.statusCode == 200) {
      print(response.statusCode);
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => DocSubscription(),
      );
      await Navigator.of(context).push(route);
    }
  }

 
}
