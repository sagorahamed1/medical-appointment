import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

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
          children: [

          ],
        ),
      ),
    );
  }
}
