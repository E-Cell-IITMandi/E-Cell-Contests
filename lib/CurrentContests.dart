import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecell_register/LoginHandler.dart';
import 'package:ecell_register/RegisterTeam.dart';
import 'package:ecell_register/Schema/Contest.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
          return Container(
            padding: EdgeInsets.only(top: 16.0),
            child: ResponsiveGridList(
              desiredItemWidth: 400,
              minSpacing: 12.0,
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                // Required variables from the firebase
                String eventName = document.data()['eventName'];
                int minTeamSize = document.data()['minTeamSize'];
                int maxTeamSize = document.data()['maxTeamSize'];
                List addFields = document.data().containsKey('addFields')
                    ? document.data()['addFields']
                    : [];

                String eventCode = document.id;
                String posterUrl = document.data().containsKey('posterUrl')
                    ? document.data()['posterUrl']
                    : 'https://d13ezvd6yrslxm.cloudfront.net/wp/wp-content/images/bestposters2016-doctorstrange-shipper-700x1023.jpg';

                Contest currentContest = new Contest(
                  minTeamSize,
                  maxTeamSize,
                  eventName,
                  eventCode,
                  addFields,
                  posterUrl,
                );

                return InkWell(
                  child: eventTile(
                      context, eventName, posterUrl, minTeamSize, maxTeamSize),
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
            ),
          );
        }

        return CircularProgressIndicator();
      },
    );
    // return Container(
    //   child: Text('Hello wYes'),
    // );
  }

  Widget eventTile(BuildContext context, String eventName, String posterUrl,
      int minTeamSize, int maxTeamSize) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            child: Text(
              eventName,
              style: TextStyle(fontSize: 28.0),
            ),
          ),
          Container(
            width: 380.0,
            height: 550.0,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image(
                image: NetworkImage(posterUrl),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Team Size " +
                        minTeamSize.toString() +
                        " - " +
                        maxTeamSize.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
