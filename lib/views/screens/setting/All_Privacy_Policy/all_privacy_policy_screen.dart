import 'package:doctor_appointment/controllers/privacy_policy_all_controller.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class AllPrivacyPolicyScreen extends StatefulWidget {
  AllPrivacyPolicyScreen({super.key});

  @override
  State<AllPrivacyPolicyScreen> createState() => _AllPrivacyPolicyScreenState();
}

class _AllPrivacyPolicyScreenState extends State<AllPrivacyPolicyScreen> {
  var data = Get.parameters;
  PrivacyPolicyAllController policyAllController = Get.put(PrivacyPolicyAllController());


  @override
  void dispose() {
    policyAllController.content.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    data['screenType'] == AppString.termsOfServices ? policyAllController.getPrivacy( url: "/settings/terms-condition") : data['screenType'] == AppString.privacyPolicys
        ? policyAllController.getPrivacy( url: "/settings/privacy-policy")
        : data['screenType'] == AppString.aboutUs ?  policyAllController.getPrivacy( url: "/settings/about-us") : "";


    policyAllController.getPrivacy( url: "/settings/privacy-policy");
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

              Obx(() => policyAllController.isLoading.value ? Center(child: Padding(
                padding:  EdgeInsets.only(top: 200.h),
                child: const CustomLoader(),
              )) : policyAllController.content.value.isEmpty ? Center(child: CustomText(text: "No Data Found!", top: 200.h)) :  HtmlWidget(
                  policyAllController.content.value,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 14.h,

                  )
              ),
              ),
              // CustomText(
              //   maxline: 1000,
              //   textAlign: TextAlign.start,
              //   text:
              //   "Lorem ipsum dolor sit amet consectetur. Enim sagittis mattis sed risus nunc. Non ac vel viverra ut facilisis ultricies leo. Vel nunc eget tellus duis mollis sollicitudin. Eget aliquam leo sed arcu. Dignissim enim dolor rhoncus nam nisi ullamcorper sed suscipit pellentesque. Volutpat magna imperdiet cum adipiscing quam curabitur consectetur. At tortor consectetur ut ut scelerisque nec elementum tellus. Consectetur quis amet duis quisque suspendisse. Pellentesque scelerisque venenatis blandit velit ac eu.",
              // )
            ],
          ),
        ),
      ),
    );
  }
}
