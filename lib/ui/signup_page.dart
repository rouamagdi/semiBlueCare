import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart'; //to use http request

import '../localizations.dart';
import '../style/theme.dart' as Theme;
import '../utils/bubble_indication_painter.dart';
import 'login_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  String name = ''; //expected: five letters or more
  String phone = ''; //expected: @
  String password = ''; //expected: five digits or more
  String token = '';
  final String registerUrl = 'http://192.168.56.1:5000/api/users/register';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeNumber = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeRole = FocusNode();
  final FocusNode myFocusNodeUserName = FocusNode();
  final FocusNode myFocusNodePassword1 = FocusNode();
  final FocusNode myFocusNodeNumber1 = FocusNode();
  final FocusNode myFocusNodeName1 = FocusNode();
  final FocusNode myFocusNodeUserName1 = FocusNode();

  final FocusNode myFocusNodePassword2 = FocusNode();
  final FocusNode myFocusNodeNumber2 = FocusNode();
  final FocusNode myFocusNodeName2 = FocusNode();
  final FocusNode myFocusNodeUserName2 = FocusNode();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController signupNumberController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupUserRoleController = TextEditingController();
  TextEditingController signupUserNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupemailController = TextEditingController();

  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController signupNumberController1 = TextEditingController();
  TextEditingController signupNameController1 = TextEditingController();
  TextEditingController signupUserNameController1 = TextEditingController();
  TextEditingController signupPasswordController1 = TextEditingController();
  TextEditingController signupConfirmPasswordController1 =
      TextEditingController();
  TextEditingController signupNumberController2 = TextEditingController();
  TextEditingController signupNameController2 = TextEditingController();
  TextEditingController signupUserNameController2 = TextEditingController();
  TextEditingController signupPasswordController2 = TextEditingController();
  TextEditingController signupConfirmPasswordController2 =
      TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: AssetImage('assets/img/1.png')),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (i) {
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      } else if (i == 1) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.white;
                        });
                      } else if (i == 2) {
                        setState(() {
                          right = Colors.black;
                          left = Colors.white;
                        });
                      }
                    },
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp(context),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp1(context),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: _buildSignUp2(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeNumber.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(
          pageController: _pageController,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                   AppLocalizations.of(context).useraccount,
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUp1ButtonPress,
                child: Text(
                  AppLocalizations.of(context).doctoraccount,
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUp2ButtonPress,
                child: Text(
                AppLocalizations.of(context).hospitalaccount,
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 420.0,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeName,
                                controller: signupNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  
                                  labelText: AppLocalizations.of(context).sname,
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),

                            /* Visibility(
                        visible: false,
                          child: TextFormField(
                          initialValue: "isUser",
                          //controller: signupUserRoleController,
                           validator: (String value){if(value.length == 0) {
                             return 'Fill in this field';}
                             else if(value.length <= 4) {
                          return "user name is too short and have to"+"\n"+"contain at least one number";
                            }else {
                              return null;}},
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.grey,
                            ),
                            hintText: "Role",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),*/

                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeUserName,
                                controller: signupUserNameController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Fill in this field';
                                  } else if (value.length <= 4) {
                                    return "user name is too short and have to" +
                                        "\n" +
                                        "contain at least one number";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  
                                  labelText: AppLocalizations.of(context).susername,
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeNumber,
                                controller: signupNumberController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Fill in this field';
                                  } else if (value.length < 9) {
                                    return "phone number is too short";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.mobile,
                                    color: Colors.grey,
                                  ),
                                  
                                  labelText: AppLocalizations.of(context).sphone,
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodePassword,
                                controller: signupPasswordController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Fill in this field';
                                  } else if (value.length < 6) {
                                    return "Password too short and have" +
                                        "\n" +
                                        " to contain numbers";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: _obscureTextSignup,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  
                                  labelText: AppLocalizations.of(context).spassword,
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignup,
                                    child: Icon(
                                      _obscureTextSignup
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1.0,
                                  bottom: 15.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: signupConfirmPasswordController,
                                obscureText: _obscureTextSignupConfirm,
                                validator: (value) {
                                  if (value != signupPasswordController.text) {
                                    return 'Password is not matching';
                                  }
                                },
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  
                                  labelText: AppLocalizations.of(context).sconfirmpass,
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignupConfirm,
                                    child: Icon(
                                      _obscureTextSignupConfirm
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 410.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                             AppLocalizations.of(context).signupbtn,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            //method to save forms
                            formKey.currentState.save();
                            registerPostData(context);
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUp1(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey1,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 360.0,
                      child: Form(
                        key: formKey1,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeName1,
                                controller: signupNameController1,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeUserName1,
                                controller: signupUserNameController1,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  hintText: "User Name",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeNumber1,
                                controller: signupNumberController1,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.mobile,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Phone Number ",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodePassword1,
                                controller: signupPasswordController1,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Fill in this field';
                                  } else if (value.length <= 4) {
                                    return 'Password too short';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: _obscureTextSignup,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignup,
                                    child: Icon(
                                      _obscureTextSignup
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: signupConfirmPasswordController1,
                                obscureText: _obscureTextSignupConfirm,
                                validator: (value) {
                                  if (value != signupPasswordController1.text) {
                                    return 'Password is not matching';
                                  }
                                },
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Confirmation",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignupConfirm,
                                    child: Icon(
                                      _obscureTextSignupConfirm
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 340.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          if (formKey1.currentState.validate()) {
                            //method to save forms
                            formKey1.currentState.save();
                            registerPostData1(context);
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUp2(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey2,
      body: Builder(
        builder: (context) => Center(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 360.0,
                      child: Form(
                        key: formKey2,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeName,
                                controller: signupNameController2,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeUserName,
                                controller: signupUserNameController2,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.grey,
                                  ),
                                  hintText: "User Name",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodeNumber,
                                controller: signupNumberController2,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.mobile,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Phone Number ",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                focusNode: myFocusNodePassword,
                                controller: signupPasswordController2,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Fill in this field';
                                  } else if (value.length <= 4) {
                                    return 'Password too short';
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: _obscureTextSignup,
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignup,
                                    child: Icon(
                                      _obscureTextSignup
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 10.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextFormField(
                                controller: signupConfirmPasswordController2,
                                obscureText: _obscureTextSignupConfirm,
                                validator: (value) {
                                  if (value != signupPasswordController2.text) {
                                    return 'Password is not matching';
                                  }
                                },
                                style: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 16.0,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    FontAwesomeIcons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Confirmation",
                                  hintStyle: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignupConfirm,
                                    child: Icon(
                                      _obscureTextSignupConfirm
                                          ? FontAwesomeIcons.eye
                                          : FontAwesomeIcons.eyeSlash,
                                      size: 15.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 340.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [
                            Theme.Colors.loginGradientEnd,
                            Theme.Colors.loginGradientStart
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          if (formKey2.currentState.validate()) {
                            //method to save forms
                            formKey2.currentState.save();
                            registerPostData2(context);
                          }
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerPostData(BuildContext context) async {
    //post body
    String role = 'isUser';

    dynamic bodyToSend = {
      '$role': true,
      'fullName': signupNameController.text,
      'userName': signupUserNameController.text,
      'phoneNumber': signupNumberController.text,
      'password': signupPasswordController.text
    };
    dynamic headers = {'Content-Type': 'application/json'};
    print("still");
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(registerUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    /*var givenToken = state['token'];
    token = givenToken;
    print(token);*/
    if (response.statusCode == 200) {
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      );
      await Navigator.of(context).push(route);
    } else if (response.statusCode == 400) {
      state.toString();
      //error message
      var error = state['userName'];
      final snackBar = SnackBar(
        content: Text(error),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print(error.toString());
      print(response.statusCode);
    }
  }

  void registerPostData1(BuildContext context) async {
    //post body

    dynamic bodyToSend = {
      'isFreelancer': true,
      'fullName': signupNameController1.text,
      'userName': signupUserNameController1.text,
      'phoneNumber': signupNumberController1.text,
      'password': signupPasswordController1.text,
    };
    dynamic headers = {'Content-Type': 'application/json'};
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(registerUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    //token
    var givenToken = state['token'];
    token = givenToken;
    print(token);
    if (response.statusCode == 200) {
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      );
      await Navigator.of(context).push(route);
    } else if (response.statusCode == 400) {
      state.toString();
      //error message
      var error = state['userName'];
      final snackBar = SnackBar(
        content: Text(error),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print(error.toString());
      print(response.statusCode);
    }
  }

  void registerPostData2(BuildContext context) async {
    //post body
    //String role='isHospital';
    dynamic bodyToSend = {
      'isHospital': true,
      'fullName': signupNameController2.text,
      'userName': signupUserNameController2.text,
      'phoneNumber': signupNumberController2.text,
      'password': signupPasswordController2.text
    };
    dynamic headers = {'Content-Type': 'application/json'};
    var body = json.encode(bodyToSend);
    print(body);
    //request
    var response = await post(registerUrl, body: body, headers: headers);
    var state = json.decode(response.body);
    print(response.statusCode); //token

    if (response.statusCode == 200) {
      //Navigator.of(context).pushNamed('/secondScreen');
      var route = MaterialPageRoute(
        builder: (BuildContext context) => Login(),
      );
      await Navigator.of(context).push(route);
    } else if (response.statusCode == 400) {
      state.toString();
      //error message
      var error = state['userName'];
      final snackBar = SnackBar(
        content: Text(error),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      print(error.toString());
      print(response.statusCode);
    }
  }

  void _onSignUpButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUp1ButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUp2ButtonPress() {
    _pageController?.animateToPage(2,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
