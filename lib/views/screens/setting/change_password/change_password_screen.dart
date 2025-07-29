import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  // final AuthController _authController = Get.find<AuthController>();
  final AuthController _authController = Get.put(AuthController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    confirmPasswordTextfieldObscure.value =
        !confirmPasswordTextfieldObscure.value;
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
          () => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///===============Current password=================>
                CustomTextFieldWithoutBorder(
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 20,
                    hintText: 'Current password',
                    isObscureText: currectTextfieldObscure.value,
                    maxLines: 1,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.lock),
                    ),
                    sufixicons: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: GestureDetector(
                          onTap: () {
                            toggleCurrentTextFieldObscure();
                          },
                          child: SvgPicture.asset(
                              currectTextfieldObscure.value
                                  ? AppIcons.obsecureHide
                                  : AppIcons.obsecure,
                              color: AppColors.gray767676)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your old password';
                      }
                    },
                    controller: currectPasswordCtrl),

                SizedBox(height: 16.h),

                ///===============New password=================>

                CustomTextFieldWithoutBorder(
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 20,
                    hintText: 'New password',
                    isObscureText: newPasswordTextfieldObscure.value,
                    maxLines: 1,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.lock),
                    ),
                    sufixicons: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: GestureDetector(
                          onTap: () {
                            toggleNewPasswordTextFieldObscure();
                          },
                          child: SvgPicture.asset(
                              newPasswordTextfieldObscure.value
                                  ? AppIcons.obsecureHide
                                  : AppIcons.obsecure,
                              color: AppColors.gray767676)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      } else if (value.length < 8 ||
                          !AppConstants.validatePassword(value)) {
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                    controller: newPasswordCtrl),
                SizedBox(height: 16.h),

                ///===============Confirm password=================>

                CustomTextFieldWithoutBorder(
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 20,
                    hintText: 'Confirm new password',
                    isObscureText: confirmPasswordTextfieldObscure.value,
                    maxLines: 1,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 12.w),
                      child: SvgPicture.asset(AppIcons.lock),
                    ),
                    sufixicons: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: GestureDetector(
                          onTap: () {
                            toggleconfirmPasswordTextFieldObscure();
                          },
                          child: SvgPicture.asset(
                              confirmPasswordTextfieldObscure.value
                                  ? AppIcons.obsecureHide
                                  : AppIcons.obsecure,
                              color: AppColors.gray767676)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter again your user password";
                      } else if (value != newPasswordCtrl.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    controller: confirmPasswordCtrl),

                SizedBox(height: 20.h),

                GestureDetector(
                  onTap: () async{
                   var email = await PrefsHelper.getString(AppConstants.email);
                    Get.toNamed(AppRoutes.forgotPasswordScreen, parameters: {
                      'email' : email
                    });
                  },
                  child: CustomText(
                      text: AppString.forgetPassword,
                      fontWeight: FontWeight.w600,
                      fontsize: 18.h,
                      color: AppColors.primaryColor),
                ),

                Spacer(),

                CustomButton(
                    onpress: () {
                      if (_formKey.currentState!.validate()) {
                        _authController.changePassword(
                            currectPasswordCtrl.text, newPasswordCtrl.text);
                      }
                    },
                    title: AppString.updatePassword),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
