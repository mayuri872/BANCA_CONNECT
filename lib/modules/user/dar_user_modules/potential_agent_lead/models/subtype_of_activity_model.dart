class RequestSubTypeOfActivity {
  String? typeOfActivity;


  RequestSubTypeOfActivity({
    this.typeOfActivity
  });

  RequestSubTypeOfActivity.fromJson(Map<String, dynamic> json) {
     typeOfActivity= json['type_Of_Activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_Of_Activity']= typeOfActivity;
    return data;
  }
}

class ResponceSubTypeOfActivity {
   int? id;
   String? typeOfActivity;
   String? subTypeOfActivity;

  ResponceSubTypeOfActivity({
     this.id,
     this.typeOfActivity,
     this.subTypeOfActivity,
  });

  factory ResponceSubTypeOfActivity.fromJson(Map<String, dynamic> json) {
    return ResponceSubTypeOfActivity(
      id: json['id'],
      typeOfActivity: json['typeOfActivity'],
      subTypeOfActivity: json['subTypeOfActivity'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeOfActivity': typeOfActivity,
      'subTypeOfActivity': subTypeOfActivity,
    };
  }
}