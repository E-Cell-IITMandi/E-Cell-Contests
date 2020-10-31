import 'dart:html';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:ecell_register/RegisterTeam.dart';
import 'package:ecell_register/Schema/Contest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

// https://medium.com/flutter-community/authenticate-with-a-gmail-account-in-your-flutter-apps-using-firebase-authentication-9cbf95796157

// This will not only work on the web, for android this page has to be somewhat different
////////////////////////////////////////////////////////////

class LoginHandler extends StatefulWidget {
  Contest contest;
  LoginHandler({Key key, @required this.contest}) : super(key: key);

  @override
  _LoginHandlerState createState() => _LoginHandlerState();
}

class _LoginHandlerState extends State<LoginHandler> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;

  final IFrameElement _iframeElement = IFrameElement();
  Widget _iframeWidget;

  @override
  void initState() {
    super.initState();
    initApp();

    _iframeElement.height = '50';
    _iframeElement.width = '50';
    _iframeElement.src = widget.contest.websiteUrl;

    print('Check here' + widget.contest.toString());

    _iframeElement.style.border = 'none';

    String randId = 'ifr' + Random.secure().nextInt(1000).toString();

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      randId,
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: randId,
    );
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);

    // immediately check whether the user is signed in
    // checkIfUserIsSignedIn();
    // onGoogleSignIn(context);
    _checkIfAlreadySignedIn();
  }

  Future _checkIfAlreadySignedIn() async {
    // Making it by default to sign in on it's own

    // onGoogleSignIn(context);

    // User user;
    // // flag to check whether we're signed in already
    // bool isSignedIn = await _googleSignIn.isSignedIn();
    // print("checking for user");

    // setState(() {
    //   isUserSignedIn = isSignedIn;
    // });

    // if (isSignedIn) {
    //   user = _auth.currentUser;
    //   print(user.displayName);
    //   print("User is signed in");
    //   onGoogleSignIn(context);
    // } else {
    //   print("user is not signed in");
    // }
  }

  Future<User> _handleSignIn() async {
    print("Hanlde sign in called");
    // hold the instance of the authenticated user
    User user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    print("here");

    setState(() {
      isUserSignedIn = isSignedIn;
    });

    print("see");
    if (false) {
      // if (false) {
      // if so, return the current user
      print("see here");

      user = _auth.currentUser;
      print(user.displayName);
      print("User is signed in");
    } else {
      print("User is not signed in");

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      print("Reached till here");
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("Auth credential are done");

      user = (await _auth.signInWithCredential(credential)).user;
      bool userSignedIn = await _googleSignIn.isSignedIn();

      print("Till here also");

      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    print("Returning user");
    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    print("gogole sign in called");
    User user = await _handleSignIn();

    // print("Name" + user.displayName);
    // print("HEre" + user.photoURL);

    var userSignedIn = Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterTeam(
          contest: widget.contest,
          user: user,
          googleSignIn: _googleSignIn,
          auth: _auth,
        ),
      ),
    );

    print("userSignedIn" + userSignedIn.toString());

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In to Google"),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: _buildBody(),
          // child: _est(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(child: _iframeWidget),
        Container(
          decoration: new BoxDecoration(
            color: Colors.black12,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 32.0,
            horizontal: 16.0,
          ),
          child: _registerButton(),
        ),
      ],
    );
  }

  FlatButton _registerButton() {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: () {
        onGoogleSignIn(context);
      },
      color: Colors.blueAccent,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.account_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "Register for the Event",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _est() {
    return SizedBox(
      height: 200.0,
      child: _iframeWidget,
    );
  }
}

class WelcomeUserWidget extends StatelessWidget {
  GoogleSignIn _googleSignIn;
  User _user;
  FirebaseAuth _auth;

  WelcomeUserWidget(User user, GoogleSignIn signIn, FirebaseAuth _auth) {
    _user = user;
    _googleSignIn = signIn;
    this._auth = _auth;

    print("Auth got" + _auth.toString());
    print(_auth.currentUser);
  }

  @override
  Widget build(BuildContext context) {
    print("What we have right now" + _auth.currentUser.toString());

    return Container(
      child: Column(
        children: [
          ClipOval(
              child: Image.network(_user.photoURL,
                  width: 100, height: 100, fit: BoxFit.cover)),
          Text(
            _user.displayName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onPressed: () {
              _googleSignIn.signOut();
              _auth.signOut();
              Navigator.pop(context);
            },
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
