import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/themes/light_theme.dart';
import 'package:doctor_appointment/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'doctor appointment',
          theme: light(),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          home: SplashScreen(),
        ),
        designSize: const Size(393, 852));
  }
}

