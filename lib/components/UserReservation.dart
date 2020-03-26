import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loginn/google_map_location_picker.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/style/theme.dart' as Theme;

import '../localizations.dart';
import '../models/profile.dart';
import 'api_services.dart';
final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();


class Userreservation extends StatefulWidget {
   UserReservation userreservation;
   int index;
   
  Userreservation({this.userreservation,this.index});

  @override
  _UserreservationState createState() => _UserreservationState();
}
 File _image;
 
class _UserreservationState extends State<Userreservation> {
  BuildContext context;
  ApiService apiService;
   
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
                          
                           '${widget.userreservation.age}',
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
                          
                           '${widget.userreservation.gender}',
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
                          
                          '5/9/2009',
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
                                   '${widget.userreservation.statusDescription}',
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
                  
                
              
            
            ],
          ),
        
      ),
    ),],),],
    
      ),),
      ),
      );
  }


  
}

