import 'package:doctor_appointment/controllers/doctor/doctor_see_details_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_doctor_details/Inner_widgets/top_doctor_box_card.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_select_package_card.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/complete_appoinment_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../profile/profile/profile_screen.dart';

class DcotorAppointmentsDetailsScreen extends StatelessWidget {
  DcotorAppointmentsDetailsScreen({super.key});

  DoctorSeeDetailsController seeDetailsController = Get.put(DoctorSeeDetailsController());
  final CompleteAppointmentController _completeAppointmentController =
      Get.put(CompleteAppointmentController());

  @override
  Widget build(BuildContext context) {
    print("doctor part");
    seeDetailsController.getSeeDetails(id: '${Get.parameters['id']}');
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
          child: Obx(() {
            var data = seeDetailsController.seeDetails.value;
            return seeDetailsController.doctorSeeDetailsLoading.value
                ? const CustomLoader()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopDoctorBoxCard(
                        location: '${data.doctorId?.address}',
                        image: '${data.doctorId?.image?.publicFileUrl}',
                        doctorName:
                            "${data.doctorId?.firstName} ${data.doctorId?.lastName}",
                        specialist: "${data.specialist}",
                      ),

                      ///===================Scheduled Appointment===================>
                      CustomText(
                          text: AppString.scheduledAppointment,
                          fontWeight: FontWeight.w600,
                          fontsize: 18.h,
                          top: 20.h,
                          bottom: 16.h),

                      CustomText(
                          text: TimeFormatHelper.formatDate(
                              data.date ?? DateTime.now()),
                          fontsize: 16.h,
                          color: AppColors.textColor5C5C5C),
                      CustomText(
                          text: '${data.timeSlot}',
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

                      _leftAndRightText(AppString.fullName,
                          "${data.patientDetailsId?.fullName}"),
                      _leftAndRightText(
                          AppString.gender, "${data.patientDetailsId?.gender}"),
                      _leftAndRightText(
                          AppString.age, "${data.patientDetailsId?.age}"),
                      _leftAndRightText(AppString.problem,
                          "${data.patientDetailsId?.description}"),

                      ///===================Your Package===================>
                      CustomText(
                          text: AppString.yourPackage,
                          fontWeight: FontWeight.w600,
                          fontsize: 18.h,
                          top: 20.h,
                          bottom: 16.h),

                      CustomSelectPackageCard(
                          allIndex: 1,
                          title: "Online Consultation",
                          icon: AppIcons.videoCallIcons,
                          price: '400',
                          description: "Video call & messages with doctor",
                          selectedIndex: 1,
                          onTap: () {}),

                      SizedBox(height: 20.h),

                      Get.parameters['screenType'] == "appointment Request"
                          ? CustomTwoButon(
                              initialSeclected: 0,
                              btnRadius: 100,
                              btnNameList: const ['Cancel', 'Accept'],
                              rightBtnOnTap: () {},
                              leftBtnOnTap: () {},
                              width: 168.w,
                            )
                          : const SizedBox(),

                      ///===============Send Prescription=================>
                      Get.parameters['type'] == 'upcomming'
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.previousSoapNoteScreen);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: CustomText(
                                    text: "SOAP Notes",
                                    color: AppColors.primaryColor,
                                    top: 14.h,
                                    bottom: 14.h,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),

                      SizedBox(height: 16.h),

                      // ///===============Completed Button=================>
                      // data.prescription?.publicFileUrl != null ||
                      //         data.prescription?.publicFileUrl == ''
                      //     ?
                      CustomButton(
                              onpress: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 320.h,
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            CustomText(
                                                text: "SOAP Note",
                                                fontWeight: FontWeight.w600,
                                                fontsize: 20.h,
                                                color: AppColors.primaryColor,
                                                top: 35.h,
                                                bottom: 48.h),
                                            CustomText(
                                              maxline: 2,
                                                left: 12.w,
                                                right: 12.w,
                                                text:
                                                "You have completed the appointment, do you want to add new SOAP note?",
                                                fontsize: 18.h,
                                                color: Colors.black,
                                                bottom: 24.h),
                                            const TwoBottonBottomSheetAppointmentDetails(),
                                            SizedBox(height: 48.h)
                                          ],
                                        ),
                                      );
                                    });



                                // _completeAppointmentController.completeAppointment('${data.id}');
                              },
                              title: 'Completed'),
                          // : const SizedBox(),




                      SizedBox(height: 16.h),

                      ///===============Send Prescription=================>
                      Get.parameters['type'] == 'upcomming'
                          ? const SizedBox()
                          : CustomButton(
                              onpress: () {
                                Get.parameters['screenType'] == AppString.upcoming
                                    ? () {}
                                    : Get.toNamed(
                                        AppRoutes.prescriptionFormScreen,
                                        arguments: data);
                              },
                              title: Get.parameters['screenType'] ==
                                      AppString.upcoming
                                  ? AppString.continues
                                  : 'Send Prescription'),

                      SizedBox(height: 30.h)
                    ],
                  );
          }),
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




class TwoBottonBottomSheetAppointmentDetails extends StatelessWidget {
  const TwoBottonBottomSheetAppointmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 166.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: CustomText(
                    text: "Cancel",
                    fontsize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            Get.toNamed(AppRoutes.addSoapNoteScreen);
          },
          child: Container(
            width: 166.w,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: CustomText(
                    text: "Yes, I do",
                    fontsize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}