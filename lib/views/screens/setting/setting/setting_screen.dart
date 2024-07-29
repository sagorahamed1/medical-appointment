import 'package:doctor_appointment/routes/app_routes.dart';
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
import '../../../widgets/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final EmergencyToggleController _emergencyToggleController = Get.put(EmergencyToggleController());
  bool _toggleValue = false;

  @override
  void initState() {
    super.initState();
    // Convert the string parameter to a boolean
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
