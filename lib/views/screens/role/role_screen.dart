import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
        child: Column(
          children: [

            SizedBox(height: 277.h),

            Container(
              clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault.r)
                ),
                child: Image.asset(AppImages.logoImageWithBg,width: double.infinity,height: 183.h,fit: BoxFit.fitWidth)),



            CustomText(text: AppString.WelcomeTo, fontsize: 18.h,fontWeight: FontWeight.w700,color: AppColors.primaryColor, top: 36.h),
            CustomText(text: AppString.medroofUrgentCareAndSpa, fontsize: 20.h,fontWeight: FontWeight.w700,color: AppColors.primaryColor, top: 8.h),
            CustomText(text: AppString.yourHealthIsOurPriority, fontsize: 18.h,fontWeight: FontWeight.w400,color: Colors.black, top: 8.h),


            CustomText(text: AppString.JoinAsA,fontWeight: FontWeight.w600,color: Colors.black, top: 96.h,bottom: 16.h),


            CustomTwoButon(
              width: 200,
              leftBtnOnTap: (){},
              rightBtnOnTap: (){},
              btnNameList: const [AppString.user, AppString.doctor],

            )

            ],
        ),
      ),
    );
  }
}
