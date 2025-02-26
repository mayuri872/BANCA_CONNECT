// Request-get DSR details
class RequestgetDsRdetials {
  int? userName;

  RequestgetDsRdetials({this.userName});

  RequestgetDsRdetials.fromJson(Map<String, dynamic> json) {
    userName = json["userName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userName"] = userName;
    return data;
  }
}

// Response-get DSR details
class DSRSubTypeOfActivity {
  String? subTypeOfActivity;
  String? subStartTime;
  String? subEndTime;
  String? subDuration;
  double? premiumCollected;

  DSRSubTypeOfActivity({
    this.subTypeOfActivity,
    this.subStartTime,
    this.subEndTime,
    this.subDuration,
    this.premiumCollected,
  });

  factory DSRSubTypeOfActivity.fromJson(Map<String, dynamic> json) {
    return DSRSubTypeOfActivity(
      subTypeOfActivity: json['subTypeOfActivity'],
      subStartTime: json['subStartTime'],
      subEndTime: json['subEndTime'],
      subDuration: json['subDuration'],
      premiumCollected: double.parse(json['premium_Collected']),
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

class ResponsegetDsRdetials {
  String? id;
  String? executive;
  String? teamLeader;
  String? authRole;
  String? userName;
  DateTime? dateOfVisit;
  String? startTime;
  String? endTime;
  String? duration;
  String? typeOfActivity;
  List<DSRSubTypeOfActivity>? subTypeOfActivity;
  String? bankName;
  String? branchCode;
  String? bankBranchName;
  String? toWhomMeet;
  String? toWhomMeetNumber;
  String? remarkComments;
  String? zone;
  double? premiumCollected;

  ResponsegetDsRdetials({
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
    this.subTypeOfActivity,
    this.bankName,
    this.branchCode,
    this.bankBranchName,
    this.toWhomMeet,
    this.toWhomMeetNumber,
    this.remarkComments,
    this.zone,
    this.premiumCollected,
  });

  factory ResponsegetDsRdetials.fromJson(Map<String, dynamic> json) {
    var subTypeOfActivityFromJson = json['subTypeOfActivity'] as List;
    List<DSRSubTypeOfActivity> subTypeOfActivityList = subTypeOfActivityFromJson.map((i) => DSRSubTypeOfActivity.fromJson(i)).toList();

    return ResponsegetDsRdetials(
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
      subTypeOfActivity: subTypeOfActivityList,
      bankName: json['bank_Name'],
      branchCode: json['branch_Code'],
      bankBranchName: json['bank_Branch_Name'],
      toWhomMeet: json['to_Whom_Meet'],
      toWhomMeetNumber: json['to_Whom_Meet_Number'],
      remarkComments: json['remark_Comments'],
      zone: json['zone'],
      premiumCollected: json['premium_Collected'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> subTypeOfActivityToJson = subTypeOfActivity!.map((i) => i.toJson()).toList();

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
      'subTypeOfActivity': subTypeOfActivityToJson,
      'bank_Name': bankName,
      'branch_Code': branchCode,
      'bank_Branch_Name': bankBranchName,
      'to_Whom_Meet': toWhomMeet,
      'to_Whom_Meet_Number': toWhomMeetNumber,
      'remark_Comments': remarkComments,
      'zone': zone,
      'premium_Collected': premiumCollected,
    };
  }
}