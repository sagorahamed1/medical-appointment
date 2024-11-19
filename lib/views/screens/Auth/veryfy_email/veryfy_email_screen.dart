import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import 'Inner_Widgets/pin_code_field.dart';

class VeryfyEmailScreen extends StatelessWidget {
  VeryfyEmailScreen({super.key});


  final AuthController _authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.verifyEmail,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 24.h, horizontal: Dimensions.paddingSizeDefault.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppString.weHaveSentA_verificationCode,
              maxline: 2,
              fontsize: 16.5.h,
              color: AppColors.textColor5C5C5C,
              textAlign: TextAlign.start,
            ),
            CustomText(
                text: AppString.pleaseCheckYourEmail,
                fontsize: 16.h,
                color: AppColors.textColor5C5C5C,
                bottom: 16.h),
            PinCodeField(otp: _authController.otpCtrl),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: AppString.didntGetTheCode,
                    fontsize: 16.h,
                    color: AppColors.textColor5C5C5C),
                GestureDetector(
                  onTap: (){
                    _authController.reSendOtp('${Get.parameters['email']}');
                    _authController.otpCtrl.clear();
                  },
                  child: CustomText(
                      text: AppString.resend,
                      fontsize: 16.h,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
             const Spacer(),
            Obx(()=>
               CustomButton(
                   loading: _authController.verfyLoading.value,
                  onpress: () {
                    if (Get.parameters['screenType'] == 'forgotPassword') {
                      _authController.verfyEmail(_authController.otpCtrl.text,Get.parameters['email'], 'forgotPassword');
                      _authController.otpCtrl.clear();
                    } else {
                      _authController.verfyEmail(_authController.otpCtrl.text, Get.parameters['email'], 'signUp');
                      _authController.otpCtrl.clear();
                    }

                    // Get.parameters['screenType'] == 'forgotPassword' ? Get.toNamed(AppRoutes.setPasswordScreen) :
                    // Get.toNamed(AppRoutes.fillProfileScreen,
                    //
                    // );
                  },
                  title: AppString.verifyEmail),
            ),
            SizedBox(height: 98.h)
          ],
        ),
      ),
    );
  }
}
