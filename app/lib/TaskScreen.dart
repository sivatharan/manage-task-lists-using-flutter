import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/task.dart';
import 'detailsTask.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

List<Task> _searchResult = [];
List<Task> _taskDetails = [];

class TaskList extends StatefulWidget {
  @override
  _TaskPageState createState() => new _TaskPageState();
}

class _TaskPageState extends State<TaskList> {
  TextEditingController controller = new TextEditingController();

  void getTask() {
    fetchTodos(http.Client()).then((dynamic res) {
      setState(() {
        _taskDetails = res;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTask();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Task List'),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirmation"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[Text("Do you want to logout ?")],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('Yes'),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove("id");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                        ),
                        new FlatButton(
                          child: new Text('No'),
                          onPressed: () async {
                            Navigator.pop(context); //Quit to previous screen
                          },
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Task newTask = new Task();
          newTask.id = null;
          newTask.name = "";
          newTask.description = "";
          newTask.priority = "Low";
          newTask.datetime = null;
          newTask.due_date = "2018-12-22";

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsTask(
                      task: newTask,
                    )),
          );
        },
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          color:
                              index % 2 == 0 ? Colors.greenAccent : Colors.cyan,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${index + 1}.${_searchResult[index].name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              Text(
                                'Date: ${_taskDetails[index].due_date.substring(0, 10)}',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Task selectedTodo = _taskDetails[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) =>
                                      DetailsTask(task: selectedTodo)));
                        },
                      );
                    },
                  )
                : new ListView.builder(
                    itemCount: _taskDetails.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(12.0),
                          color:
                              index % 2 == 0 ? Colors.greenAccent : Colors.cyan,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${index + 1}.${_taskDetails[index].name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                             
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    'Due Date: ${_taskDetails[index].due_date.substring(0, 10)}',
                                    style: TextStyle(fontSize: 14.0),
                                  )),
                                  new Padding(
                                    padding: EdgeInsets.all(8),
                                  ),
                                  Expanded(child:  Text('*',
                                  textAlign: TextAlign.right,
                                    style: TextStyle(fontSize: 26.0,color: (_taskDetails[index].priority=="Hight"?Colors.red:(_taskDetails[index].priority=="Mediam"?Colors.yellow:Colors.white))),
                                  )),
                                ],
                              )
                              
                            ],
                          ),
                        ),
                        onTap: () {
                          Task selectedTodo = _taskDetails[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contex) =>
                                      DetailsTask(task: selectedTodo)));
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _taskDetails.forEach((taskDetail) {
      if (taskDetail.name.contains(text)) {
        // print(taskDetail.name);
        _searchResult.add(taskDetail);
      }
    });

    setState(() {});
  }
}
