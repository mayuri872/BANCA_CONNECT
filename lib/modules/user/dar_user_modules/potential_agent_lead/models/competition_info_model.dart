class ResponceCompetitionInfo {
  int? id;
  String? clientId;
  String? insurerName;


  ResponceCompetitionInfo({
    this.id,
    this.clientId,
    this.insurerName
  });

  ResponceCompetitionInfo.fromJson(Map<String, dynamic> json) {
     id= json['id'];
     clientId= json['ClientId'];
     insurerName = json['InsurerName'];
  }
  }