import 'dart:async';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/firebase_services.dart';
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
    Timer(Duration(seconds: 3), () async{
    var  islogged = await PrefsHelper.getBool(AppConstants.isLogged);
    var  token = await PrefsHelper.getString(AppConstants.bearerToken);
    var  role = await PrefsHelper.getString(AppConstants.role);
    var  email = await PrefsHelper.getString(AppConstants.email);
    var  pas = await PrefsHelper.getString(AppConstants.pas);
    var  userId = await PrefsHelper.getString(AppConstants.userId);
    print("===========is logged $islogged token $token role $role");


    ///***********firebase code*************///
    AuthService authService = AuthService();
    authService.login(email, pas, userId);
    ///***********firebase code*************///


    if(islogged){
      if(token != null){
        if(role == 'user'){
          Get.offAllNamed(AppRoutes.userBottomNavBar);
        }else{
          Get.offAllNamed(AppRoutes.doctorBottomNavBar);
        }
      }
    }else{
      Get.offAllNamed(AppRoutes.onboardingScreen);
    }
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
