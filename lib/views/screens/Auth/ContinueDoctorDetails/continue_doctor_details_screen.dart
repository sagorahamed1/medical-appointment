import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_doctor_time_available_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class ContinueDoctorDetailsScreen extends StatelessWidget {
  ContinueDoctorDetailsScreen({super.key});

  TextEditingController specialistCtrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController aboutDoctorCtrl = TextEditingController();
  TextEditingController priceForClinicCtrl = TextEditingController();
  TextEditingController priceForOnlineCtrl = TextEditingController();
  TextEditingController priceForEmargenceCtrl = TextEditingController();

  final List<String> specialists = [
    'Dentist',
    'Immunologist',
    'Cardiologist',
    'Neurologist',
    'Orthopedic',
    'Ophthalmologist',
    'Therapist',
    'Nutritionist',
    'Gynecologic',
  ];


  final List<String> experience = [
    '1 Year',
    '2 Year',
    '3 Year',
    '4 Year',
    '5 Year',
    '6 Year',
    '7 Year',
    '8 Year',
    '9 Year',
    '10 Year',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.doctorDetails,
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
                  hintText: "Cardiologist",
                  sufixicons: PopUpMenu(
                    items: specialists,
                    selectedItem: "Dentist",
                    onTap: (int selceted){},

                  ),
                  controller: specialistCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "2 Years Experience",
                  sufixicons: PopUpMenu(
                    items: experience,
                    selectedItem: "1 Year",
                    onTap: (int selceted){},

                  ),
                  controller: experienceCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                  controller: addressCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  controller: aboutDoctorCtrl),

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




              SizedBox(height: 16.h),
              ///=======================Price for Clinic Controller ============================>
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,

                  hintText: "Set Price for clinic visit",
                  controller: priceForClinicCtrl),


              SizedBox(height: 16.h),
              ///=======================Price for Online Controller ============================>
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "Set Price for online consultatation",
                  controller: priceForOnlineCtrl),



              SizedBox(height: 16.h),
              ///=======================Price for emergency Controller ============================>
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "Set Price for emergency consultatation",
                  controller: priceForEmargenceCtrl),


              SizedBox(height: 20.h),

              CustomButton(onpress: (){
                Get.toNamed(AppRoutes.doctorBottomNavBar);
              }, title: AppString.continues),

              SizedBox(height: 35.h)
            ],
          ),
        ),
      ),
    );
  }
}
