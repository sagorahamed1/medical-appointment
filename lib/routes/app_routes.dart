

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screens/onboarding/onboarding_screen.dart';
import '../views/screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = "/SplashScreen.dart";
  static const String onboardingScreen = "/OnboardingScreen.dart";


  static List<GetPage> get routes => [
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
  ];
}
