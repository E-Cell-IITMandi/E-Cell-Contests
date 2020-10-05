class Team {
  String teamName, teamEmail, teamPhone, uid;
  List membersName, membersRoll; // This should be array actually to be precise

  Team(this.teamName, this.teamEmail, this.teamPhone, this.membersName,
      this.membersRoll, this.uid);

  @override
  String toString() {
    // TODO: implement toString
    return 'teamName: ' +
        teamName +
        " teamEmail:" +
        teamEmail +
        " teamPhone:" +
        teamPhone +
        " membersName:" +
        membersName.toString() +
        " membersRoll:" +
        membersRoll.toString() +
        " uid:" +
        uid;
  }

  /// Here pass the database object got from the firebase to create an object
  /// It does the prvious checks and do the work accordingly
  /// Regarding [email] and [uid] they should be taken from the firebase auth
  Team.fromFirebase(
      Map<String, dynamic> fireTeam, String email, String userId) {
    // Here do any thing needed as cleaning, etc

    teamName = '';
    teamPhone = '';
    membersName = [];
    membersRoll = [];
    teamEmail = email;
    uid = userId;

    if (fireTeam.containsKey('teamName')) {
      teamName = fireTeam['teamName'];
    }

    if (fireTeam.containsKey('teamPhone')) {
      teamPhone = fireTeam['teamPhone'];
    }

    if (fireTeam.containsKey('membersName')) {
      membersName = fireTeam['membersName'];
    }

    if (fireTeam.containsKey('membersRoll')) {
      membersRoll = fireTeam['membersRoll'];
    }
  }
}
