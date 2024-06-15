import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_doctor_details/Inner_widgets/top_doctor_box_card.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_select_package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserAppointmentsDetailsScreen extends StatelessWidget {
  const UserAppointmentsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.appointmentDetails,
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
              TopDoctorBoxCard(),
        
              ///===================Scheduled Appointment===================>
              CustomText(
                  text: AppString.scheduledAppointment,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  top: 20.h,
                  bottom: 16.h),
        
              CustomText(
                  text: 'Today, December 22, 2022',
                  fontsize: 16.h,
                  color: AppColors.textColor5C5C5C),
              CustomText(
                  text: '16:00 PM',
                  fontsize: 16.h,
                  color: AppColors.textColor5C5C5C,
                  top: 12.h),
        
              ///===================Patient Information===================>
              CustomText(
                  text: AppString.patientInformation,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  top: 20.h,
                  bottom: 16.h),
        
              _leftAndRightText(AppString.fullName, "Sagor Ahamed"),
              _leftAndRightText(AppString.gender, "Male"),
              _leftAndRightText(AppString.age, "25"),
              _leftAndRightText(AppString.problem,
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor. "),
        
              ///===================Your Package===================>
              CustomText(
                  text: AppString.yourPackage,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  top: 20.h,
                  bottom: 16.h),
        
              CustomSelectPackageCard(
                  title: "Online Consultation",
                  icon: AppIcons.videoCallIcons,
                  price: 400,
                  description: "Video call & messages with doctor",
                  selectedIndex: 1,
                  onTap: () {}),

              SizedBox(height: 20.h),
        
              CustomButton(onpress: () {}, title: AppString.completeAppointment)
            ],
          ),
        ),
      ),
    );
  }

  Widget _leftAndRightText(String leftText, rightText) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: '${leftText}  : ',
              fontsize: 16.h,
              color: AppColors.textColor5C5C5C),
          SizedBox(
              width: 252.w,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                      text: ' $rightText',
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C,
                      maxline: 10,
                      textAlign: TextAlign.start))),
        ],
      ),
    );
  }
}
