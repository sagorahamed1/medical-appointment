import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_select_package_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_two_button.dart';
import '../User_doctor_details/Inner_widgets/top_doctor_box_card.dart';

class PatientDetailsForRecordScreen extends StatelessWidget {
  const PatientDetailsForRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.patientDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w, vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopDoctorBoxCard(
              location: 'Christ Hospital in London, UK',
              doctorName: "Sagor Ahamed",
            ),


            ///===================Patient Information===================>
            CustomText(
                text: AppString.patientInformation,
                fontWeight: FontWeight.w600,
                fontsize: 18.h,
                top: 20.h,
                bottom: 16.h),

            _leftAndRightText(AppString.fullName, "Sagor Ahamed"),
            _leftAndRightText(AppString.gender, "Male"),
            _leftAndRightText(AppString.age, "25"),
            _leftAndRightText(AppString.problem,
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. "),

            SizedBox(height: 24.h),
            ///======================================>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: AppString.prescription,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    fontsize: 18.h,
                   ),

                GestureDetector(
                  onTap: (){
                    Get.toNamed(AppRoutes.addRecordsScreen);
                  },
                  child: CustomText(
                      text: AppString.clickHere,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                      fontsize: 18.h,
                      ),
                ),
              ],
            ),




          ],
        ),
      ),
    );
  }


  Widget _leftAndRightText(String leftText, rightText) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: '${leftText}  : ',
              fontsize: 16.h,
              color: AppColors.textColor5C5C5C),
          SizedBox(
              width: 252.w,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                      text: ' $rightText',
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C,
                      maxline: 10,
                      textAlign: TextAlign.start))),
        ],
      ),
    );
  }
}
