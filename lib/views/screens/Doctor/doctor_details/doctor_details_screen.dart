import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class DoctorDetailsProfileScreen extends StatelessWidget {
  DoctorDetailsProfileScreen({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.appointments,
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
              CustomText(
                  text: AppString.pleaseFillUpTheDetailsToJoinAsDoctor,
                  fontsize: 18.h,
                  color: Colors.black,
                  maxline: 2,
                  bottom: 15.h,
                  textAlign: TextAlign.start),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  readOnly: true,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "Cardiologists",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  readOnly: true,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "2 Years Experience",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  readOnly: true,
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  readOnly: true,
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  controller: controller),

              ///=======================Avoidable Doctors=====================>
              CustomText(
                  text: AppString.availableDoctors,
                  top: 16.h,
                  bottom: 10.h,
                  fontsize: 16.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.start),

              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.monday,
              ),

              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.thursday,
              ),

              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.thursday,
              ),

              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.friday,
              ),

              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.saturday,
              ),


              const DoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.sunday,
              ),

              SizedBox(height: 20.h),

              CustomButton(onpress: (){}, title: AppString.editDetails),

              SizedBox(height: 35.h)
            ],
          ),
        ),
      ),
    );
  }
}

class DoctorTimeAvailableCard extends StatelessWidget {
  final String? dayName;
  final String? startTime;
  final String? endTime;

  const DoctorTimeAvailableCard(
      {super.key, this.dayName, this.startTime, this.endTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: " $dayName", color: Colors.black, bottom: 14.h, top: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 167.w,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 10.w),
                        child: SvgPicture.asset(AppIcons.chock,
                            width: 18.w, height: 18.h, fit: BoxFit.cover, color: AppColors.primaryColor),
                      ),
                      CustomText(
                          text: '$startTime', color: AppColors.primaryColor),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Divider(),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 167.w,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 7.w, right: 10.w),
                        child: SvgPicture.asset(AppIcons.chock,
                            width: 18.w, height: 18.h, fit: BoxFit.cover, color: AppColors.primaryColor),
                      ),
                      CustomText(
                          text: '$endTime', color: AppColors.primaryColor),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: const Divider(),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
