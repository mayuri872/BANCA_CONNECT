
class AppRoutes {
  AppRoutes._internal();

  static final AppRoutes _instance = AppRoutes._internal();

  factory AppRoutes() {
    return _instance;
  }

  static const String app = '/';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String webdashboard = '/webdashboard';
  

  // user login
  static const String darActivity = '/darActivityCreate';
  static const String darActivityReport = '/darActivityReport';
  static const String potentialAgentLeadReport = '/potentialAgentLeadReport';
  static const String addPotentialAgentLead = '/addPotentialAgentLead';
  static const String customerLeadActivityReport = '/CustomerLeadActivityReport';
  static const String addcustomerLeadActivity = '/addcustomerLeadActivity';
  static const String dsrActivity = '/dsrActivity';


  // manager
  static const String managerDashboard = '/managerDashboard';
  static const String teams = '/teams';
  static const String reports = '/reports';
  static const String managerAgentLead = '/mangerAgentLead';
  static const String managerCustomerLead = '/managerCustomerLead';
  static const String teamActivityDashboard = '/teamActivityDashboard';

  static const String managerleadReports = '/managerleadReports';
  static const String managerAgentLeadActivityReport = '/managerAgentLeadActivityReport';
  static const String managerCustLeadReport = '/managerCustLeadReport';
  static const String managerCustLeadActivityReport = '/managerCustLeadActivityReport';
  
  
}

