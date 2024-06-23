import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class AddRecordsScreen extends StatelessWidget {
   AddRecordsScreen({super.key});

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController problemCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();

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


      body:  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Obx(()=>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///===================Write Full Name TextField================>?
                  _textAndTextField(AppString.fullName, "Type your full name", "", nameCtrl, 1, TextInputType.text),
                  CustomText(
                      text: AppString.selecteGender,
                      fontsize: 18.h,
                      fontWeight: FontWeight.w600,
                      bottom: 20.h),

                  CustomTextFieldWithoutBorder(
                    readOnly: true,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 0,
                    controller: genderCtrl,
                    hintText: 'Select gender',
                    sufixicons: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                      child: SvgPicture.asset(
                        AppIcons.arrowDown,
                        color: AppColors.primaryColor,
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 5.h),

                  SizedBox(height: 16.h),
                  ///===================Write you Age TextField================>
                  _textAndTextField(AppString.yourAge, "Write your Age", "", ageCtrl, 1, TextInputType.number),
                  ///===================Write Problem TextField================>?
                  _textAndTextField(AppString.writeYourProblem, AppString.writeYourProblem, "", problemCtrl, 10, TextInputType.text),
                  SizedBox(height: 20.h),
                  CustomButton(onpress: () {}, title: AppString.continues),
                  SizedBox(height: 20.h),
                ],
              ),
          ),
        ),
      ),


    );
  }


  Widget _textAndTextField(String title, hinText, icon,
      TextEditingController controller, int maxLine, TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: "$title",
            fontsize: 18.h,
            fontWeight: FontWeight.w600,
            bottom: 20.h),
        CustomTextFieldWithoutBorder(
          contenpaddingHorizontal: 20,
          contenpaddingVertical: 10,
          controller: controller,
          maxLines: maxLine,
          keyboardType: keyboardType,
          hintText: '$hinText',
          sufixicons: icon == ""
              ? const SizedBox()
              : Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            child: SvgPicture.asset(
              AppIcons.arrowDown,
              color: AppColors.primaryColor,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 16.h)
      ],
    );
  }
}
