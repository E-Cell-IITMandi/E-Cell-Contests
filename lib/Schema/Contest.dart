class Contest {
  int minTeamSize, maxTeamSize;
  String eventName, eventCode;

  Contest(this.minTeamSize, this.maxTeamSize, this.eventName, this.eventCode);

  @override
  String toString() {
    // TODO: implement toString
    return 'minTeamSize: ' +
        minTeamSize.toString() +
        " maxTeamSize" +
        minTeamSize.toString() +
        " eventName:" +
        eventName +
        " eventCode:" +
        eventCode;
  }
}
