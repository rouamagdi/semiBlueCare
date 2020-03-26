import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:scoped_model/scoped_model.dart';
 final String consultUrl = 'http://192.168.56.1:5000/api/consultations/';

class Consult {
  String id;
 
  String consultationBody;
  List <Comment> comments;
  
   Client client = Client();

  Consult({this.id,  this.consultationBody,this.comments });

  

  factory Consult.fromJson(Map<String, dynamic> map) {
   var list = map['comments'] as List;
            print(list.runtimeType);
            List<Comment> commentlist = list.map((i) => Comment.fromJson(i)).toList();
    return Consult(
        id: map["_id"],  consultationBody: map["consultationBody"],comments :commentlist);
  }

  Map<String, dynamic> toJson() {
    return {"id": id,  "consultationBody": consultationBody,"commentlist":comments };
  }

  @override
  String toString() {
    return 'id: $id,  consultationBody: $consultationBody,comments:$comments';
  }

  

}

List<Consult> consultFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Consult>.from(data.map((item) => Consult.fromJson(item)));
}

String consultToJson(Consult data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


class Comment{
  String id;
 
  String commentBody;
  

  
   

  Comment({this.id ,  this.commentBody });
Client client = Client();
  

  factory Comment.fromJson(Map<String, dynamic> map) {
    return Comment(
        id: map["_id"],  commentBody: map["commentBody"] );
  }

  Map<String, dynamic> toJson() {
    return {"id": id,  "commentBody": commentBody,};
  }

  @override
  String toString() {
    return 'id: $id,  commentBody: $commentBody';
  }

  

}

List<Comment> commentFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Comment>.from(data.map((item) => Comment.fromJson(item)));
}

String commentToJson(Comment data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}


