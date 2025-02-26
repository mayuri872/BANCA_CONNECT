class RequestMarkAttendance {
  String? username;
  String? dateofvisit;


  RequestMarkAttendance({
    this.username,
    this.dateofvisit,
  
  });

  factory RequestMarkAttendance.fromJson(Map<String, dynamic> json) {
    return RequestMarkAttendance(
      username: json['userName'],
      dateofvisit: json['date_Of_Visit'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': username,
      'date_Of_Visit': dateofvisit,
    
    };
  }
}

class ResponceGetAttendace {
  String? count;


  ResponceGetAttendace({
    this.count,
  
  });

  factory ResponceGetAttendace.fromJson(Map<String, dynamic> json) {
    return ResponceGetAttendace(
      count: json['Count'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Count': count,
    
    };
  }
}