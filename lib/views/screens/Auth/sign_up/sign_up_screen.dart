import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  final AuthController _authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: AppString.signUp, fontsize: 18.h, fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppString.signUpToJoin,
                  bottom: 24.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: firstNameCtrl,
                  hintText: AppString.firstName,
                  prefixIcon: AppIcons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                ///==========================last name ============================>
                CustomTextField(
                  // onChanged: (text) {setState(() {});},
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: lastNameCtrl,
                  hintText: AppString.lastName,
                  prefixIcon: AppIcons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                ///==========================email name ============================>
                CustomTextField(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: emailCtrl,
                  hintText: AppString.email,
                  prefixIcon: AppIcons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your user email";
                    } else if (!AppConstants.emailValidate.hasMatch(value)) {
                      return "Invalid email!";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                ///==========================password name ============================>
                Obx(
                  () => CustomTextField(
                    onChanged: (value) {setState(() {});},
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 0,
                    isObscureText: _authController.isObscure.value,
                    controller: passwordCtrl,
                    hintText: AppString.password,
                    prefixIcon: AppIcons.lock,
                    ///===============sufix Icon==================>
                    sufixicons: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 12.w),
                        child: GestureDetector(
                            onTap: () {
                              _authController.toggleIsObscure();
                            },
                            child: SvgPicture.asset(
                              _authController.isObscure.value
                                  ? AppIcons.obsecureHide
                                  : AppIcons.obsecure,
                              color: passwordCtrl.text.isNotEmpty
                                  ? AppColors.primaryColor
                                  : AppColors.gray767676,
                            ))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 8 || !AppConstants.validatePassword(value)) {
                        return "Password: 8 characters min, letters & digits \nrequired";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                ///==========================confirm password name ============================>
                Obx(
                  () => CustomTextField(
                    onChanged: (value) {
                      setState(() {

                      });
                    },
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 0,
                    controller: confirmPasswordCtrl,
                    isObscureText: _authController.isObscureConfirmPassword.value,
                    hintText: AppString.confirmPassword,
                    prefixIcon: AppIcons.lock,

                    ///===============sufix Icon==================>
                    sufixicons: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 12.w),
                        child: GestureDetector(
                            onTap: () {
                              _authController.toggleIsObscureConfirmPassword();
                            },
                            child: SvgPicture.asset(
                              _authController.isObscureConfirmPassword.value
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

                SizedBox(height: 24.h),

                _checkbox(),

                SizedBox(height: 104.h),

                CustomButton(onpress: ()  {
                  Get.offAllNamed(AppRoutes.veryfyEmailScreen);
                  // if (_formKey.currentState!.validate()) {
                  //   if (_authController.isChecked) {
                  //    ///Route here
                  //   } else {
                  //     setState(() {
                  //       _authController.isCheckboxError = true;
                  //     });
                  //   }
                  // }
                }, title: AppString.signUp),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppString.alreadyHaveAnAccount),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                          text: AppString.signIn, color: AppColors.primaryColor),
                    ),
                  ],
                ),

                SizedBox(height: 40.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _checkbox() {
    return Row(
      children: [
        Checkbox(
          value: _authController.isChecked,
          activeColor: AppColors.primaryColor,
          isError:_authController. isCheckboxError,
          onChanged: (bool? value) {
            setState(() {
              _authController.isChecked = value!;
            });
          },
        ),
        FittedBox(
          fit: BoxFit.cover,
          child: RichText(
            maxLines: 5,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.h,
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              //===============================> By Creating An Account TextSpan Section <===============================
              children: <TextSpan>[
                const TextSpan(
                  text: AppString.byCratingAnAccount,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.textColor5C5C5C,
                    fontFamily: "OpenSans-Regular",
                  ),
                ),
                TextSpan(
                    text: AppString.termsCondition,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                      color: AppColors.primaryColor,
                      fontFamily: "OpenSans-Regular",
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //==========================> on tap here <==========================
                        // Get.toNamed(AppRoutes.termsConditionScreen);
                      }),
                const TextSpan(
                  text: ' & ',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColors.textColor5C5C5C,
                    fontFamily: "OpenSans-Regular",
                  ),
                ),
                TextSpan(
                    text: AppString.privacyPolicy,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: AppColors.primaryColor,
                      fontFamily: "OpenSans-Regular",
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        //==========================> on tap here <==========================
                        // Get.toNamed(AppRoutes.privacyPolicyScreen);
                      }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
