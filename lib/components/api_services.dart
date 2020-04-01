
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:loginn/models/articls_model.dart';
import 'package:http/http.dart' show Client;
import 'package:loginn/models/center_model.dart';
import 'package:loginn/models/consult_model.dart';
import 'package:loginn/models/doctor_model.dart';
import 'package:loginn/models/login_model.dart';
import 'package:loginn/models/reservation_model.dart';
import 'package:loginn/models/subscribe_model.dart';


class ApiService {
   final AsyncMemoizer _memoizer = AsyncMemoizer();
  Client client = Client();

 final String articlsUrl = 'http://192.168.56.1:5000/api/articles';
final String allFreelancerUrl='http://192.168.56.1:5000/api/freelancers';
  final String consultUrl = 'http://192.168.56.1:5000/api/consultations/comment/';
  
  final String allconsultUrl = 'http://192.168.56.1:5000/api/consultations';
  
Future<List<Articls>> getArticlss() async {
    final response = await client.get("$articlsUrl");
    if (response.statusCode == 200) {
      return articlsFromJson(response.body);
    } else {
      return null;
    }
  }
   
Future<List<Consult>> getConsults() async {
  
    final response = await client.get("$allconsultUrl");
    if (response.statusCode == 200) {
      return consultFromJson(response.body);
      
      
    } else {
      return null;
    }
    
  }
  Future<List<Comment>> getComments(commentUrl) async {
  
    final response = await client.get("$commentUrl");
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return null;
    }
    
  }
  Future<List<Qualifications>> getQualification(qualificationUrl) async {
  
    final response = await client.get("$qualificationUrl");
    if (response.statusCode == 200) {
      //print(response.body.toString());

      return qualificationFromJson(response.body);
      
    } else {
      print(response.statusCode);
      return null;
    }
    
  }
Future<List<Spcialists>> getSpecailist(specailistrUrl) async {
  
    final response = await client.get("$specailistrUrl");
    if (response.statusCode == 200) {
      //print(response.body.toString());

      return spcialistsFromJson(response.body);
      
    } else {
      //print(response.statusCode);
      return null;
    }
    
  }

var i = 200;
  Future getdoctor(doctorUrl) async {
    //return this._memoizer.runOnce(() async  {
    final response = await client.get("$doctorUrl");
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return Doctor.fromJson(parsed);
    } else {
      return null;
    }
   //});
  }
   Future getuser(userUrl) async {
    //return this._memoizer.runOnce(() async  {
    final response = await client.get("$userUrl");
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      return Login.fromJson(parsed);
    } else {
      return null;
    }
   //});
  }
  Future<List<Doctor>> getFreelancers() async {
  
    final response = await client.get("$allFreelancerUrl");
    if (response.statusCode == 200) {
     // print(response.body.toString());
      return doctorFromJson(response.body);
      
      
    } else {
      return null;
    }
    
  }

  
Future<List<Reservation>> getReservations(doctorAllReservationUrl) async {
  
    final response = await client.get("$doctorAllReservationUrl");
    if (response.statusCode == 200) {
      return reservationFromJson(response.body);      
    } else {
      return null;
    }
    
  }

  Future<List<Reservationy>> getuserReservations(userAllReservationUrl) async {
  
    final response = await client.get("$userAllReservationUrl");
    if (response.statusCode == 200) {
      print(response.body);
      return userreservationFromJson(response.body);      
    } else {
      return null;
    }
    
  }

  
  

  Future<Centery> getCenter(centerUrl) async {
    final response = await client.get("$centerUrl");
    if (response.statusCode == 200) {
      //return doctorFromJson(response.body);
      //return jsonDecode(response.body);
      final parsed = jsonDecode(response.body);
      //print(parsed.toString());
      return Centery.fromJson(parsed);
    } else {
      return null;
    }
    
  }
   Future<List<Centery>> getCenters(centersUrl) async {
    final response = await client.get("$centersUrl");
    if (response.statusCode == 200) {
     // print(response.body.toString());
     print(response.body);
      return centerFromJson(response.body);

     
      
      
    } else {
      return null;
    
    }
    
  }

 Future<List<Subscribtion>> getSubscribtion() async {
  final String allSubscribtionUrl = 'http://192.168.56.1:5000/api/subscriptions';
  print("Url $allSubscribtionUrl");
    final response = await client.get(allSubscribtionUrl);
    if (response.statusCode == 200) {

       print(response.body.toString());
      return subFromJson(response.body);
      
     
    } else {
       
      return null;
    }
    
  }
  


  
  }