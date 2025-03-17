class DSRApiEndPoints {
  DSRApiEndPoints._internal();

  static final DSRApiEndPoints _instance = DSRApiEndPoints._internal();

  factory DSRApiEndPoints() {
    return _instance;
  }

  /// LOGIN
   final String login = 'TeamTrack/api/Login/Authenticate';
   
  // final String loginWithPin = '/api/Authentication/loginWithPin';
  // final String createAppPin = '/api/Authentication/CreateAppPin';
  // final String getUsers = '/api/Authentication/GetUsersAsync';

  // /// User DAR post
  // final String addDailyActivity = '/api/Health/addDSRdtls';
  // final String addAgendLeadActivity= '/api/DSR/addDSRdtls';
  // final String addCustomerLeadActivity = '/api/DSR/addDSRdtls';

  //User DAR GET
  final String dSRdailyActivityReport = 'TeamTrack/api/MobileApp/getDSRdtls';
 
}