import 'dart:async';

import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.onboardingScreen);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration:  const BoxDecoration(
            color : AppColors.primaryColor,
          image: DecorationImage(
            image: AssetImage(AppImages.splashBgImage),fit: BoxFit.fill,opacity: .05
          ),
        ),

        child: Column(
          children: [
            SizedBox(height: 281.h),
            Image.asset(AppImages.logoImage),

            SizedBox(height: 141.h),
            const CustomLoader()
          ],
        ),
      ),
    );
  }
}
