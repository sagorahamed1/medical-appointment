import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  TextEditingController currectPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  RxBool currectTextfieldObscure = true.obs;
  RxBool newPasswordTextfieldObscure = true.obs;
  RxBool confirmPasswordTextfieldObscure = true.obs;

  toggleCurrentTextFieldObscure() {
    currectTextfieldObscure.value = !currectTextfieldObscure.value;
  }

  toggleNewPasswordTextFieldObscure() {
    newPasswordTextfieldObscure.value = !newPasswordTextfieldObscure.value;
  }

  toggleconfirmPasswordTextFieldObscure() {
    confirmPasswordTextfieldObscure.value = !confirmPasswordTextfieldObscure.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.changePassword,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault.h,
            horizontal: Dimensions.paddingSizeDefault.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===============Current password=================>
              _textField('Current password', currectPasswordCtrl,
                  currectTextfieldObscure.value, () {
                toggleCurrentTextFieldObscure();
              }),
              SizedBox(height: 16.h),

              ///===============New password=================>
              _textField('New password', newPasswordCtrl,
                  newPasswordTextfieldObscure.value, () {
                toggleNewPasswordTextFieldObscure();
              }),
              SizedBox(height: 16.h),

              ///===============Confirm password=================>
              _textField('Confirm new password', confirmPasswordCtrl,
                  confirmPasswordTextfieldObscure.value, () {
                    toggleconfirmPasswordTextFieldObscure();
                  }),


              SizedBox(height: 20.h),


              CustomText(text: AppString.forgetPassword,fontWeight: FontWeight.w600,fontsize: 18.h,color: AppColors.primaryColor),

              Spacer(),

              CustomButton(onpress: (){}, title: AppString.updatePassword),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String hintext, TextEditingController controller,
      bool isObscure, VoidCallback onTap) {
    return CustomTextFieldWithoutBorder(

        contenpaddingHorizontal: 20,
        contenpaddingVertical: 20,
        hintText: hintext,
        isObscureText: isObscure,
        maxLines: 1,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 12.w),
          child: SvgPicture.asset(AppIcons.lock),
        ),
        sufixicons: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: GestureDetector(
              onTap: onTap,
              child: SvgPicture.asset(
                  isObscure ? AppIcons.obsecureHide : AppIcons.obsecure,
                  color: AppColors.gray767676)),
        ),
        controller: controller);
  }
}
