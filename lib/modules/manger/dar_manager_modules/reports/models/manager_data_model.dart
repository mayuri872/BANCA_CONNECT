class RequestManagerModel {
  final String? userName;
  final List<String>? zones;

  RequestManagerModel({ this.userName,  this.zones});
  factory RequestManagerModel.fromJson(Map<String, dynamic> json) {
    return RequestManagerModel(
      userName: json['userName'],
      zones: List<String>.from(json['zones']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'zones': zones,
    };
  }
}
class ResponseManagerModel {
  final String? name;
  final int? id;

  ResponseManagerModel({
       this.name,
       this.id
  });

  factory ResponseManagerModel.fromJson(Map<String, dynamic> json) {
    return ResponseManagerModel(
      name: json['name'],
      id: (json['id'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id
    };
  }
}