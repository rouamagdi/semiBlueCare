import 'dart:convert';

import 'dart:core' ;
class User {
  String id;
  User({this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
    );
  }
}

class Price{
 int forOnePatient;
 int  forTwoPatients;
 int forThreePatients;
 Price({this.forOnePatient,this.forTwoPatients,this.forThreePatients});
 factory Price.fromJson(Map<String, dynamic> map) {
    return Price(
      forOnePatient: map["forOnePatient"],
      forTwoPatients:map["forTwoPatients"],
      forThreePatients:map["forThreePatients"]
    );
    }
}
class Workingdays{
 String saturday;
 String  sunday;
 String monday;
 String tuesday;
 String  wednesday;
 String thursday;
 String friday;
 Workingdays({this.saturday,this.sunday,this.monday,this.tuesday,this.wednesday,this.thursday,this.friday});
 factory Workingdays.fromJson(Map<String, dynamic> map) {
    return Workingdays(
      saturday: map["saturday"],
      sunday:map["sunday"],
      monday:map["monday"],
       tuesday: map["tuesday"],
      wednesday:map["wednesday"],
      thursday:map["thursday"],
      friday:map["friday"]
    );
    }
}
class Qualifications {
  String title;
  String source;
  String awardDate;

  Qualifications({this.title, this.source, this.awardDate});

factory Qualifications.fromJson(Map<String, dynamic> json) {
    //print(json.toString());
    return Qualifications(
      title: json['title'],
      source: json['source'],
      awardDate: json['awardDate'],
    );
  }

}
List<Qualifications> qualificationFromJson(String jsonData) {
  final data = json.decode(jsonData);

  return List<Qualifications>.from(data.map((item) => Qualifications.fromJson(item)));
}
class Doctor {
  String id;
  String freelancerName;
  String location;
  String summary;
  String nationality;
  String specialization;
  List<Qualifications> qualifications;
  String experiences;
  Price sessionPrice;
  Workingdays workingDaysandHours;
  User user;

  Doctor({
    this.id,
    this.freelancerName,
    this.summary,
    this.location,
    this.nationality,
    this.specialization,
    this.experiences,
    this.user,
    this.sessionPrice,
    this.qualifications,
    this.workingDaysandHours
  });

  factory Doctor.fromJson(Map<String, dynamic> map) {
     var list = map['qualifications'] as List;
            print(list.runtimeType);
            List<Qualifications> qualificationlist = list.map((i) => Qualifications.fromJson(i)).toList();
    return Doctor(
        id: map['_id'],
        freelancerName: map["freelancerName"],
        summary: map["summary"],
        nationality: map["nationality"],
        experiences: map["experiences"],
        location: map["location"],
        specialization: map["specialization"],
        user: User.fromJson(map['user']),
        sessionPrice: Price.fromJson(map['sessionPrice']),
        qualifications: qualificationlist,
        workingDaysandHours:Workingdays.fromJson(map['workingDaysandHours'])
        );
    /*if (map['sessionPrice'] != null ) {
return Doctor(
        id: map['id'],
        freelancerName: map["freelancerName"],
        summary: map["summary"],
        nationality: map["nationality"],
        experiences: map["experiences"],
        location: map["location"],
        specialization: map["specialization"],
        user: User.fromJson(map['user']),
        sessionPrice: Price.fromJson(map['sessionPrice']),
        //qualifications: Qualifications.fromJson(map['qualifications']),
        );
    } else {
      return Doctor(
        id: map['id'],
        freelancerName: map["freelancerName"],
        summary: map["summary"],
        nationality: map["nationality"],
        experiences: map["experiences"],
        location: map["location"],
        specialization: map["specialization"],
        user: User.fromJson(map['user']),
        //sessionPrice: Price.fromJson(map['sessionPrice']),
        //qualifications: Qualifications.fromJson(map['qualifications']),
        );
    }*/
    
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "freelancerName": freelancerName,
      "summary": summary,
      "nationality": nationality,
      "specialization": specialization,
      "experiences": experiences,
      "sessionPrice":sessionPrice,

    };
  }

  @override
  String toString() {
    return 'Doctor{id: $id, freelancerName: $freelancerName, summary: $summary, ' +
        'nationality: $nationality,specialization:$specialization,' +
        'experiences:$experiences,sessionPrice:$sessionPrice}';
  }
}

List<Doctor> doctorFromJson(String jsonData) {
  final data = json.decode(jsonData);

  //return data;
  return List<Doctor>.from(data.map((item) => Doctor.fromJson(item)));
}

/*List<Doctor> doctorFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Doctor>.from(data.map((item) => Doctor.fromJson(item)));
}*/

String doctorToJson(Doctor data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
