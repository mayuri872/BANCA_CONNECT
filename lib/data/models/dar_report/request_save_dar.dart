class RequestSaveDar {
  String? executive;
  String? teamLeader;
  int? authRole;
  int? userName;
  String? zone;
  DateTime? dateOfVisit;
  String? startTime;
  String? endTime;
  String? duration;
  String? typeOfActivity;
  String? subTypeOfActivity;
  //List<ResponceSubTypeOfAct>? subTypeOfAc;
  List<Map<String, dynamic>>? responceSubTypeOfActivity;
  String? email;
  String? meetLocation;
  String? agentName;
  String? toWhomMeet;
  String? toWhomMeetNumber;
  String? remarkComments;
  String? competitioninfo;
  String? activityType;
  String? leadStatus;
  int? premiumCollected;
  String? agentDetail;
  String? typeOfLead;
  String? stageOfLead;
  String? stageOfIMDLead;
  String? stageTypes;
  String? imdCode;
  String? leadType;
  String? subCategoryChanged;
  String? accompanied;

  RequestSaveDar({
    this.executive,
    this.teamLeader,
    this.authRole,
    this.userName,
    this.zone,
    this.dateOfVisit,
    this.startTime,
    this.endTime,
    this.duration,
    this.typeOfActivity,
    this.subTypeOfActivity,
    this.responceSubTypeOfActivity,
    this.email,
    this.meetLocation,
    this.agentName,
    this.toWhomMeet,
    this.toWhomMeetNumber,
    this.remarkComments,
    this.competitioninfo,
    this.activityType,
    this.leadStatus,
    this.premiumCollected,
    this.agentDetail,
    this.typeOfLead,
    this.stageOfLead,
    this.stageOfIMDLead,
    this.stageTypes,
    this.imdCode,
    this.leadType,
    this.subCategoryChanged,
    this.accompanied
  });

  factory RequestSaveDar.fromJson(Map<String, dynamic> json) {
    return RequestSaveDar(
      executive: json['executive'],
      teamLeader: json['team_Leader'],
      authRole: json['auth_role'],
      userName: json['userName'],
      zone: json['zone'],
      dateOfVisit: DateTime.parse(json['date_Of_Visit']),
      startTime: json['start_Time'],
      endTime: json['end_Time'],
      duration: json['duration'],
      typeOfActivity: json['type_Of_Activity'],
      subTypeOfActivity: json['subtypeOfActivity'],
      // subTypeOfActivity: (json['subTypeOfActivity'] as List)
      //     .map((i) => SubTypeOfActivity.fromJson(i))
      //     .toList(),
      email: json['email'],
      meetLocation: json['meet_Location'],
      agentName: json['agentName'],
      toWhomMeet: json['to_Whom_Meet'],
      toWhomMeetNumber: json['to_Whom_Meet_Number'],
      remarkComments: json['remark_Comments'],
      competitioninfo: json['competitionInfo'],
      activityType: json['ActivityType'],
      leadStatus: json['leadStatus'],
      premiumCollected: json['premium_Collected'],
      agentDetail: json['agentDetail'],
      typeOfLead: json['typeOfLead'],
      stageOfLead: json['stageOfLead'],
      stageOfIMDLead: json['stageOfIMDLead'],
      stageTypes: json['stageTypes'],
      imdCode: json['imdCode'],
      leadType: json['leadType'],
      subCategoryChanged: json['subCategoryChanged'],
      accompanied:  json['Accompanied'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'executive': executive,
      'team_Leader': teamLeader,
      'auth_role': authRole,
      'userName': userName,
      'zone': zone,
      'date_Of_Visit': dateOfVisit?.toIso8601String(),
      'start_Time': startTime,
      'end_Time': endTime,
      'duration': duration,
      'type_Of_Activity': typeOfActivity,
      'subtypeOfActivity' : subTypeOfActivity,
     /// 'subTypeOfActivity': subTypeOfAc?.map((i) => i.toJson()).toList() ?? [],
      'subTypeOfActivity': responceSubTypeOfActivity,
      'email': email,
      'meet_Location': meetLocation,
      'agentName': agentName,
      'to_Whom_Meet': toWhomMeet,
      'to_Whom_Meet_Number': toWhomMeetNumber,
      'remark_Comments': remarkComments,
      'competitionInfo': competitioninfo,
      'ActivityType': activityType,
      'leadStatus': leadStatus,
      'premium_Collected': premiumCollected,
      'agentDetail': agentDetail,
      'typeOfLead': typeOfLead,
      'stageOfLead': stageOfLead,
      'stageOfIMDLead': stageOfIMDLead,
      'stageTypes': stageTypes,
      'imdCode': imdCode,
      'leadType': leadType,
      'subCategoryChanged' : subCategoryChanged,
      'Accompanied' : accompanied
    };
  }
}
// class RequestSaveDar {
//   String? executive;
//   String? teamLeader;
//   int? authRole;
//   int? userName;
//   String? zone;
//   DateTime? dateOfVisit;
//   String? startTime;
//   String? endTime;
//   String? duration;
//   String? typeOfActivity;
//   List<SubTypeOfActivity>? subTypeOfActivity;
//   String? email;
//   String? meetLocation;
//   String? agentName;
//   String? toWhomMeet;
//   String? toWhomMeetNumber;
//   String? remarkComments;
//   String? competitioninfo;
//   String? activityType;
//   String? leadStatus;

//   RequestSaveDar({
//      this.executive,
//      this.teamLeader,
//      this.authRole,
//      this.userName,
//      this.zone,
//      this.dateOfVisit,
//      this.startTime,
//      this.endTime,
//      this.duration,
//      this.typeOfActivity,
//      this.subTypeOfActivity,
//      this.email,
//      this.meetLocation,
//      this.agentName,
//      this.toWhomMeet,
//      this.toWhomMeetNumber,
//      this.remarkComments,
//      this.competitioninfo,
//      this.activityType,
//      this.leadStatus
//   });
//   factory RequestSaveDar.fromJson(Map<String, dynamic> json) {
//     return RequestSaveDar(
//       executive: json['executive'],
//       teamLeader: json['team_Leader'],
//       authRole: json['auth_role'],
//       userName: json['userName'],
//       zone: json['zone'],
//       dateOfVisit: DateTime.parse(json['date_Of_Visit']),
//       startTime: json['start_Time'],
//       endTime: json['end_Time'],
//       duration: json['duration'],
//       typeOfActivity: json['type_Of_Activity'],
//       subTypeOfActivity: (json['subTypeOfActivity'] as List)
//           .map((i) => SubTypeOfActivity.fromJson(i))
//           .toList(),
//       email: json['email'],
//       meetLocation: json['meet_Location'],
//       agentName: json['agentName'],
//       toWhomMeet: json['to_Whom_Meet'],
//       toWhomMeetNumber: json['to_Whom_Meet_Number'],
//       remarkComments: json['remark_Comments'],
//       competitioninfo:  json['competitionInfo'],
//       activityType:  json['ActivityType'],
//       leadStatus:  json['leadStatus']
//     );
//   }

//   Map<String, dynamic> toJson() {
//   return {
//     'executive': executive,
//     'team_Leader': teamLeader,
//     'auth_role': authRole,
//     'userName': userName,
//     'zone': zone,
//     'date_Of_Visit': dateOfVisit?.toIso8601String(),
//     'start_Time': startTime,
//     'end_Time': endTime,
//     'duration': duration,
//     'type_Of_Activity': typeOfActivity,
//     'subTypeOfActivity': subTypeOfActivity?.map((i) => i.toJson()).toList() ?? [],
//     'email': email,
//     'meet_Location': meetLocation,
//     'agentName': agentName,
//     'to_Whom_Meet': toWhomMeet,
//     'to_Whom_Meet_Number': toWhomMeetNumber,
//     'remark_Comments': remarkComments,
//     'competitionInfo':competitioninfo,
//     'ActivityType' :activityType,
//     'leadStatus': leadStatus
//   };
// }
// }



class ResponceSubTypeOfAct {
  String? subTypeOfActivity;
  String? subStartTime;
  String? subEndTime;
  String? subDuration;
  int? premiumCollected;

  ResponceSubTypeOfAct({
    this.subTypeOfActivity,
    this.subStartTime,
    this.subEndTime,
    this.subDuration,
    this.premiumCollected,
  });

  factory ResponceSubTypeOfAct.fromJson(Map<String, dynamic> json) {
    return ResponceSubTypeOfAct(
      subTypeOfActivity: json['subTypeOfActivity'],
      subStartTime: json['subStartTime'],
      subEndTime: json['subEndTime'],
      subDuration: json['subDuration'],
      premiumCollected: json['premium_Collected'],
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
