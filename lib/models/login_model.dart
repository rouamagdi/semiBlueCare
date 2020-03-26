
import 'dart:convert';
//login class
class Login {
  //login objects
  int id;
   String username, password;
  

  //login constructor
  Login({this.id,this.username, this.password});

  //function to convert from json to object 
  factory Login.fromJson(Map <String, dynamic> parsedJson) {
    return Login(
      id:parsedJson['id'],
      username: parsedJson['username'],
      password: parsedJson['password'],
 
    );
  }

Map<String, dynamic> toJson() {
    return { "id":id,"username": username, "password": password};
  }
  //toString method
  String toString() {
    return 'id:$id,username: $username, password: $password';
  }
}

List<Login> loginFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Login>.from(data.map((item) => Login.fromJson(item)));
}

String loginToJson(Login data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}



class ResponseBody {
  int id;
  String username,  password, accessToken;


  ResponseBody({this.id,this.username, this.password, this.accessToken});
}
