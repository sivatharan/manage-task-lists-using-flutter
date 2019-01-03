import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TaskScreen.dart';
import 'models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'models/user.dart';
import 'models/response.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  // final prefs = SharedPreferences.getInstance();

  void login() {
    if (validateAndSave()) {
      userLogin(http.Client(), _username, _password).then((dynamic res) {
        Response response = new Response.fromJson(res);
        if (response.status) {
          User user = new User.fromJson(response.result);
          //TODO
          //  prefs.setInt('id', user.id);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskList()),
          );
        } else {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Error!')),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(response.result,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Ok'),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        }
      });
    }
  }

  void register() {
    if (validateAndSave()) {
      add(http.Client(), _username, _password).then((dynamic res) {
        Response response = new Response.fromJson(res);
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Message"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(response.result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                             color:(!response.status?Colors.red:Colors.black) ,
                          ))
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('Ok'),
                    onPressed: () async {
                      Navigator.pop(context);
                      
                      (!response.status?moveToRegister():moveToLogin());
                      
                    },
                  ),
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task App'),
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: BuildInput() + BuildSubmitButton(),
              ),
            )));
  }

  final _welcome = Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Text(
          "Well Come",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ]));

  List<Widget> BuildInput() {
    return [
      _welcome,
      //   new Center(

      //   child: new Image.asset('images/jigsaw_peoplesmll.jpg'),
      // ),
      TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.person), labelText: 'User Name'),
        validator: (value) =>
            value.isEmpty ? 'user Name can\'t be empty' : null,
        onSaved: (value) => _username = value,
      ),
      TextFormField(
        decoration:
            InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      )
    ];
  }

  List<Widget> BuildSubmitButton() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: login,
          color: Colors.indigo,
        ),
        FlatButton(
          child: Text(
            'Create an Account',
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            'Create an Account',
            style: TextStyle(fontSize: 20.0),
          ),
          onPressed: register,
          color: Colors.indigo,
        ),
        FlatButton(
          child: Text(
            'Have an Account? Login',
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
