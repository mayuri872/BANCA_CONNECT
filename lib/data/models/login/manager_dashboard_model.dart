class RequestManagerDashModel {
  String? username;


  RequestManagerDashModel({
    this.username
  });

  RequestManagerDashModel.fromJson(Map<String, dynamic> json) {
     username= json['userName'];
  }
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName']= username;
    return data;
  }
}
class ResponseManagerDashModel {
  final double? id;
  final String? name;
  final int? count;
  final double? sum;
  int? flag; // Make flag mutable
  final String? typeOfActivity;
  final int? lastMonthCount;

  ResponseManagerDashModel({
    this.id,
    this.name,
    this.count,
    this.sum,
    this.flag,
    this.lastMonthCount,
    this.typeOfActivity,
  });

  factory ResponseManagerDashModel.fromJson(Map<String, dynamic> json) {
    return ResponseManagerDashModel(
      id: json['id'],
      name: json['name'],
      count: json['Count'],
      sum: json['sum'],
      flag: json['flag'],
      lastMonthCount: json['count'],
      typeOfActivity: json['type_Of_Activity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'name': name,
      'Count': count,
      'sum': sum,
      'flag': flag,
      'type_Of_Activity': typeOfActivity,
      'count': lastMonthCount,
    };
  }
}

class ResponseLastMonthDetails {
  String? typeOfActivity;
  int? lastMonthCount;

  ResponseLastMonthDetails({this.typeOfActivity, this.lastMonthCount});

  factory ResponseLastMonthDetails.fromJson(Map<String, dynamic> json) {
    return ResponseLastMonthDetails(
      typeOfActivity: json['type_Of_Activity'],
      lastMonthCount: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_Of_Activity': typeOfActivity,
      'count': lastMonthCount,
    };
  }
}

class ResponceYesterdayDetails {

  final String? typeOfActivity;
  final int? yestedayCount;

  ResponceYesterdayDetails({
     this.typeOfActivity,
     this.yestedayCount
  });

  factory ResponceYesterdayDetails.fromJson(Map<String, dynamic> json) {
    return ResponceYesterdayDetails(
      typeOfActivity:  json['type_Of_Activity'],
      yestedayCount:  json['count']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type_Of_Activity' : typeOfActivity,
      'count' : yestedayCount
    };
  }
  
}
class CombinedDetails {
  final String item;
  final String zero;
  final String count;

  CombinedDetails(this.item, this.zero, this.count);
}