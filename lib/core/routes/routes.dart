import 'package:get/get.dart';
import 'package:uber/controllers/auth_controller.dart';
import 'package:uber/controllers/home_page_controller.dart';
import 'package:uber/controllers/home_select_controller.dart';
import 'package:uber/view/screens/auth/auth_name_page.dart';
import 'package:uber/view/screens/auth/email_check_page.dart';
import 'package:uber/view/screens/auth/email_otp_page.dart';
import 'package:uber/view/screens/auth/phone_number_page.dart';
import 'package:uber/view/screens/auth/phone_otp_page.dart';
import 'package:uber/view/screens/history/travel_history.dart';
import 'package:uber/view/screens/home/home_page.dart';
import 'package:uber/view/screens/home/recent_page.dart';
import 'package:uber/view/screens/home/select_home_page.dart';
import 'package:uber/view/screens/notifications/notifications_page.dart';
import 'package:uber/view/screens/settings/settings_page.dart';
import 'package:uber/view/screens/start/start_page.dart';
import '../middleware/middleware.dart';

class AppRoutes {
  static const String startPageRoute = "/";
  static const String phoneNumberPageRoute = "/phoneNumberPageRoute";
  static const String phoneOtpPageRoute = "/phoneOtpPage";
  static const String emailCheckPageRoute = "/emailCheckPage";
  static const String emailOtpPageRoute = '/emailOtpPage';
  static const String authNamePageRoute = "/authNamePage";
  static const String homePageRoute = "/homePageRoute";
  static const String recentPage = "/recentPageRoute";
  static const String travelPage = "/travelPage";
  static const String notificationsPage = "/notificationsPage";
  static const String settingsPage = "/settingsPage";
  static const String selectHomePage = "/selectHomePage";
}

List<GetPage<dynamic>> routes = [
  GetPage(
      name: AppRoutes.startPageRoute,
      page: () => const StartPage(),
      middlewares: [MiddleWare()]),
  GetPage(
      name: AppRoutes.phoneNumberPageRoute,
      page: () => const PhoneNumberPage(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder.put(() => AuthController())),
  GetPage(
    name: AppRoutes.phoneOtpPageRoute,
    page: () => const PhoneOtpPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.emailCheckPageRoute,
    page: () => const EmailCheckPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.emailOtpPageRoute,
    page: () => const EmailOtpPage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: AppRoutes.authNamePageRoute,
    page: () => const AuthNamepage(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
      name: AppRoutes.homePageRoute,
      page: () => const HomePage(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder.put(() => HomePageController())),
  GetPage(
    name: AppRoutes.recentPage,
    page: () => const RecentPage(),
    transition: Transition.size,
  ),
  GetPage(
    name: AppRoutes.travelPage,
    page: () => const TravelHistory(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: AppRoutes.notificationsPage,
    page: () => const NotificationsPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: AppRoutes.settingsPage,
    page: () => const SettingsPage(),
    transition: Transition.leftToRightWithFade,
  ),
  GetPage(
    name: AppRoutes.selectHomePage,
    page: () => const SelectHomePage(),
    binding: BindingsBuilder.put(() => HomeSelectController()),
    transition: Transition.leftToRightWithFade,
  )
];
