// class RequestZoneModel {
//   String? username;


//   RequestZoneModel({
//     this.username
//   });

//   RequestZoneModel.fromJson(Map<String, dynamic> json) {
//      username= json['userName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['userName']= username;
//     return data;
//   }
// }

// class RequestZoneManagerfiltersModel {
//   List<String>? zones;
//   List<String>? managers;


//   RequestZoneManagerfiltersModel({
//     this.zones,
//     this.managers
//   });

//   RequestZoneManagerfiltersModel.fromJson(Map<String, dynamic> json)  {
//      zones = json['zone'] != null ? List<String>.from(json['zone']) : null;
//      managers = json['manager'] != null ? List<String>.from(json['manager']) : null;
//   }

//    Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (zones != null) {
//       data['zone'] = zones;
//     }
//     if (managers != null) {
//       data['manager'] = managers;
//     }
//     return data;
//   }
// }

// class RequestFilterDataModel {
//   String? userid;
//   List<String>? zones;
//   List<String>? activity;
//   String? startDate;
//   String? endDate;


//   RequestFilterDataModel({
//     this.userid,
//     this.zones,
//     this.activity,
//     this.startDate,
//     this.endDate
//   });

//   RequestFilterDataModel.fromJson(Map<String, dynamic> json)  {
//     userid = json['userId'];
//      zones = json['zone'] != null ? List<String>.from(json['zone']) : null;
//      activity = json['activity'] != null ? List<String>.from(json['activity']) : null;
//      startDate = json['startDate'];
//      endDate = json['endDate'];
//   }

//    Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (userid != null) {
//       data['userId'] = userid;
//     }
//     if (zones != null) {
//       data['zone'] = zones;
//     }
//     if (activity != null) {
//       data['activity'] = activity;
//     }
//     if (startDate != null) {
//       data['startDate'] = startDate;
//     }
//     if (endDate != null) {
//       data['endDate'] = endDate;
//     }
//     return data;
//   }
// }

// class ResponseZoneModel {
//   final String? zone;

//   ResponseZoneModel({
//        this.zone,
//   });

//   factory ResponseZoneModel.fromJson(Map<String, dynamic> json) {
//     return ResponseZoneModel(
//       zone: json['zone'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'zone': zone,
//     };
//   }
// }