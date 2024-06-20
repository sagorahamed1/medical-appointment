import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class AllPrivacyPolicyScreen extends StatelessWidget {
  AllPrivacyPolicyScreen({super.key});

  var data = Get.parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: data['screenType'] == AppString.termsOfServices ? AppString
              .termsOfServices : data['screenType'] == AppString.privacyPolicys
              ? AppString.privacyPolicys
              : data['screenType'] == AppString.aboutUs ?  AppString.aboutUs : "",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeDefault.h,
              horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            children: [
              CustomText(
                maxline: 1000,
                textAlign: TextAlign.start,
                text:
                "Lorem ipsum dolor sit amet consectetur. Enim sagittis mattis sed risus nunc. Non ac vel viverra ut facilisis ultricies leo. Vel nunc eget tellus duis mollis sollicitudin. Eget aliquam leo sed arcu. Dignissim enim dolor rhoncus nam nisi ullamcorper sed suscipit pellentesque. Volutpat magna imperdiet cum adipiscing quam curabitur consectetur. At tortor consectetur ut ut scelerisque nec elementum tellus. Consectetur quis amet duis quisque suspendisse. Pellentesque scelerisque venenatis blandit velit ac eu.",
              )
            ],
          ),
        ),
      ),
    );
  }
}
