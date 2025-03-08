import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/toggle_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/doctor/emergency_toggle_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_list_tile.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final EmergencyToggleController _emergencyToggleController = Get.put(EmergencyToggleController());
  TextEditingController passWordCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _toggleValue = false;
  final RxBool isObscure = true.obs;

  toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  @override
  void initState() {
    super.initState();
    String? emergencyParam = Get.parameters['emergency'];
    if (emergencyParam != null) {
      _toggleValue = emergencyParam.toLowerCase() == 'true';
    }
  }

  void _toggleButton() {
    setState(() {
      print('==========> toggle is : ${_toggleValue}');
      _emergencyToggleController.toggleEmergencyDoctor(isEmergency: '$_toggleValue');
      _toggleValue = !_toggleValue;
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: AppString.settings,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeDefault.h,
            horizontal: Dimensions.paddingSizeDefault.w),
        child: Column(
          children: [

            Get.parameters['role'] == 'doctor' ?
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(16.r)),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                  title: CustomText(
                      maxline: 2,
                      text: 'Available for Emergency Consultation',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                  trailing: ToggleRadioButton(
                    toggleValue: _toggleValue,
                    onToggle: _toggleButton,
                  ),
                ),
              ),
            ) : SizedBox(),
            _ListTile(AppString.changePassword, AppIcons.rightArrow, () {
              Get.toNamed(AppRoutes.changePasswordScreen);
            }),
            _ListTile(AppString.termsOfServices, AppIcons.rightArrow, () {
              Get.toNamed(AppRoutes.allPrivacyPolicyScreen,
                  parameters: {"screenType": AppString.termsOfServices});
            }),
            _ListTile(AppString.privacyPolicys, AppIcons.rightArrow, () {
              Get.toNamed(AppRoutes.allPrivacyPolicyScreen,
                  parameters: {"screenType": AppString.privacyPolicys});
            }),
            _ListTile(AppString.aboutUs, AppIcons.rightArrow, () {
              Get.toNamed(AppRoutes.allPrivacyPolicyScreen,
                  parameters: {"screenType": AppString.aboutUs});
            }),



            SizedBox(height: 16.h),
            ///================about us================>
            CustomListTile(
              title: "Delete Account",
              onTap: () {

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 26.h),
                          content: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: "Do you want to delete your account?",
                                  fontsize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  maxline: 2,
                                  bottom: 12.h,
                                ),

                                CustomText(
                                  text: "All your changes will be deleted and you will no longer be able to access them.",
                                  fontsize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  maxline: 3,
                                  bottom: 20.h,
                                ),

                                Obx(
                                      () => CustomTextFieldWithoutBorder(
                                    maxLines: 1,
                                    contenpaddingHorizontal: 20.w,
                                    contenpaddingVertical: 0,
                                    controller: passWordCtrl,
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
                                                color: passWordCtrl.text.isNotEmpty
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
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 120.w,
                                        height: 40.h,
                                        child: CustomButton(
                                          title: 'Cancel',
                                          textStyle: const TextStyle(color: Colors.black),
                                          onpress: () {
                                            passWordCtrl.clear();
                                            Get.back();
                                          },
                                          color: Colors.white38,
                                        )),
                                    SizedBox(
                                        width: 120.w,
                                        height: 40.h,
                                        child: CustomButton(
                                            color: AppColors.primaryColor,
                                            title: 'Delete',
                                            onpress: () async {
                                              if(formKey.currentState!.validate()){
                                                _emergencyToggleController.accountDelete(password: passWordCtrl.text.toString());
                                              }
                                            })),
                                  ],
                                )
                              ],
                            ),
                          ),
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: BorderSide(
                                  width: 1.w, color: AppColors.primaryColor)));
                    });
              },
            )



          ],
        ),
      ),
    );
  }

  Widget _ListTile(String title, leadingIcon, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(16.r)),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20.w, right: 20.w),
            title: CustomText(
                maxline: 2,
                text: title,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            trailing: SvgPicture.asset(leadingIcon,
                height: 20.h,
                width: 20.w,
                fit: BoxFit.cover,
                color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

class AnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  AnimatedToggle({
    required this.values,
    required this.onToggleCallback,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  });

  @override
  _AnimatedToggleState createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  bool initialPosition = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 60,
      margin: const EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              initialPosition = !initialPosition;
              var index = 0;
              if (!initialPosition) {
                index = 1;
              }
              widget.onToggleCallback(index);
              setState(() {});
            },
            child: Container(
              width: 20.w,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        fontSize: Get.width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xAA000000),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment:
                initialPosition ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              width: 20.w,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Get.width * 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                initialPosition ? widget.values[0] : widget.values[1],
                style: TextStyle(
                  fontSize: Get.width * 0.045,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
