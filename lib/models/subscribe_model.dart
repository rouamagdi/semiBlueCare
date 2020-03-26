import 'dart:convert';

class Retailers{
String id;
String retailerName;
Retailers({this.id,this.retailerName});
factory Retailers.fromJson(Map<String, dynamic> json) {
    return Retailers(
      id: json['_id'],
      retailerName:json['retailerName']
    );
  }
}


class Cities{
String id;
String cityName;
Retailers retailers;
Cities({this.id,this.cityName,this.retailers});
factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
      id: json['_id'],
      cityName:json['cityName'],
      retailers:Retailers.fromJson(json['retailers']),
    );
  }
}


class Country{
   String id;
   String countryName;
   String code;
List<Cities> cities;
Country({this.id,this.cities,this.code,this.countryName});
  factory Country.fromJson(Map<String, dynamic> map) {
     var list = map['qualifications'] as List;
            print(list.runtimeType);
            List<Cities> citieslist = list.map((i) => Cities.fromJson(i)).toList();
    return Country(
       id: map['_id'],
       countryName:map['countryName'],

       cities:citieslist,
       


    );}

}
class Freelancer {
  String id;
  
  Freelancer({this.id});

  factory Freelancer.fromJson(Map<String, dynamic> json) {
    return Freelancer(
      id: json['_id'],
     
    );
  }
}

class Subscribtion{
  String id;
  int differenceBetweenDates;
  String user;
  Subscribtion({this.id,this.differenceBetweenDates,this.user});
  factory Subscribtion.fromJson(Map<String, dynamic> map) {
  
    return Subscribtion(
      id: map['_id'],
      differenceBetweenDates:map['differenceBetweenDates'],
      user:map['user'],
      
      )  ;}
    
}
  List<Subscribtion> subFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Subscribtion>.from(data.map((item) => Subscribtion.fromJson(item)));
}
