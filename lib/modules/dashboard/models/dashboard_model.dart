// To parse this JSON data, do
//
//     final branchMasterModel = branchMasterModelFromJson(jsonString);

import 'dart:convert';

class DashboardModel {
  String? branchCode;
  String? branchName;
  String? latitude;
  String? longitude;
  String? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? updatedDate;

  DashboardModel({
    required this.branchCode,
    required this.branchName,
    required this.latitude,
    required this.longitude,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      DashboardModel(
        branchCode: json["branchCode"],
        branchName: json["branchName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] != null
            ? DateTime.parse(json["createdDate"])
            : null,
        updatedBy: json["updatedBy"],
        updatedDate: json["updatedDate"] != null
            ? DateTime.parse(json["updatedDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "branchCode": branchCode,
        "branchName": branchName,
        "latitude": latitude,
        "longitude": longitude,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedDate": updatedDate?.toIso8601String(),
      };
}

List<DashboardModel> branchData = [
  DashboardModel(
    branchCode: "branchCode",
    branchName: "branchName",
    latitude: "latitude",
    longitude: "longitude",
    createdBy: "createdBy",
    createdDate: DateTime.parse("createdDate"),
    updatedBy: "updatedBy",
    updatedDate: DateTime.parse("updatedDate"),
  )
];

/////////////////////    Response Message Model    //////////////////////

BranchMasterResponseMessage branchMasterResponseMessageFromJson(String str) =>
    BranchMasterResponseMessage.fromJson(json.decode(str));

String branchMasterResponseMessageToJson(BranchMasterResponseMessage data) =>
    json.encode(data.toJson());

class BranchMasterResponseMessage {
  bool success;
  String message;
  Payload payload;
  dynamic error;

  BranchMasterResponseMessage({
    required this.success,
    required this.message,
    required this.payload,
    required this.error,
  });

  factory BranchMasterResponseMessage.fromJson(Map<String, dynamic> json) =>
      BranchMasterResponseMessage(
        success: json["success"],
        message: json["message"],
        payload: Payload.fromJson(json["payload"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "payload": payload.toJson(),
        "error": error,
      };
}

class Payload {
  String branchCode;
  String branchName;
  String latitude;
  String longitude;
  String? createdBy;
  DateTime? createdDate;
  String? updatedBy;
  DateTime? updatedDate;

  Payload({
    required this.branchCode,
    required this.branchName,
    required this.latitude,
    required this.longitude,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        branchCode: json["branchCode"],
        branchName: json["branchName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] != null
            ? DateTime.parse(json["createdDate"])
            : null,
        updatedBy: json["updatedBy"],
        updatedDate: json["updatedDate"] != null
            ? DateTime.parse(json["updatedDate"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "branchCode": branchCode,
        "branchName": branchName,
        "latitude": latitude,
        "longitude": longitude,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "updatedBy": updatedBy,
        "updatedDate": updatedDate?.toIso8601String(),
      };
}
