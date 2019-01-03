import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:my_app/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'response.dart';

class User{
  int id;
  String username;


  User({
    this.id,
    this.username
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json["id"],
      username:json["username"]
    );
  }
}


//add to the list
Future<dynamic> add(http.Client client,  String un, String pw) async {  
  final response = await client.post(BASE_URL+'/user/', body: {"username":un,"password":pw});
  
  return json.decode(response.body); 
}
//login to the list
Future<dynamic> userLogin(http.Client client,  String un, String pw) async {
  final response = await client.post(BASE_URL+'/user/login', body: {"username":un,"password":pw}); 
  Response response1 = new Response.fromJson(json.decode(response.body));

  SharedPreferences prefs = await SharedPreferences.getInstance();
   if (response1.status) {
        User user = new User.fromJson(response1.result);
        print(user.id);
        prefs.setInt("id", user.id);
   }  
  return json.decode(response.body);  
}