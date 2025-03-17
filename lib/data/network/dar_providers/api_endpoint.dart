class ApiEndPoints {
  ApiEndPoints._internal();

  static final ApiEndPoints _instance = ApiEndPoints._internal();

  factory ApiEndPoints() {
    return _instance;
  }

  /// LOGIN
  final String login = 'HealthSalesConnect/api/Login/Authenticate_Health';

  /// User DAR post
  final String addDailyActivity = 'HealthSalesConnect/api/Health/addDSRdtls';
  final String addAgendLeadActivity = 'HealthSalesConnect/api/DSR/addDSRdtls';
  final String addCustomerLeadActivity = 'HealthSalesConnect/api/DSR/addDSRdtls';

  //User DAR GET
  final String dailyActivityReport = 'HealthSalesConnect/api/Health/getDSRdtls';
  final String getAttendanceStatus = 'HealthSalesConnect/api/health/getAttendanceDtls';
  final String getAgentLead = 'HealthSalesConnect/api/DSR/getDSRdtls';
  final String getCustomerLead = 'HealthSalesConnect/api/DSR/getDSRdtls';
  final String getSubTypeOfAct = 'HealthSalesConnect/api/DSR/getDSRSubtypeOfActivity';
  final String getCompetitionInfo = 'HealthSalesConnect/api/DSR/getDSRInsurers';
  final String getDSRProductMst = 'HealthSalesConnect/api/DSR/getDSRProductMst';
  final String getDSRAgntLeadsdtls = 'HealthSalesConnect/api/DSR/getDSR_AgntLeads_dtls';
  final String getDSRCustomerLeadsdtls = 'HealthSalesConnect/api/DSR/getDSR_CustomerLeads_dtls';
  final String getLeaderDtlsWithZone = 'HealthSalesConnect/api/Health/getLeaderDtlsWithZone';
  final String getDSRAgentDtls = 'HealthSalesConnect/api/DSR/getDSR_Agent_Dtls';
  final String getDSRCustLeadDtls = 'HealthSalesConnect/api/DSR/getDSR_CustLead_Dtls';
  final String getDSRAgentLeadDtls = 'HealthSalesConnect/api/DSR/getDSR_AgentLead_Dtls';
  final String getdSRFilter = 'HealthSalesConnect/api/health/dSRFilter';
  final String zoneManagerfilters = 'HealthSalesConnect/api/health/ZoneManagerfilters';
  final String getDSRZone ='HealthSalesConnect/api/Health/getDSRZone';
  final String getDSRlastday= 'HealthSalesConnect/api/Health/getDSRlastday';
  final String getDSRlastMonth= 'HealthSalesConnect/api/Health/getDSRlastMonth';
  final String getDSRleaders= 'HealthSalesConnect/api/Health/getDSRleaders';
  


  // // DSR manger get 
  // final String getDSRleaders= 'HealthSalesConnect/api/Health/getDSRleaders';
}
