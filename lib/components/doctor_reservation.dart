import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loginn/google_map_location_picker.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/style/theme.dart' as Theme;

import '../localizations.dart';
import '../models/profile.dart';
import 'User_reservation.dart';
import 'api_services.dart';
final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


class DoctorReservation extends StatefulWidget {
   Reservation reservation;
   int index;
   
  DoctorReservation({this.reservation,this.index});

  @override
  _DoctorReservationState createState() => _DoctorReservationState();
}
 File _image;
 
class _DoctorReservationState extends State<DoctorReservation> {
  BuildContext context;
  ApiService apiService;
   final FocusNode centerName = FocusNode();
  final FocusNode centerTime = FocusNode();

  final FocusNode centerLocation = FocusNode();
  final FocusNode centerDescription = FocusNode();
  final FocusNode centerCapacity = FocusNode();
  final FocusNode  centerLanuchDate= FocusNode();
  final FocusNode centerSpecilaist = FocusNode();
  final FocusNode centerMedicalStaff = FocusNode();
 
  LocationResult _pickedLocation;

  
  TextEditingController _centerName = TextEditingController();
  TextEditingController _centerTime = TextEditingController();
  TextEditingController _centerDescription = TextEditingController();
  TextEditingController _centerCapcity = TextEditingController();
  TextEditingController _centerLanuch = TextEditingController();
  TextEditingController _centerStaff = TextEditingController();
  TextEditingController _centerMedicalStaff = TextEditingController();
   TextEditingController _centerSpecialist = TextEditingController();
  List<Widget>list = List();
 bool _isFieldNameValid;
final formKey = GlobalKey<FormState>();
 final format = DateFormat("yyyy-MM-dd");
 final format1 = DateFormat("hh:mm a");
int _count = 1;
 int _value2 = 0;

  @override
Widget build(BuildContext context) {
   
     return Scaffold(
     
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "  Reservations",
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

              
                color: Colors.white,
              
                
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0, left: 9.0, right: 9.0, top: 10.0),
                  child: Column(
                    
                    children: <Widget>[
              
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                                 
                                 
                                 ),
                                
                              
                               Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                               Icon(Icons.delete_forever,color: Colors.black87,),
                               SizedBox(width: 10.0),
                                Text(
                          
                           AppLocalizations.of(context).reservationNum,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),
                          
                               Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                               Icon(Icons.call,color: Colors.black87,),
                               SizedBox(width: 10.0),
                                Text(
                          
                          '342545345',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),
                            
                          
                          
                   
                     
                    
                      
                      Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                                Text(
                          
                         AppLocalizations.of(context).reservtype,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                       ),
                               SizedBox(width: 10.0),
                                Text(
                          
                          'Consult',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),
                            
                         Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                                Text(
                          
                          AppLocalizations.of(context).patientname,
                          style: TextStyle(
                         color: Colors.black,
                              fontWeight: FontWeight.bold),
                       ),
                               SizedBox(width: 10.0),
                                Text(
                          
                          'Ahmed Tibin',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),
                   
                     Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                                Text(
                          
                         AppLocalizations.of(context).patientage,
                          style: TextStyle(
                               color: Colors.black,
                              fontWeight: FontWeight.bold),
                       ),
                               SizedBox(width: 10.0),
                                Text(
                          
                           '${widget.reservation.age}',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),
                          Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                                Text(
                          
                          AppLocalizations.of(context).gender,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                       ),
                               SizedBox(width: 10.0),
                                Text(
                          
                           '${widget.reservation.gender}',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                             
                            ],
                          )),

                      
                       Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            
                            children: <Widget>[
                                Text(
                          
                          AppLocalizations.of(context).date,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                       ),
                               SizedBox(width: 10.0),
                                Text(
                          
                         '${widget.reservation.bookingDate}',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                       ),
                              IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.grey,
              ),
              onPressed: () {
                 /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditDoctorProfile()));
              Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => EditDoctorProfile())
                            );  */  
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UseryReservation()));          
              },
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).description,
                                    style: TextStyle(
                                      color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                           Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 0.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                 
                                 Text(
                                   '${widget.reservation.statusDescription}',
                                          style: TextStyle(
                                        fontSize: 16.0,
                                         color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      
                    ],
                    
                  ),
                  
                
                Container(
                
                 margin: EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  
                  
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    color: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () =>
                       {
                          if(formKey.currentState.validate()) {
                                //method to save forms
                                formKey.currentState.save(),
                                }
                       }
                        ),
              ),
            
            ],
          ),
        
      ),
    ),],),],
    
      ),),
      ),
      );
  }


  
}

