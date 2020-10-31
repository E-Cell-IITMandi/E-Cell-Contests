import 'package:ecell_register/About.dart';
import 'package:ecell_register/CurrentContests.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecell Register',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: ThemeData.dark(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text('Helo' + snapshot.error.toString());
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyHomePage(
              title: 'E-Cell Contests',
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Text('data');
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: PopupMenuButton(
                onSelected: (value) {
                  if (value == 0) {
                    print('About Us Screen');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => About(),
                      ),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 0,
                      child: _menuItem(context),
                    )
                  ];
                },
              )),
        ],
      ),
      body: Center(
        child: CurrentContests(),
        // child: LoginHandler(),
      ),
    );
  }

  Widget _menuItem(BuildContext context, {icon = Icons.info, text: "About"}) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(icon),
        ),
        Container(
          child: Text(text),
        )
      ],
    );
  }
}

// class App extends StatelessWidget {
//   // Create the initialization Future outside of `build`:
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Ecell Register',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: FutureBuilder(
//         // Initialize FlutterFire:
//         future: Firebase.initializeApp(),
//         builder: (context, snapshot) {
//           // Check for errors
//           // if (snapshot.hasError) {
//           //   return Text(snapshot.error.toString());
//           // }

//           // Once complete, show your application
//           if (snapshot.connectionState == ConnectionState.done) {
//             return MyHomePage(
//               title: 'Hello World',
//             );
//           }

//           // Otherwise, show something whilst waiting for initialization to complete
//           // return Text('loading');
//         },
//       ),
//     );
//   }
// }
