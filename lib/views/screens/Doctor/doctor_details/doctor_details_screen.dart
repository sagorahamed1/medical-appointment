import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controllers/doctor/doctor_details_controller_doctor_part.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_doctor_time_available_card.dart';
import '../../../widgets/custom_text.dart';
import '../doctor_edit_details_prfile/doctor_edit_details_profile_screen.dart';

class DoctorDetailsProfileScreen extends StatelessWidget {
  DoctorDetailsProfileScreen({super.key});

  TextEditingController controller = TextEditingController();
  DoctorDetailsControllerDoctorPart doctorDetailsCtrl =
      Get.put(DoctorDetailsControllerDoctorPart());

  @override
  Widget build(BuildContext context) {
    doctorDetailsCtrl.getDoctorDetails();
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
          child: Obx(() {
            var doctorData = doctorDetailsCtrl.doctorDetailsLoading.value;
            return doctorDetailsCtrl.doctorDetailsLoading.value
                ? const CustomLoader()
                : Column(
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
                          hintText:
                              "${doctorDetailsCtrl.doctorDetails.value.specialist}",
                          controller: controller),

                      SizedBox(height: 16.h),
                      CustomTextFieldWithoutBorder(
                          readOnly: true,
                          contenpaddingHorizontal: 20,
                          contenpaddingVertical: 0,
                          hintText:
                              "${doctorDetailsCtrl.doctorDetails.value.experience}",
                          controller: controller),

                      SizedBox(height: 16.h),
                      CustomTextFieldWithoutBorder(
                          readOnly: true,
                          maxLines: 4,
                          contenpaddingHorizontal: 20,
                          contenpaddingVertical: 15,
                          hintText:
                              "${doctorDetailsCtrl.doctorDetails.value.clinicAddress}",
                          controller: controller),

                      SizedBox(height: 16.h),
                      CustomTextFieldWithoutBorder(
                          readOnly: true,
                          maxLines: 4,
                          contenpaddingHorizontal: 20,
                          contenpaddingVertical: 15,
                          hintText:
                              "${doctorDetailsCtrl.doctorDetails.value.about}",
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

                      ListView.builder(
                        itemCount: doctorDetailsCtrl
                            .doctorDetails.value.schedule?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var doctorSchedule = doctorDetailsCtrl
                              .doctorDetails.value.schedule?[index];
                          return CustomDoctorTimeAvailableCard(
                            startTime: "${doctorSchedule?.startTime}",
                            endTime: "${doctorSchedule?.endTime}",
                            dayName: "${doctorSchedule?.day}",
                          );
                        },
                      ),

                      //
                      //  CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.monday,
                      // ),
                      //
                      // const CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.thursday,
                      // ),
                      //
                      // const CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.thursday,
                      // ),
                      //
                      // const CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.friday,
                      // ),
                      //
                      // const CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.saturday,
                      // ),
                      //
                      //
                      // const CustomDoctorTimeAvailableCard(
                      //   startTime: "8.00 AM",
                      //   endTime: "10.00 AM",
                      //   dayName: AppString.sunday,
                      // ),

                      SizedBox(height: 20.h),

                      CustomButton(
                          onpress: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>DoctorEditDetailsProfileScreen(doctorData: doctorDetailsCtrl.doctorDetails.value) ));
                          },
                          title: AppString.editDetails),

                      SizedBox(height: 35.h)
                    ],
                  );
          }),
        ),
      ),
    );
  }
}
