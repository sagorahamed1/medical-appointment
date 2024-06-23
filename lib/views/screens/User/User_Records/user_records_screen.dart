import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w, vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [
            CustomText(text: AppString.priorToConsultWithDoctorPleaseEnsureMedicalHistoryIsUpdatedWithTheMostCurrentInformation, fontsize: 18.h, color: AppColors.textColor5C5C5C)
          ],
        ),
      ),
    );
  }
}
