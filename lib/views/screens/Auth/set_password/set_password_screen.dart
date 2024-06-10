import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({super.key});

  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  RxBool isObscure = true.obs;
  RxBool isObscureConfirmPassword = true.obs;

  toggleIsObscure(){
    isObscureConfirmPassword.value  =!isObscureConfirmPassword.value;
  }


  toggleIsObscureConfirmPassword(){
    isObscure.value  =!isObscure.value;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.setNewPassword,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: AppString.setYournewpassword,
                fontsize: 17.h,
                color: AppColors.textColor5C5C5C,
                maxline: 2,
                textAlign: TextAlign.start,
                bottom: 16.h),

            ///==========================password name ============================>
            Obx(
              () => CustomTextFieldWithoutBorder(
                maxLines: 1,
                contenpaddingHorizontal: 20,
                contenpaddingVertical: 0,
                isObscureText: isObscure.value,
                controller: passwordCtrl,
                hintText: AppString.password,
                prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 12.w),
                    child: SvgPicture.asset(
                       AppIcons.lock,
                      color:  AppColors.gray767676,
                    )),

                ///===============sufix Icon==================>
                sufixicons: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 12.w),
                    child: GestureDetector(
                        onTap: () {
                          toggleIsObscure();
                        },
                        child: SvgPicture.asset(
                          isObscure.value
                              ? AppIcons.obsecureHide
                              : AppIcons.obsecure,
                          color: passwordCtrl.text.isNotEmpty
                              ? AppColors.primaryColor
                              : AppColors.gray767676,
                        ))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 8 ||
                      !AppConstants.validatePassword(value)) {
                    return "Password: 8 characters min, letters & digits \nrequired";
                  }
                  return null;
                },
              ),
            ),

            SizedBox(height: 16.h),

            ///==========================confirm password name ============================>
            Obx(
              () => CustomTextFieldWithoutBorder(
                maxLines: 1,
                contenpaddingHorizontal: 20,
                contenpaddingVertical: 0,
                controller: confirmPasswordCtrl,
                isObscureText: isObscureConfirmPassword.value,
                hintText: AppString.confirmPassword,
                prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 12.w),
                    child: SvgPicture.asset(
                     AppIcons.lock,
                      color:  AppColors.gray767676,
                    )),

                ///===============sufix Icon==================>
                sufixicons: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 12.w),
                    child: GestureDetector(
                        onTap: () {
                          toggleIsObscureConfirmPassword();
                        },
                        child: SvgPicture.asset(
                          isObscureConfirmPassword.value
                              ? AppIcons.obsecureHide
                              : AppIcons.obsecure,
                          color: confirmPasswordCtrl.text.isNotEmpty
                              ? AppColors.primaryColor
                              : AppColors.gray767676,
                        ))),

                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter again your user password";
                  } else if (value != passwordCtrl.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
            ),

            const Spacer(),
            CustomButton(
                onpress: () {
                  Get.toNamed(AppRoutes.veryfyEmailScreen,
                      parameters: {"screenType": "forgotPassword"});
                },
                title: AppString.setNewPassword),
            SizedBox(height: 72.h)
          ],
        ),
      ),
    );
  }
}
