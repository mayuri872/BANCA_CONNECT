// // class RequestManagerModel {
// //   String? username;


// //   RequestManagerModel({
// //     this.username
// //   });

// //   RequestManagerModel.fromJson(Map<String, dynamic> json) {
// //      username= json['userName'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['userName']= username;
// //     return data;
// //   }
// // }

// class RequestManagerModel {
//   final String? userName;
//   final List<String>? zones;

//   RequestManagerModel({ this.userName,  this.zones});
//   factory RequestManagerModel.fromJson(Map<String, dynamic> json) {
//     return RequestManagerModel(
//       userName: json['userName'],
//       zones: List<String>.from(json['zones']),
//     );
//   }

//   // Method to convert a User to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'userName': userName,
//       'zones': zones,
//     };
//   }
// }
// class ResponseManagerModel {
//   final String? name;
//   final int? id;

//   ResponseManagerModel({
//        this.name,
//        this.id
//   });

//   factory ResponseManagerModel.fromJson(Map<String, dynamic> json) {
//     return ResponseManagerModel(
//       name: json['name'],
//       id: (json['id'] as num).toInt(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'id': id
//     };
//   }
// }