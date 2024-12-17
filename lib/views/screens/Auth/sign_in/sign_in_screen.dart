import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxBool isObscure = true.obs;

  toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: AppString.signIn,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w, vertical: 24.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: AppString.signInToContinue,
                  fontsize: 20.h,
                  color: AppColors.primaryColor,
                  bottom: 24.h),
              CustomTextFieldWithoutBorder(
                contenpaddingHorizontal: 20.w,
                contenpaddingVertical: 0,
                controller: emailCtrl,
                prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: SvgPicture.asset(
                      AppIcons.email,
                      color: AppColors.gray767676,
                    )),
                hintText: AppString.email,
                validator: (value) {
                  if (value == null || value == value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!AppConstants.emailValidate.hasMatch(value)) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              Obx(
                () => CustomTextFieldWithoutBorder(
                  maxLines: 1,
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 0,
                  controller: passwordCtrl,
                  hintText: AppString.password,
                  isObscureText: isObscure.value,
                  prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: SvgPicture.asset(
                        AppIcons.lock,
                        color: AppColors.gray767676,
                      )),
                  sufixicons: Obx(
                    () => Padding(
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
                  ),
                  validator: (value) {
                    if (value == null || value == value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8 ||
                        !AppConstants.validatePassword(value)) {
                      return "Password: 8 characters min, letters & digits \nrequired";
                    }
                    return null;
                  },
                ),
              ),

              ///=====================forgot password=================>
              GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotPasswordScreen,
                        parameters: {'email': emailCtrl.text});
                  },
                  child: CustomText(
                      text: AppString.forgetPassword,
                      color: AppColors.primaryColor,
                      fontsize: 18.h,
                      fontWeight: FontWeight.w600,
                      top: 16.h)),
              const Spacer(),

              ///=====================sign in button==============>
              Obx(
                () => CustomButton(
                    loading: _authController.logInLoading.value,
                    onpress: () async {
                      if (formKey.currentState!.validate()) {
                        _authController.handleLogIn(
                            emailCtrl.text, passwordCtrl.text);
                      }
                    },
                    title: AppString.signIn),
              ),
              SizedBox(height: 26.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: AppString.dontHaveAnAccount),

                  ///===============don't have an account sign up============>
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: CustomText(
                        text: " ${AppString.signUp}",
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 40.h)
            ],
          ),
        ),
      ),
    );
  }
}
