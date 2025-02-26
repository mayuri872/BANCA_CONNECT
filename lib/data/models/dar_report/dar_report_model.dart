

class RequestDailyAcitivityReport {
  String? username;


  RequestDailyAcitivityReport({
    this.username
  });

  RequestDailyAcitivityReport.fromJson(Map<String, dynamic> json) {
     username= json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName']= username;
    return data;
  }
}



class ResponseDailyActivityReport {
  int? id;
  String? executive;
  String? teamLeader;
  String? authRole;
  String? userName;
  DateTime? dateOfVisit;
  String? startTime;
  String? endTime;
  String? duration;
  String? typeOfActivity;
  String? responceSubTypeOfActivity;
  String? bankName;
  String? branchCode;
  String? bankBranchName;
  String? toWhomMeet;
  String? toWhomMeetNumber;
  String? remarkComments;
  double? premiumCollected;
  String? zone;
  String? email;
  String? location;
  String? agentName;
  String? reportingManager;
  String? vintage;
  String? leadType;
  String? competitionInfo;
  String? proposedProduct;
  String? subCategory;

  ResponseDailyActivityReport({
    this.id,
    this.executive,
    this.teamLeader,
    this.authRole,
    this.userName,
    this.dateOfVisit,
    this.startTime,
    this.endTime,
    this.duration,
    this.typeOfActivity,
    this.responceSubTypeOfActivity,
    this.bankName,
    this.branchCode,
    this.bankBranchName,
    this.toWhomMeet,
    this.toWhomMeetNumber,
    this.remarkComments,
    this.premiumCollected,
    this.zone,
    this.email,
    this.location,
    this.agentName,
    this.reportingManager,
    this.leadType,
    this.vintage,
    this.competitionInfo,
    this.proposedProduct,
    this.subCategory,
  });

  factory ResponseDailyActivityReport.fromJson(Map<String, dynamic> json) {
    return ResponseDailyActivityReport(
      id: json['ID'],
      executive: json['executive'],
      teamLeader: json['team_Leader'],
      authRole: json['auth_role'],
      userName: json['userName'],
      dateOfVisit: DateTime.parse(json['date_Of_Visit']),
      startTime: json['start_Time'],
      endTime: json['end_Time'],
      duration: json['duration'],
      typeOfActivity: json['type_Of_Activity'],
      responceSubTypeOfActivity: json['subTypeOfActivity'],
      bankName: json['bank_Name'],
      branchCode: json['branch_Code'],
      bankBranchName: json['bank_Branch_Name'],
      toWhomMeet: json['to_Whom_Meet'],
      toWhomMeetNumber: json['to_Whom_Meet_Number'],
      remarkComments: json['remark_Comments'],
      premiumCollected: json['premium_Collected'].toDouble(),
      zone: json['zone'],
      email: json['email'],
      location: json['location'],
      agentName: json['agentName'],
      reportingManager: json['reportingManager'],
      leadType: json['leadType'],
      vintage: json['Vintage'],
      competitionInfo: json['competitionInfo'],
      proposedProduct: json['proposedProduct'],
      subCategory: json['subCategoryChanged'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'executive': executive,
      'team_Leader': teamLeader,
      'auth_role': authRole,
      'userName': userName,
      'date_Of_Visit': dateOfVisit!.toIso8601String(),
      'start_Time': startTime,
      'end_Time': endTime,
      'duration': duration,
      'type_Of_Activity': typeOfActivity,
      'subTypeOfActivity': responceSubTypeOfActivity,
      'bank_Name': bankName,
      'branch_Code': branchCode,
      'bank_Branch_Name': bankBranchName,
      'to_Whom_Meet': toWhomMeet,
      'to_Whom_Meet_Number': toWhomMeetNumber,
      'remark_Comments': remarkComments,
      'premium_Collected': premiumCollected,
      'zone': zone,
      'email': email,
      'location': location,
      'agentName': agentName,
      'reportingManager': reportingManager,
      'leadType': leadType,
      'Vintage': vintage,
      'competitionInfo': competitionInfo,
      'proposedProduct': proposedProduct,
      'subCategoryChanged': subCategory,
    };
  }
}

class SubTypeOfActivity {
  String? subTypeOfActivity;
  String? subStartTime;
  String? subEndTime;
  String? subDuration;
  double? premiumCollected;

  SubTypeOfActivity({
     this.subTypeOfActivity,
     this.subStartTime,
     this.subEndTime,
     this.subDuration,
     this.premiumCollected,
  });

  factory SubTypeOfActivity.fromJson(Map<String, dynamic> json) {
    return SubTypeOfActivity(
      subTypeOfActivity: json['subTypeOfActivity'],
      subStartTime: json['subStartTime'],
      subEndTime: json['subEndTime'],
      subDuration: json['subDuration'],
      premiumCollected: json['premium_Collected'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subTypeOfActivity': subTypeOfActivity,
      'subStartTime': subStartTime,
      'subEndTime': subEndTime,
      'subDuration': subDuration,
      'premium_Collected': premiumCollected,
    };
  }
}


