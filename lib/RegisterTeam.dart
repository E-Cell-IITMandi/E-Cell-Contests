import 'package:ecell_register/Schema/Contest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterTeam extends StatefulWidget {
  Contest contest;
  GoogleSignIn googleSignIn;
  User user;
  FirebaseAuth auth;

  RegisterTeam({
    Key key,
    @required this.contest,
    @required this.googleSignIn,
    @required this.user,
    @required this.auth,
  }) : super(key: key);

  @override
  _RegisterTeamState createState() => _RegisterTeamState();
}

class _RegisterTeamState extends State<RegisterTeam> {
  final _formKey = GlobalKey<FormState>();

  _setDataInFirestore() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contest.eventName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Regsiter for ' + widget.contest.eventName,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            print("JHello");
                            // Scaffold.of(context)
                            //     .showSnackBar(SnackBar(content: Text('Hello')));
                            // Scaffold.of(context).showSnackBar(
                            //     SnackBar(content: Text('Processing Data')));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
