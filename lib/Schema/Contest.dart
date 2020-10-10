class Contest {
  int minTeamSize, maxTeamSize;
  String eventName, eventCode;
  List addFields;

  // Take care for this contrustor where you are using it
  Contest(
    this.minTeamSize,
    this.maxTeamSize,
    this.eventName,
    this.eventCode,
    this.addFields,
  );

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
        eventCode +
        " addField:" +
        addFields.toString();
  }
}
