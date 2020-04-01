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
  String id;
  String centerName;
  //String location;

  String  summary;

  int maximumNumberOfPatients;
  String openingTime;
  String openDate;
  //String CenterPrice;
  bool isPrivate;
  bool isGovernmental;
  int staff;
 List<Spcialists> spcialists;
 
 // String avatar;
 
  Centery({this.id, this.centerName, this.summary,this.maximumNumberOfPatients,
   this.openingTime, this.staff,this.spcialists,this.openDate,this.isGovernmental,this.isPrivate});

  factory Centery.fromJson(Map<String, dynamic> map) {
     var list = map['spcialists'] as List;
            print(list.runtimeType);
            List<Spcialists> spcialistslist = list.map((i) => Spcialists.fromJson(i)).toList();
    return Centery(
        id: map['_id'], centerName: map["centerName"],
         summary: map["summary"], 
         maximumNumberOfPatients: map["maximumNumberOfPatients"],
        openingTime: map["openingTime"],openDate:map['openDate'],
        
        isGovernmental: map['isGovernmental'],isPrivate: map['isPrivate'],
         staff: map["staff"],spcialists:spcialistslist);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "centerName": centerName,
     "summary": summary, "maximumNumberOfPatients": maximumNumberOfPatients,
      "openingTime":openingTime,
       "staff": staff, "spcialistslist":spcialists,
       };
  }

  @override
  String toString() {
    return 'Center{_id: $id, centerName: $centerName, summary: $summary, '+
    'maximumNumberOfPatients: $maximumNumberOfPatients,openingTime:$openingTime,spcialistslist:$spcialists,isGovernmental:$isGovernmental,isPrivate:$isPrivate'+
    'staff:$staff}';
  }

}

List<Centery> centerFromJson(String jsonData) {
   final data = json.decode(jsonData);

 return List<Centery>.from(data.map((item) => Centery.fromJson(item)));
}

String centerToJson(Centery data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}