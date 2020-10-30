class Contest {
  int minTeamSize, maxTeamSize;
  String eventName, eventCode, posterUrl;
  List addFields;

  // Take care for this contrustor where you are using it
  Contest(
    this.minTeamSize,
    this.maxTeamSize,
    this.eventName,
    this.eventCode,
    this.addFields,
    this.posterUrl,
  );

  @override
  String toString() {
    return 'minTeamSize: ' +
        minTeamSize.toString() +
        " maxTeamSize" +
        minTeamSize.toString() +
        " eventName:" +
        eventName +
        " eventCode:" +
        eventCode +
        " addField:" +
        addFields.toString() +
        " posterUrl:" +
        posterUrl;
  }
}
