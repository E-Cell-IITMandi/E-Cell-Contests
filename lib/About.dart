import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Container(
          height: 600.0,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                child: Text(
                  'E-Cell IIT Mandi',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: RaisedButton(
                  child: Text('Privacy Policy'),
                  onPressed: () => _launchURL(
                      'https://ecell.iitmandi.co.in/register/privacy-policy.html'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: RaisedButton(
                  child: Text('Terms And Conditions'),
                  onPressed: () => _launchURL(
                      'https://ecell.iitmandi.co.in/register/terms-conditions.html'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
