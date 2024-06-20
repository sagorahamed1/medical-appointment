import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.settings,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault.h, horizontal: Dimensions.paddingSizeDefault.w),
        child: Column(
          children: [
            _ListTile(AppString.changePassword, AppIcons.rightArrow, (){
              Get.toNamed(AppRoutes.changePasswordScreen);
            }),
            _ListTile(AppString.termsOfServices, AppIcons.rightArrow, (){}),
            _ListTile(AppString.privacyPolicys, AppIcons.rightArrow, (){}),
            _ListTile(AppString.aboutUs, AppIcons.rightArrow, (){}),
          ],
        ),
      ),
    );
  }

  Widget _ListTile(String title, leadingIcon, VoidCallback onTap) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(16.r)),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.w, right: 20.w),
            title: CustomText(
                maxline: 2,
                text: title,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            trailing: SvgPicture.asset(leadingIcon,
                height: 20.h,
                width: 20.w,
                fit: BoxFit.cover,
                color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
