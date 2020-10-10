import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecell_register/LoginHandler.dart';
import 'package:ecell_register/RegisterTeam.dart';
import 'package:ecell_register/Schema/Contest.dart';
import 'package:flutter/material.dart';

class CurrentContests extends StatefulWidget {
  CurrentContests({Key key}) : super(key: key);

  @override
  _CurrentContestsState createState() => _CurrentContestsState();
}

class _CurrentContestsState extends State<CurrentContests> {
  @override
  Widget build(BuildContext context) {
    // First create a query for only the open contests
    // 'open' or 'close'
    Query contests = FirebaseFirestore.instance
        .collection('contests')
        .where('status', isEqualTo: 'open');

    return FutureBuilder(
      future: contests.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong" + snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              // Required variables from the firebase
              String eventName = document.data()['eventName'];
              int minTeamSize = document.data()['minTeamSize'];
              int maxTeamSize = document.data()['maxTeamSize'];
              List addFields = document.data().containsKey('addFields')
                  ? document.data()['addFields']
                  : [];

              String eventCode = document.id;
              Contest currentContest = new Contest(
                minTeamSize,
                maxTeamSize,
                eventName,
                eventCode,
                addFields,
              );

              return new ListTile(
                title: new Text(eventName),
                subtitle: new Text("Team Size " +
                    minTeamSize.toString() +
                    " - " +
                    maxTeamSize.toString()),
                onTap: () {
                  // Here on Tap, start an new navigation to Register Team
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginHandler(
                        contest: currentContest,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        }

        return Text("loading");
      },
    );
    // return Container(
    //   child: Text('Hello wYes'),
    // );
  }
}
