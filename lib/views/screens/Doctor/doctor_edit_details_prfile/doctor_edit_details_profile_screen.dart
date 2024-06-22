import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_doctor_time_available_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class DoctorEditDetailsProfileScreen extends StatelessWidget {
   DoctorEditDetailsProfileScreen({super.key});

  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.editDoctorDetails,
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
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "Cardiologists",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "2 Years Experience",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                  controller: controller),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
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

              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.monday,
              ),

              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.thursday,
              ),

              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.thursday,
              ),

              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.friday,
              ),

              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.saturday,
              ),


              const CustomDoctorTimeAvailableCard(
                startTime: "8.00 AM",
                endTime: "10.00 AM",
                dayName: AppString.sunday,
              ),

              SizedBox(height: 20.h),

              CustomButton(onpress: (){}, title: AppString.updateDetails),

              SizedBox(height: 35.h)
            ],
          ),
        ),
      ),
    );
  }
}
