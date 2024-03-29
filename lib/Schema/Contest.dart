class Contest {
  int minTeamSize, maxTeamSize;
  String eventName, eventCode, posterUrl, websiteUrl;
  List addFields;

  // Take care for this contrustor where you are using it
  Contest(
    this.minTeamSize,
    this.maxTeamSize,
    this.eventName,
    this.eventCode,
    this.addFields,
    this.posterUrl,
    this.websiteUrl,
  );

  /// Pass the firebase document you got
  Contest.fromFirebase(document) {
    eventName = document.data()['eventName'];
    minTeamSize = document.data()['minTeamSize'];
    maxTeamSize = document.data()['maxTeamSize'];
    addFields = document.data().containsKey('addFields')
        ? document.data()['addFields']
        : [];

    eventCode = document.id;
    posterUrl = document.data().containsKey('posterUrl')
        ? document.data()['posterUrl']
        : 'https://d13ezvd6yrslxm.cloudfront.net/wp/wp-content/images/bestposters2016-doctorstrange-shipper-700x1023.jpg';

    websiteUrl = document.data().containsKey('websiteUrl')
        ? document.data()['websiteUrl']
        : 'https://pnotes.web.app/share?id=-MA1SNDqZrQipZyEG66W';
  }

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
        posterUrl +
        " websiteUrl:" +
        websiteUrl;
  }
}
