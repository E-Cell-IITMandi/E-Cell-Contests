import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterTeam extends StatefulWidget {
  final int minTeamSize, maxTeamSize;
  final String eventName, eventCode;

  RegisterTeam({
    Key key,
    @required this.minTeamSize,
    @required this.maxTeamSize,
    @required this.eventName,
    @required this.eventCode,
  }) : super(key: key);

  @override
  _RegisterTeamState createState() => _RegisterTeamState();
}

class _RegisterTeamState extends State<RegisterTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(widget.eventCode),
      ),
    );
  }
}
