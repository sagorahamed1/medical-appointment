import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserRecordsScreen extends StatelessWidget {
  const UserRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.medicalRecords,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [
            CustomText(
                text: AppString
                    .priorToConsultWithDoctorPleaseEnsureMedicalHistoryIsUpdatedWithTheMostCurrentInformation,
                fontsize: 18.h,
                maxline: 6,
                bottom: 18.h,
                textAlign: TextAlign.start,
                color: AppColors.textColor5C5C5C),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: AppString.yourRecords,
                    fontsize: 18.h,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
                Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 23.r,
                    ),
                    CustomText(
                        text: " ${AppString.addNew}",
                        fontsize: 16.h,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.fillColorE8EBF0),
                    child: Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Image.asset(AppImages.getStarted1,
                                      height: 84.h,
                                      width: 84.w,
                                      fit: BoxFit.cover)),
                              Expanded(
                                child: Column(
                                  children: [
                                    _CustomTwoText('Name :', "Sagor Ahamed"),
                                    _CustomTwoText('Age :', "25"),
                                    _CustomTwoText('Gender :', "Male"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 12.h),
                          CustomButton(
                              onpress: () {
                                Get.toNamed(AppRoutes.patientDetailsForRecordScreen);
                              }, title: AppString.seeDetails)
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _CustomTwoText(String key, value) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: key, color: AppColors.textColor5C5C5C, left: 12.w),
          CustomText(
              text: value,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}
