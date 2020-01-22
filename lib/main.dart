import 'package:flutter/material.dart';
import 'package:flutter_sqlite_app/Model/UserDetails.dart';
import 'package:flutter_sqlite_app/databaseModel/DatabaseHelper.dart';

void main() => runApp(ftr_CustomForm());

class ftr_CustomForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  String user_empid = "",
      user_firstname = "",
      user_emailid = "",
      user_designation = "";

  final _formKey = GlobalKey<FormState>();

  var _passKey = GlobalKey<FormFieldState>();

  int _radioValue1;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Employee Id'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your employee id';
                  }
                  return null;
                },
                onChanged: (text) {
                  user_empid = text;
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'First Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your firstname';
                  }
                  return null;
                },
                onChanged: (text) {
                  user_firstname = text;
                },
              ),
              //EMAIL ADDRESS
              TextFormField(
                decoration: InputDecoration(hintText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
                onChanged: (text) {
                  user_emailid = text;
                },
              ),

              //AGE
              TextFormField(
                decoration: InputDecoration(hintText: 'Designation'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your Designation';
                  }
                  return null;
                },
                onChanged: (text) {
                  user_designation = text;
                },
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          addRecords(true);
                        }
                      },
                      child: Text('Add'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        getUser();
                      },
                      child: Text('Retrieve'),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          deleteUser(new UserDetails(user_empid, user_firstname, user_emailid, user_designation));
                        }
                      },
                      child: Text('Delete'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          updateUser(new UserDetails(user_empid, user_firstname, user_emailid, user_designation));
                        }
                      },
                      child: Text('Update'),
                    ),
                  ),

                ],
              )
            ],
          ),
        ));
  }

  Future updateUser( UserDetails userDetails) {
    var db = new DatabaseHelper();
    return db.update(userDetails);
  }
  Future deleteUser( UserDetails userDetails) {
    var db = new DatabaseHelper();
    return db.deleteUsers(userDetails);
  }

  Future<List<UserDetails>> getUser() {
    var db = new DatabaseHelper();
    return db.getDBUser();
  }

  Future addRecords(bool param0) async {
    var db = new DatabaseHelper();
    var user = new UserDetails(
        user_empid, user_firstname, user_emailid, user_designation);
    if (param0) {
      await db.saveUser(user);
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter mail';
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void something(e) {
    setState(() {
      if (e == 0) {
        _radioValue1 = 0;
      } else if (e == 1) {
        _radioValue1 = 1;
      } else {
        return 'Select your gender';
      }
    });
  }
}
