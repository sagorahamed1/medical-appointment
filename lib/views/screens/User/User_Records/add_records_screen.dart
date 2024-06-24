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
import '../../../widgets/pop_up_menu.dart';

class AddRecordsScreen extends StatelessWidget {
  AddRecordsScreen({super.key});

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController problemCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController addPrescriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.addNewRecord,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===================Write Full Name TextField================>?
              _textAndTextField(AppString.patientName, "Type your full name",
                  "", '', [], nameCtrl, 1, TextInputType.text),

              ///===================Write you Age TextField================>
              _textAndTextField(AppString.age, "Write your Age", "", '', [],
                  ageCtrl, 1, TextInputType.number),

              ///===================Gender TextField================>
              _textAndTextField(
                  AppString.selecteGender,
                  " select gender",
                  "",
                  'Male',
                  ['Male', 'Female', 'Others'],
                  ageCtrl,
                  1,
                  TextInputType.number),

              ///===================Write Problem TextField================>?
              _textAndTextField(
                  AppString.writeMedicalHistory,
                  AppString.writeMedicalHistory,
                  "",
                  '',
                  [],
                  problemCtrl,
                  10,
                  TextInputType.text),

              CustomText(
                  text: AppString.addPrescription,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontsize: 18.h,
                  bottom: 20.h),
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: 'Upload files',
                  controller: addPrescriptionCtrl,
                  sufixicons: Padding(
                    padding:  EdgeInsets.all(18.r),
                    child: SvgPicture.asset(AppIcons.attachFile, color: AppColors.primaryColor, height: 15.h, width: 15.w),
                  ),
              ),

              SizedBox(height: 30.h),

            ],
          ),
        ),
      ),
    );
  }

  Widget _textAndTextField(
      String title,
      hinText,
      icon,
      dropSelectedItem,
      List dropDownList,
      TextEditingController controller,
      int maxLine,
      TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: title,
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
            sufixicons: dropSelectedItem == ''
                ? const SizedBox()
                : PopUpMenu(
                    items: dropDownList,
                    selectedItem: dropSelectedItem,
                    onTap: (int index) {},
                  )),
        SizedBox(height: 16.h)
      ],
    );
  }
}
