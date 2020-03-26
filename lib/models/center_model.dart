import 'dart:convert';
class Spcialists{

  String specialistName;
  String specialty;
  String  nationality;



  Spcialists({this.specialistName,this.nationality,this.specialty});

factory Spcialists.fromJson(Map<String, dynamic> map) {
    return Spcialists(
       specialistName:map['specialistName'],
       specialty:map['specialty'],nationality:map['nationality'],
     

    );}
}
List<Spcialists> spcialistsFromJson(String jsonData) {
  final data = json.decode(jsonData);

  return List<Spcialists>.from(data.map((item) => Spcialists.fromJson(item)));
}
class Centery {
  int id;
  String centerName;
  //String location;

  String  summary;

  int maximumNumberOfPatients;
  String openingTime;
  String openDate;
  //String CenterPrice;
  int staff;
 List<Spcialists> spcialists;
 // String avatar;
 
  Centery({this.id, this.centerName, this.summary,this.maximumNumberOfPatients,
   this.openingTime, this.staff,this.spcialists,this.openDate});

  factory Centery.fromJson(Map<String, dynamic> map) {
     var list = map['spcialists'] as List;
            print(list.runtimeType);
            List<Spcialists> spcialistslist = list.map((i) => Spcialists.fromJson(i)).toList();
    return Centery(
        id: map['id'], centerName: map["centerName"],
         summary: map["summary"], 
         maximumNumberOfPatients: map["maximumNumberOfPatients"],
        openingTime: map["openingTime"],openDate:map['openDate'],
         staff: map["staff"],spcialists:spcialistslist);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "centerName": centerName,
     "summary": summary, "maximumNumberOfPatients": maximumNumberOfPatients,
      "openingTime":openingTime,
       "staff": staff, 
       };
  }

  @override
  String toString() {
    return 'Center{id: $id, centerName: $centerName, summary: $summary, '+
    'maximumNumberOfPatients: $maximumNumberOfPatients,openingTime:$openingTime,'+
    'staff:$staff}';
  }

}

Future<Centery> CenterFromJson(String jsonData) {
   final data = json.decode(jsonData);

  return data;
}

String centerToJson(Centery data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}