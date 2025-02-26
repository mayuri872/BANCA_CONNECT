class ResponseLogin {
  String? empCode;
  String? empName;
  String? zone;
  String? reportingManager1;
  String? reportingManager1Empcode;
  String? flag;
  String? addAccess;
  String? token;

  ResponseLogin({
    this.empCode,
    this.empName,
    this.zone,
    this.reportingManager1,
    this.reportingManager1Empcode,
    this.flag,
    this.addAccess,
    this.token,
  });

  factory ResponseLogin.fromJson(Map<String, dynamic> json) {
    return ResponseLogin(
      empCode: json['EmpCode']?.toString(),
      empName: json['EmpName'],
      zone: json['zone'],
      reportingManager1: json['ReportingManager1'],
      reportingManager1Empcode: json['ReportingManager1Empcode']?.toString(),
      flag: json['flag'],
      addAccess: json['addAccess'],
      token: json['Token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmpCode': empCode,
      'EmpName': empName,
      'zone': zone,
      'ReportingManager1': reportingManager1,
      'ReportingManager1Empcode': reportingManager1Empcode,
      'flag': flag,
      'addAccess': addAccess,
      'Token': token,
    };
  }
}