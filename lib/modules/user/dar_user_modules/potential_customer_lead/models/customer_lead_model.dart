class ResponceCustAgentDetails {
  final int id;
  final String smId;
  final String smName;
  final String agentCode;
  final String agentName;
  final DateTime createdDate;
  final String agentEmail;
  final String agentContact;

  ResponceCustAgentDetails({
    required this.id,
    required this.smId,
    required this.smName,
    required this.agentCode,
    required this.agentName,
    required this.createdDate,
    required this.agentEmail,
    required this.agentContact,
  });

  factory ResponceCustAgentDetails.fromJson(Map<String, dynamic> json) {
    return ResponceCustAgentDetails(
      id: json['ID'],
      smId: json['SM_Id'],
      smName: json['SM_Name'],
      agentCode: json['AgentCode'],
      agentName: json['AgentName'],
      createdDate: DateTime.parse(json['createddate']),
      agentEmail: json['agentEmail'],
      agentContact: json['agentContact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'SM_Id': smId,
      'SM_Name': smName,
      'AgentCode': agentCode,
      'AgentName': agentName,
      'createddate': createdDate.toIso8601String(),
      'agentEmail': agentEmail,
      'agentContact': agentContact,
    };
  }
}