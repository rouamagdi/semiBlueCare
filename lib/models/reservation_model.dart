import 'dart:convert';

import 'dart:core' ;

import 'doctor_model.dart';
class User {
  String id;
  String fullname;
  User({this.id, this.fullname});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullname: json['fullname'],
    );
  }
}
class Reservation {
  String id;
  String statusDescription;
  String age;
  String gender;
  String bookingDate;
  String doctor;
  User patient;
 
  
 

  Reservation({this.id, this.statusDescription,  this.age,this.gender,this.bookingDate,this.doctor, this.patient });

  

  factory Reservation.fromJson(Map<String, dynamic> map) {
  
    return Reservation(
      id: map["_id"],
        statusDescription: map["statusDescription"],
         age: map["age"], 
         gender: map["gender"],
         bookingDate :map["bookingDate"],
         doctor: map["doctor"],
         patient:User.fromJson(map['patient']));
  }

  Map<String, dynamic> toJson() {
    return {"id": id,"statusDescription": statusDescription,  "age": age,"gender":gender,"bookingDate":bookingDate,"doctor":doctor };
  }

  @override
  String toString() {
    return 'id: $id,statusDescription: $statusDescription,  age: $age,gender:$gender,bookingDate:$bookingDate,doctor:$doctor, patient:$patient';
  }

  

}

List<Reservation> reservationFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Reservation>.from(data.map((item) => Reservation.fromJson(item)));
}

String reservationToJson(Reservation data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class Freelancer {
  String id;
  String freelancerName;
  Freelancer({this.id,this.freelancerName});

  factory Freelancer.fromJson(Map<String, dynamic> json) {
    return Freelancer(
      id: json['_id'],
      freelancerName:json['freelancerName'],

    );
  }
}



class UserReservation {
  String id;
  String statusDescription;
  String age;
  String gender;
  String bookingDate;
  Freelancer doctor;
  String patient;
 
  
 

  UserReservation({this.id, this.statusDescription,  this.age,this.gender,this.bookingDate,this.doctor, this.patient });

  

  factory UserReservation.fromJson(Map<String, dynamic> map) {
  
    return UserReservation(
      id: map["_id"],
        statusDescription: map["statusDescription"],
         age: map["age"], 
         gender: map["gender"],
         bookingDate :map["bookingDate"],
         patient: map["patient"],
         doctor:Freelancer.fromJson(map['doctor']));
  }

  Map<String, dynamic> toJson() {
    return {"id": id,"statusDescription": statusDescription,  "age": age,"gender":gender,"bookingDate":bookingDate,"doctor":doctor };
  }

  @override
  String toString() {
    return 'id: $id,statusDescription: $statusDescription,  age: $age,gender:$gender,bookingDate:$bookingDate,doctor:$doctor, patient:$patient';
  }

  

}

List<UserReservation> userreservationFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<UserReservation>.from(data.map((item) => UserReservation.fromJson(item)));
}

String userreservationToJson(Reservation data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}