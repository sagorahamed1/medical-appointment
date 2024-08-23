import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class ForgotPasswordScreen extends StatelessWidget {

  ForgotPasswordScreen({super.key});

  TextEditingController emailCtrl = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();


  @override
  Widget build(BuildContext context) {
    emailCtrl.text = Get.parameters['email'] ?? '';
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.forgotPasswordNotQuestionMark,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: AppString.pleaseEnterYourEmailToResetYourpassword,
                fontsize: 17.h,
                color: AppColors.textColor5C5C5C,
                maxline: 2,
                textAlign: TextAlign.start,
                bottom: 16.h),
            CustomTextFieldWithoutBorder(
              contenpaddingHorizontal: 20.w,
              contenpaddingVertical: 0,
              controller: emailCtrl,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: SvgPicture.asset(
                    AppIcons.email,
                    color: AppColors.gray767676,
                  )),
              hintText: AppString.email,
            ),
            const Spacer(),
            CustomButton(
              loading: _authController.forgotLoading.value,
                onpress: () {
             _authController.handleForgot(emailCtrl.text, 'forgotPassword');
            }, title: AppString.sendOTP),
            SizedBox(height: 72.h)
          ],
        ),
      ),
    );
  }
}
