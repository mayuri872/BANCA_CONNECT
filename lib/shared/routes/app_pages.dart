import 'package:dsr_clone/modules/manger/dar_manager_modules/reports/binding/reports_binding.dart';
import 'package:dsr_clone/modules/user/dar_user_modules/potential_agent_lead/binding/potential_agent_lead_binding.dart';
import 'package:get/get.dart';
import '../../modules/app/binding/app_binding.dart';
import '../../modules/app/view/app.dart';
import '../../modules/dashboard/binding/dashboard_binding.dart';
import '../../modules/dashboard/view/dashboard_view.dart';
import '../../modules/dashboard/view/web_dashboard_view.dart';
import '../../modules/login/binding/login_binding.dart';
import '../../modules/login/view/login_view.dart';
import '../../modules/manger/dar_manager_modules/leads_report/binding/lead_report_binding.dart';
import '../../modules/manger/dar_manager_modules/leads_report/view/lead_report_view.dart';
import '../../modules/manger/dar_manager_modules/manger_dashboard/view/manager_dashboard.dart';
import '../../modules/manger/dar_manager_modules/potential_agent_lead/binding/manager_agentlead_binding.dart';
import '../../modules/manger/dar_manager_modules/potential_agent_lead/view/manager_agent_lead_activity.dart';
import '../../modules/manger/dar_manager_modules/potential_agent_lead/view/manager_agentlead_view.dart';
import '../../modules/manger/dar_manager_modules/potential_cust_lead/binding/manager_custlead_binding.dart';
import '../../modules/manger/dar_manager_modules/potential_cust_lead/view/manager_custlead_activity_view.dart';
import '../../modules/manger/dar_manager_modules/potential_cust_lead/view/manager_custlead_view.dart';
import '../../modules/manger/dar_manager_modules/reports/view/reports_view.dart';
import '../../modules/manger/dar_manager_modules/team_activity/binding/teams_binding.dart';
import '../../modules/manger/dar_manager_modules/team_activity/view/team_activity_dashboard.dart';
import '../../modules/manger/dar_manager_modules/team_activity/view/team_activity_report.dart';
import '../../modules/user/dar_user_modules/dar_activity/binding/dar_activity_binding.dart';
import '../../modules/user/dar_user_modules/dar_activity/view/create_daily_activity.dart';
import '../../modules/user/dar_user_modules/dar_activity/view/daily_activity_report.dart';
import '../../modules/user/dsr_user_modules/dsr_activity/binding/dsr_activity_binding.dart';
import '../../modules/user/dsr_user_modules/dsr_activity/view/dsr_activity_view.dart';
import '../../modules/user/dar_user_modules/potential_agent_lead/view/agent_lead_acivity_view.dart';
import '../../modules/user/dar_user_modules/potential_agent_lead/view/create_agent_lead_activity.dart';
import '../../modules/user/dar_user_modules/potential_customer_lead/binding/customer_lead_binding.dart';
import '../../modules/user/dar_user_modules/potential_customer_lead/view/create_customer_lead_activity.dart';
import '../../modules/user/dar_user_modules/potential_customer_lead/view/customer_lead_acivity_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._internal();

  static final AppPages _instance = AppPages._internal();

  factory AppPages() {
    return _instance;
  }

  final routes = [
    GetPage(
      name: AppRoutes.app,
      page: () => const App(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.webdashboard,
      page: () => const WebDashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.reports,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: AppRoutes.teams,
      page: () => TeamsView(),
      binding: TeamsBinding(),
    ),
    // mayuri
    GetPage(
      name: AppRoutes.teamActivityDashboard,
      page: () => TeamActivityDashboard(),
      binding: TeamsBinding(),
    ),
    GetPage(
      name: AppRoutes.darActivity,
      page: () => AddDailyActivityReport(),
      binding: DarActivityBinding(),
    ),
    GetPage(
      name: AppRoutes.darActivityReport,
      page: () => DarActivityReport(),
      binding: DarActivityBinding(),
    ),
    GetPage(
      name: AppRoutes.managerDashboard,
      page: () => ManagerDashboardView(),
      binding: ManagerAgentLeadBinding(),
    ),
    GetPage(
      name: AppRoutes.potentialAgentLeadReport,
      page: () => AgentLeadActivityReport(),
      binding: PotentialAgentLeadBinding(),
    ),
    GetPage(
      name: AppRoutes.addPotentialAgentLead,
      page: () => CreateAgentLeadActivity(),
      binding: PotentialAgentLeadBinding(),
    ),
    GetPage(
      name: AppRoutes.customerLeadActivityReport,
      page: () => CustomerLeadActivityReport(),
      binding: CustomerLeadBinding(),
    ),

    GetPage(
      name: AppRoutes.addcustomerLeadActivity,
      page: () => CreateCustomerLeadActivity(),
      binding: CustomerLeadBinding(),
    ),
     GetPage(
      name: AppRoutes.dsrActivity,
      page: () => DsrActivityView(),
      binding: DsrActivityBinding(),
    ),
    GetPage(
      name: AppRoutes.managerAgentLead,
      page: () => ManagerAgentLead(),
      binding: ManagerAgentLeadBinding(),
    ),
    GetPage(
        name: AppRoutes.managerAgentLeadActivityReport,
        page: () => ManagerAgentLeadActivityReport(),
        binding: ManagerAgentLeadBinding()),

        GetPage(
      name: AppRoutes.managerCustLeadReport,
      page: () => ManagerCustLead(),
      binding: ManagerCustBinding(),
    ),
    GetPage(
        name: AppRoutes.managerCustLeadActivityReport,
        page: () => ManagerCustLeadActivityReport(),
        binding: ManagerAgentLeadBinding()),
        GetPage(
        name: AppRoutes.managerleadReports,
        page: () => LeadReportView(),
        binding: LeadReportBinding())
  ];
}
