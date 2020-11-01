import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecell_register/LoginHandler.dart';
import 'package:ecell_register/Schema/Contest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailScreen extends StatefulWidget {
  String cid;

  DetailScreen({Key key, @required this.cid}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // First check for the if the contest is open and available or not

    var docQuery =
        FirebaseFirestore.instance.collection('contests').doc(widget.cid);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: docQuery.get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong" + snapshot.error.toString());
            }

            if (snapshot.connectionState == ConnectionState.done) {
              var document = snapshot.data;

              if (document.exists) {
                if (document['status'] == 'open') {
                  Contest contest = new Contest.fromFirebase(document);

                  return LoginHandler(contest: contest);
                } else {
                  return Text('Contest Has Ended!');
                }
              } else {
                return Text('No such contest!');
              }
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
