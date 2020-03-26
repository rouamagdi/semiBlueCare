import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginn/components/addconsult.dart';
import 'package:loginn/components/api_services.dart';
import 'package:loginn/components/user_reservation.dart';
import 'package:loginn/models/doctor_model.dart';

import '../components/articlsadd.dart';
import '../localizations.dart';
import '../style/theme.dart' as Theme;
import 'chat_home.dart';
import 'edit_docpro.dart';

class DoctorProfile extends StatefulWidget {
  Doctor doctor;
  int index;
  DoctorProfile({this.doctor,this.index});
  _DoctorProfileState createState() => _DoctorProfileState();
}
Future doctorProfile;
Future userQual;
List<Qualifications> qualification = [];

class _DoctorProfileState extends State<DoctorProfile> {
  bool _status = true;
  
 @override
  BuildContext context;
 
//save the result of camera file

  File _image;
  
    
  String freelancerUrl = 'http://192.168.56.1:5000/api/freelancers/';
   @override
    void initState() {
      super.initState();
   
      freelancerUrl = freelancerUrl +'${widget.doctor.id}';
   print(freelancerUrl);
      doctorProfile = ApiService().getdoctor(freelancerUrl);
   print(doctorProfile.toString());       
  
    }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
         backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
           iconTheme: IconThemeData(color:Theme.Colors.maincolor),
         
        ),
        //backgroundColor: AppColors.mainColor,
        body:   SafeArea(
            child: FutureBuilder(
                future: doctorProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.toString());
                    if (snapshot.data != null) {
                      Doctor doctor = snapshot.data;
                      //print(doctor.qualifications[0].title);
                      qualification = doctor.qualifications;
                      return buildUserProfile(context, doctor, qualification);
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
                })));}}
                Widget buildUserProfile(context, data, qualifications) {
       return Column(
          children: <Widget>[
            Container(
              height: 200,
              child: Row(
                children: <Widget>[
                  Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(15),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/bg.jpeg"),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            data.freelancerName,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 24),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                           data.specialization,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                          Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Material(
                          child: Container(
                            height: 30,
                            width: 50,
                            child: Center(
                              child: Text(
                                data.sessionPrice.forOnePatient.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        AppLocalizations.of(context).perinterview,
                        style: TextStyle(color: Colors.grey),
                      ),
                      FlatButton(
                        color: Theme.Colors.maincolor,
                        textColor: Colors.white,
                       
                        shape: CircleBorder(),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildAboutDialog(context, data),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                       
                            
                             MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddConsult()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(AppLocalizations.of(context).consult),
                          ),
                          textColor: Colors.white,
                          color: Colors.grey,
                          //height: 30,
                          //minWidth: MediaQuery.of(context).size.width-40,
                        ),
                        SizedBox(
                              width: 30,
                            ),
                          MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => Chat()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Text(AppLocalizations.of(context).message),
                          ),
                          textColor: Colors.white,
                          color: Theme.Colors.maincolor,
                          //minWidth: MediaQuery.of(context).size.width-40,
                        ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
           Expanded(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).description,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 20),
            ),
            Text(
              data.summary, //'${doctor.summary}',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context).qualifications,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    AppLocalizations.of(context).specialization,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    AppLocalizations.of(context).source,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 16),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(AppLocalizations.of(context).year,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 16)),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        qualification = data.qualifications;
                        return Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Text(qualification[index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16)),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(qualification[index].source,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16)),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(qualification[index].awardDate.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16)),
                            ),
                          ],
                        );
                        
                      },
                      itemCount: qualification.length,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context).experience,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              data.experiences,
            ),
            SizedBox(
              height: 5,
            ),
           
          ],
        ),
      )),
      MaterialButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => UseryReservation(doctor:data)));
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text(AppLocalizations.of(context).reservationbtn),
        ),
        textColor: Colors.white,
        color: Theme.Colors.maincolor,
        minWidth: MediaQuery.of(context).size.width - 40,
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
  }
Widget _buildAboutDialog(context, data) {
  return new AlertDialog(
    title: const Text('Session Price'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Material(
              child: Container(
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    " for One person",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.5)),
              color: Colors.grey),
          SizedBox(
            width: 20,
          ),
          Material(
              child: Container(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    data.sessionPrice.forOnePatient.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(children: <Widget>[
          Material(
              child: Container(
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    " for Two person",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.5)),
              color: Colors.grey),
          SizedBox(
            width: 20,
          ),
          Material(
              child: Container(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    data.sessionPrice.forTwoPatients.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey),
        ]),
        SizedBox(
          height: 20,
        ),
        Row(children: <Widget>[
          Material(
              child: Container(
                height: 30,
                width: 150,
                child: Center(
                  child: Text(
                    " for Three person",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.5)),
              color: Colors.grey),
          SizedBox(
            width: 20,
          ),
          Material(
              child: Container(
                height: 30,
                width: 50,
                child: Center(
                  child: Text(
                    data.sessionPrice.forThreePatients.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.grey),
        ])
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.Colors.maincolor,
        child: const Text('Okay, got it!'),
      ),
    ],
  );
}

typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 16,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: 16,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: 16,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
