import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:my_app/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Task{
  int id;
  String name;
  String datetime;
  String description;
  String priority;
  String due_date;


  Task({
    this.id,
    this.name,
    this.datetime,
    this.description,
    this.priority,
    this.due_date
  });

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
      id: json["id"],
      name:json["name"],
      description:json["description"],
      datetime:json["datetime"],
      priority:json["priority"],
      due_date:json["due_date"]
    );
  }
}

//fetch data from rest api
Future<List<Task>> fetchTodos(http.Client client) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await client.get(BASE_URL+'/list/'+prefs.getInt("id").toString(),headers: {
        'Content-Type': 'application/json',
      });
  if(response.statusCode == 200){
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final todos = mapResponse["result"].cast<Map<String, dynamic>>();
    final listOfTodos = await todos.map<Task>((json){
      return Task.fromJson(json);
    }).toList();
    // print(listOfTodos);
    return listOfTodos.reversed.toList();

  }else{
    throw Exception("Failed to load Todo from the server");
  }
}

//add to the list
Future<Task> addTodo(http.Client client,  Map<String, dynamic> params) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  params["user_id"] = prefs.getInt("id").toString();
  final response = await client.post(BASE_URL+'/list/', body: params);
  if (response.statusCode == 200) {
    final responseBody = await json.decode(response.body);
    return Task.fromJson(responseBody);
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//update list
Future<Task> updateATodo(http.Client client,  Map<String, dynamic> params) async {
  final response = await client.put('$BASE_URL/list/${params["id"]}', body: params);
  if (response.statusCode == 200) {
    final responseBody = await json.decode(response.body);
    return Task.fromJson(responseBody);
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}
//Delete a Task
Future<Task> deleteATodo(http.Client client, int id) async {
  final String url = '$BASE_URL/list/$id';
  final response = await client.delete(url);
  if (response.statusCode == 200) {final responseBody = await json.decode(response.body);
  return Task.fromJson(responseBody);

  } else {
    throw Exception('Failed to delete a Task');
  }
}