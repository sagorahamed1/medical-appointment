

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screens/Auth/sign_up/sign_up_screen.dart';
import '../views/screens/onboarding/onboarding_screen.dart';
import '../views/screens/role/role_screen.dart';
import '../views/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String onboardingScreen = "/OnboardingScreen.dart";
  static const String roleScreen = "/RoleScreen.dart";
  static const String signUpScreen = "/SignUpScreen.dart";


  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
        GetPage(name: roleScreen, page: () => RoleScreen()),
        GetPage(name: signUpScreen, page: () => SignUpScreen()),
  ];
}
