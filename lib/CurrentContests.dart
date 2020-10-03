import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CurrentContests extends StatefulWidget {
  CurrentContests({Key key}) : super(key: key);

  @override
  _CurrentContestsState createState() => _CurrentContestsState();
}

class _CurrentContestsState extends State<CurrentContests> {
  @override
  Widget build(BuildContext context) {
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
              return new ListTile(
                title: new Text(document.data()['status']),
                subtitle: new Text(document.data()['eventName']),
                onTap: () {
                  final snackBar = SnackBar(content: Text('Tap'));
                  Scaffold.of(context).showSnackBar(snackBar);
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
