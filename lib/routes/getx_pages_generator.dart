import 'package:get/get.dart';
import 'package:app_sostegno/features/authentication/presentation/pages/loading_page.dart';
import 'package:app_sostegno/features/authentication/presentation/pages/login_page.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/pages/enroll_to_monitory_step1_view.dart';
import 'package:app_sostegno/features/enroll_to_monitory/presentation/pages/enroll_to_monitory_step2_view.dart';
import 'package:app_sostegno/features/monitor_details/presentation/pages/monitor_details_page.dart';
import 'package:app_sostegno/features/monitories/presentation/monitor_monitories/pages/monitor_monitories_page.dart';
import 'package:app_sostegno/features/monitories/presentation/monitories_calendar/pages/my_calendar_page.dart';
import 'package:app_sostegno/features/monitories/presentation/monitory_details/pages/monitory_details_page.dart';
import 'package:app_sostegno/features/monitory_creation/presentation/pages/create_monitory_page.dart';
import 'package:app_sostegno/features/monitory_request_creation/presentation/pages/make_monitory_request_page.dart';
import 'package:app_sostegno/features/monitory_requests/presentation/pages/requested_monitories_page.dart';
import 'package:app_sostegno/features/register/presentation/pages/register_page.dart';
import 'package:app_sostegno/routes/routes_name.dart';

final getPagesList = [
  GetPage(name: RoutesName.LOADING_PAGE, page: () => const LoadingPage()),
  GetPage(name: RoutesName.LOGIN_PAGE, page: () => const LoginPage()),
  GetPage(name: RoutesName.REGISTER_PAGE, page: () => const RegisterPage()),
  GetPage(name: RoutesName.My_CALENDAR, page: () => const MyCalendarPage()),
  GetPage(
      name: RoutesName.My_MONITORIES,
      page: () => const MonitorMonitoriesPage()),
  GetPage(
      name: RoutesName.CREATE_MONITORY, page: () => const CreateMonitoryPage()),
  GetPage(
      name: RoutesName.MAKE_MONITORY_REQUEST,
      page: () => const MakeMonitoryRequestPage()),
  GetPage(
      name: RoutesName.REQUESTED_MONITORY,
      page: () => const RequestedMonitoriesPage()),
  GetPage(
      name: RoutesName.MONITORY_DETAILS,
      page: () => const MonitoryDetailsPage()),
  GetPage(
      name: RoutesName.ENROLL_MONITORY_STEP1,
      page: () => const EnrollStep1Page()),
  GetPage(
      name: RoutesName.ENROLL_MONITORY_STEP2,
      page: () => const EnrollStep2Page()),
  GetPage(
      name: RoutesName.MONITOR_DETAILS, page: () => const MonitorDetailsPage()),
];
