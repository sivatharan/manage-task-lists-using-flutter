import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'TaskScreen.dart';
import 'models/task.dart';

class DetailsTask extends StatefulWidget {
  final Task task;
  DetailsTask({Key key, this.task}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailsTaskState();
  }
}

class _DetailsTaskState extends State<DetailsTask> {
  Task task = new Task();
  @override
  Widget build(BuildContext context) {
    setState(() {
      this.task = widget.task;
      // print(widget.task);
    });

    final TextField _txtTaskName = new TextField(
      decoration: InputDecoration(
          hintText: "Enter task name",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
      // autocorrect: false,
      // controller: TextEditingController(text: this.todo.name),
      controller: TextEditingController.fromValue(new TextEditingValue(
          text: this.task.name,
          selection:
              new TextSelection.collapsed(offset: this.task.name.length))),
      textAlign: TextAlign.left,
      onChanged: (text) {
        setState(() {
          this.task.name = text;
          this.task.priority = this.task.priority;
          // print(this.task.priority);
        });
      },
    );
    final TextField _txtDescription = new TextField(
      decoration: InputDecoration(
          hintText: "Enter task description",
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black))),
      // autocorrect: false,
      // controller: TextEditingController(text: this.todo.description),
      controller: TextEditingController.fromValue(new TextEditingValue(
          text: this.task.description,
          selection: new TextSelection.collapsed(
              offset: this.task.description.length))),

      textAlign: TextAlign.left,
      onChanged: (text) {
        setState(() {
          this.task.description = text;
        });
      },
    );
    // Start dropdown section
    List<String> priority = ["Low", "Mediam", "Hight"];
    final DropdownButton _dropdownPriority = DropdownButton<String>(
      value: this.task.priority,
       style: new TextStyle(
        color: Colors.black,
        fontSize: 15.0
      ),
      items: priority.map((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value,style: TextStyle(),),
        );
      }).toList(),
      onChanged: (String newVal) {
        // print(newVal);
        setState(() {
          this.task.priority = newVal;
          
        });
        
      },
    );
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    final _dueDate = FlatButton(
                onPressed: () {
                  // var date = this.task.due_date ==null?DateTime(2018, 12, 31).toString():this.task.due_date;
                 
                  DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {
                    // print('change $date');
                    this.task.due_date = date.toString();
                    // print('--------------- $this.task.due_date');
                  }, onConfirm: (date) {
                    // print('confirm $date');
                    // print(this.task.due_date);
                    setState(() {
                      this.task.due_date = date.toString();
                    });
                                
                  }, currentTime: DateTime.now());
                },
                child: Text((this.task.due_date ==null?DateTime(2018, 12, 22).toString():this.task.due_date).substring(0,10),
                  // this.task.due_date,
                  // DateTime(int.parse(this.task.due_date.substring(0, 4)),int.parse(this.task.due_date.substring(6, 8)),int.parse(this.task.due_date.substring(10, 12))).toString(),
                  style: TextStyle(color: Colors.blue),
                ));

    final _btnSave = RaisedButton(
        child: Text("Save"),
        color: Theme.of(context).accentColor,
        elevation: 4.0,
        onPressed: () async {
          Map<String, dynamic> params = Map<String, dynamic>();
            params["name"] = this.task.name;
            params["description"] = this.task.description;
            params["priority"] = this.task.priority;
            params["due_date"] = this.task.due_date;
            
          if (this.task.id == null) {
            await addTodo(http.Client(), params);
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskList()),
            );
          } else {
            params["id"] = this.task.id.toString();
            // print(params);
            await updateATodo(http.Client(), params).then((Task res) {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskList()),
              );
            });
            //
          }
        });
    final _btnDelete = RaisedButton(
      child: Text("Delete"),
      color: Colors.redAccent,
      elevation: 4.0,
      onPressed: this.task.id == null
          ? null
          : () async {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Confirmation"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text("Are you sure you want to delete this ?")
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text('Yes'),
                          onPressed: () async {
                            await deleteATodo(http.Client(), this.task.id);
                            await Navigator.pop(context); //Quit Dialog
                            // Navigator.pop(context); //Quit to previous screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskList()),
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
    );
    final _column = Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _txtTaskName,
            new Padding(
              padding: EdgeInsets.all(8),
            ),
            _txtDescription,
            new Padding(
              padding: EdgeInsets.all(8),
            ),
             Row(
              children: <Widget>[
                Expanded(child: Text("Priority",style: TextStyle(fontSize: 16.0)),),
                new Padding(
                  padding: EdgeInsets.all(8),
                ),
                Expanded(child: Text("Due Date",textAlign: TextAlign.center,style: TextStyle(fontSize: 16.0))),
              ],
            ),Row(
              children: <Widget>[
                Expanded(child: _dropdownPriority,),
                new Padding(
                  padding: EdgeInsets.all(8),
                ),
                Expanded(child: _dueDate),
              ],
            ),
           
            
            Row(
              children: <Widget>[
                Expanded(child: _btnSave),
                new Padding(
                  padding: EdgeInsets.all(8),
                ),
                Expanded(child: _btnDelete),
              ],
            )
          ],
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Task Details"),
        ),
        body: Column(
          children: <Widget>[_column],
        ));
  }
}
