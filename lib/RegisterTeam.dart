import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecell_register/Schema/Contest.dart';
import 'package:ecell_register/Schema/Team.dart';
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

  CollectionReference _registrationsRef;
  DocumentReference _docRef;
  Team _team;

  String _teamName = "";
  String _teamPhone = "";
  List _membersName = [];

  TextEditingController _controllerTeamName = TextEditingController();
  TextEditingController _controllerTeamPhone = TextEditingController();
  List<TextEditingController> _controllerMembersName;
  List<TextEditingController> _controllerMemberRoll;

  @override
  void initState() {
    super.initState();

    _registrationsRef = FirebaseFirestore.instance
        .collection('contests')
        .doc(widget.contest.eventCode)
        .collection('registrations');
    _docRef = _registrationsRef.doc(widget.auth.currentUser.uid);

    // Initialising dynamic controllers
    _controllerMembersName = List<TextEditingController>.generate(
      widget.contest.maxTeamSize,
      (index) => TextEditingController(),
    );

    _controllerMemberRoll = List<TextEditingController>.generate(
      widget.contest.maxTeamSize,
      (index) => TextEditingController(),
    );

    print("COMTRolerrs initalised" + _controllerMembersName.toString());
    // _docRef = _registrationsRef.doc('uid');
  }

  @override
  void dispose() {
    _controllerTeamName.dispose();
    _controllerTeamPhone.dispose();
    super.dispose();
  }

  _handleFormSubmit(String teamName, String teamPhone, List<String> membersName,
      List<String> membersRoll) {
    // TODO
    // check for the values, use the default reference and show a dailog

    _showMyDialog(
        'In Progress', 'Please Wait', 'Your submission is neing added');

    print("Final submit here -- Check here");
    print(teamName + teamPhone);

    _docRef
        .set({
          "teamName": teamName,
          "teamPhone": teamPhone,
          "membersName": membersName,
          "membersRoll": membersRoll
        })
        .then((value) => {Navigator.of(context).pop()})
        .then(
          (value) => _showMyDialog(
              'Successfully Registered',
              'All the Best for the Event.',
              "You can still make some changes until the portal get's closed."),
        )
        .catchError(
          (err) => _showMyDialog(
            'Failed',
            'Please report to E-Cell!',
            err.toString(),
          ),
        );
  }

  Future<void> _showMyDialog(String heading, String text1, String text2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(text1),
                ),
                Text(text2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contest.eventName),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: () {
                widget.googleSignIn.signOut();
                widget.auth.signOut();
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Register for ' + widget.contest.eventName,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _docRef.snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    // To check if the data exists or not
                    if (snapshot.data.exists) {
                      print("data finally got " + snapshot.data.id);

                      Map<String, dynamic> recentData = snapshot.data.data();

                      _team = Team.fromFirebase(
                        recentData,
                        widget.auth.currentUser.email,
                        widget.auth.currentUser.uid,
                      );

                      print(_team.toString());
                    } else {
                      print("snaphot has no data so no null data exception");
                    }
                    return registerForm();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Form registerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          myFormField("Enter Team Name", _controllerTeamName),
          myFormField("Enter Phone number", _controllerTeamPhone),
          dynamicInputs(),
          Container(
            padding: EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  print("Handle form submit");
                  print("Check team name" + _controllerTeamName.text);
                  print("Check team phone" + _controllerTeamPhone.text);

                  List<String> membersRoll = [];
                  List<String> membersName = [];

                  for (int i = 0; i < widget.contest.maxTeamSize; i++) {
                    if (!((_controllerMembersName[i].text.isEmpty) ||
                        (_controllerMemberRoll[i].text.isEmpty))) {
                      membersName.add(_controllerMembersName[i].text);
                      membersRoll.add(_controllerMemberRoll[i].text);
                    }
                  }

                  print("Check here");
                  print(membersRoll.toString());
                  print(membersName.toString());

                  _handleFormSubmit(
                    _controllerTeamName.text,
                    _controllerTeamPhone.text,
                    membersName,
                    membersRoll,
                  );
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Widget dynamicInputs() {
    List<Widget> list = new List();

    // print("Max team size" + widget.contest.maxTeamSize.toString());
    // print("Min team size" + widget.contest.minTeamSize.toString());
    int minTeamSize = widget.contest.minTeamSize;

    for (int i = 0; i < widget.contest.maxTeamSize; i++) {
      list.add(
        myFormField(
          "Member " + (i + 1).toString() + " Name",
          _controllerMembersName[i],
          i < minTeamSize ? false : true,
          // i < minTeamSize ? true : true,
        ),
      );
      list.add(
        myFormField(
          "Member " + (i + 1).toString() + " Roll Number",
          _controllerMemberRoll[i],
          i < minTeamSize ? false : true,
          // i < minTeamSize ? true : true,
        ),
      );
    }

    return Column(children: list);
  }

  Widget myFormField(String hint, TextEditingController controller,
      [bool isEmptyAllowed = false]) {
    var validator = (String value) {
      return value.isEmpty ? 'This is required!' : null;
    };

    if (isEmptyAllowed) {
      validator = null;
    }

    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          print("hello the data is now: " + value);
        },
        decoration: InputDecoration(
          hintText: hint,
          counterText: "",
        ),
        validator: validator,
      ),
    );
  }
}
