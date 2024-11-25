import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/app_colors.dart';
import '../../routes/app_routes.dart';
import 'custom_button.dart';
import 'custom_text.dart';


class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //=====================> Lottie Success Animation <=======================
            Lottie.asset(
              'assets/animation/success_animation.json',
              width: 150.w,
              height: 150.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 46.h),
            //=====================> Purchase Completed Text <=======================
            CustomText(
              text: "Purchase Completed!",
              fontsize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
            SizedBox(height: 36.h),
            CustomText(
              text:
              "Thank you. Your task is now\nactive and you can check the\nstatus on your account.",
              fontsize: 16.sp,
              color: AppColors.textColor193664,
            ),
            //=====================> Proceed to Program Button <=======================
            SizedBox(height: 60.h),
            CustomButton(
                onpress: () {
                  Get.offAndToNamed(AppRoutes.userBottomNavBar);
                },
                title: 'Proceed')
          ],
        ),
      ),
    );
  }
}