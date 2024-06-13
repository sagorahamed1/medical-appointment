

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screens/Auth/fill_profile/fill_profile_screen.dart';
import '../views/screens/Auth/forgot_password/forgot_password_screen.dart';
import '../views/screens/Auth/set_password/set_password_screen.dart';
import '../views/screens/Auth/sign_in/sign_in_screen.dart';
import '../views/screens/Auth/sign_up/sign_up_screen.dart';
import '../views/screens/Auth/veryfy_email/veryfy_email_screen.dart';
import '../views/screens/User/Available_Doctors/availablle_doctors_screen.dart';
import '../views/screens/User/Emergency_Doctors/availablle_doctors_screen.dart';
import '../views/screens/User/User_home/user_home_screen.dart';
import '../views/screens/User/doctor_details/doctor_details_screen.dart';
import '../views/screens/User/search/user_search_screen.dart';
import '../views/screens/User/select_package/select_package_screen.dart';
import '../views/screens/User/user_bottom_nav_bar/user_bottom_nav_bar.dart';
import '../views/screens/User/user_category/user_category_screen.dart';
import '../views/screens/notifications/notifications_screen.dart';
import '../views/screens/onboarding/onboarding_screen.dart';
import '../views/screens/role/role_screen.dart';
import '../views/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String onboardingScreen = "/OnboardingScreen.dart";
  static const String roleScreen = "/RoleScreen.dart";
  static const String signUpScreen = "/SignUpScreen.dart";
  static const String veryfyEmailScreen = "/VeryfyEmailScreen.dart";
  static const String fillProfileScreen = "/FillProfileScreen.dart";
  static const String signInScreen = "/SignInScreen.dart";
  static const String forgotPasswordScreen = "/ForgotPasswordScreen.dart";
  static const String setPasswordScreen = "/SetPasswordScreen.dart";
  static const String userHomeScreen = "/UserHomeScreen.dart";
  static const String userBottomNavBar = "/UserBottomNavBar.dart";
  static const String notificationScreen = "/NotificationScreen.dart";
  static const String userSearchScreen = "/UserSearchScreen.dart";
  static const String availablleDoctorsScreen = "/AvailablleDoctorsScreen.dart";
  static const String emergencyDoctorsScreen = "/EmergencyDoctorsScreen.dart";
  static const String userCategoryScreen = "/UserCategoryScreen.dart";
  static const String doctorDetailsScreen = "/DoctorDetailsScreen.dart";
  static const String selectPackageScreen = "/SelectPackageScreen.dart";


  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
        GetPage(name: roleScreen, page: () => RoleScreen()),
        GetPage(name: signUpScreen, page: () => SignUpScreen()),
        GetPage(name: veryfyEmailScreen, page: () => VeryfyEmailScreen()),
        GetPage(name: fillProfileScreen, page: () => FillProfileScreen()),
        GetPage(name: signInScreen, page: () => SignInScreen()),
        GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
        GetPage(name: setPasswordScreen, page: () => SetPasswordScreen()),
        GetPage(name: userHomeScreen, page: () => UserHomeScreen()),
        GetPage(name: userBottomNavBar, page: () => UserBottomNavBar()),
        GetPage(name: notificationScreen, page: () => NotificationScreen()),
        GetPage(name: userSearchScreen, page: () => UserSearchScreen()),
        GetPage(name: availablleDoctorsScreen, page: () => AvailablleDoctorsScreen()),
        GetPage(name: emergencyDoctorsScreen, page: () => EmergencyDoctorsScreen()),
        GetPage(name: userCategoryScreen, page: () => UserCategoryScreen()),
        GetPage(name: doctorDetailsScreen, page: () => DoctorDetailsScreen()),
        GetPage(name: selectPackageScreen, page: () => SelectPackageScreen()),
  ];
}
