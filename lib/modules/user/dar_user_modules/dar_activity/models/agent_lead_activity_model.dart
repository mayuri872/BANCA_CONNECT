class RequestAgentLeadActivity {
  String? username;
  String? leadType;


  RequestAgentLeadActivity({
    this.username,
    this.leadType
  });

  RequestAgentLeadActivity.fromJson(Map<String, dynamic> json) {
     username= json['userName'];
     leadType= json['leadType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName']= username;
    data['leadType'] = leadType;
    return data;
  }
}