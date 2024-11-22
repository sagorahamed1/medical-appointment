import 'package:doctor_appointment/controllers/user/see_details_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_doctor_details/Inner_widgets/top_doctor_box_card.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_select_package_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserAppointmentsDetailsScreen extends StatelessWidget {
  UserAppointmentsDetailsScreen({super.key});

  final SeeDetailsController _seeDetailsController =
      Get.put(SeeDetailsController());

  @override
  Widget build(BuildContext context) {
    _seeDetailsController.getSeeDetails(id: '${Get.parameters['id']}');
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
            var data = _seeDetailsController.seeDetails.value;
            return _seeDetailsController.doctorSeeDetailsLoading.value
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.only(top: 280.h),
                    child: const CustomLoader(),
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TopDoctorBoxCard(
                        image: "${data.doctorId?.image?.publicFileUrl}",
                        doctorName: "${data.doctorId?.firstName} ${data.doctorId?.lastName}",
                        rating: '${data.doctorId?.rating}',
                        specialist: '${data.doctorId?.phone}',
                        location: '${data.doctorId?.address}',
                      ),

                      ///===================Scheduled Appointment===================>
                      CustomText(
                          text: AppString.scheduledAppointment,
                          fontWeight: FontWeight.w600,
                          fontsize: 18.h,
                          top: 20.h,
                          bottom: 16.h),

                      CustomText(
                          text: TimeFormatHelper.formatDate(data.date!),
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

                      _leftAndRightText(AppString.fullName, "${data.patientDetailsId?.fullName}"),
                      _leftAndRightText(AppString.gender, "${data.patientDetailsId?.gender}"),
                      _leftAndRightText(AppString.age, "${data.patientDetailsId?.age}"),
                      _leftAndRightText(AppString.problem, "${data.patientDetailsId?.description}"),

                      ///===================Your Package===================>
                      CustomText(
                          text: AppString.yourPackage,
                          fontWeight: FontWeight.w600,
                          fontsize: 18.h,
                          top: 20.h,
                          bottom: 16.h),

                      CustomSelectPackageCard(
                          title: "${data.package?.packageName}",
                          icon: "${data.package?.packageName}".toLowerCase() == 'clinicprice' ?  AppIcons.videoCallIcons : AppIcons.personGroup,
                          price: '${data.package?.packagePrice}',
                          description: "${data.package?.packageName}".toLowerCase() == 'clinicprice' ? 'Video call & messages with doctor' : "Virtual visit in doctors clinic"  ,
                          selectedIndex: 1,
                          onTap: () {}),

                      SizedBox(height: 20.h),

                      // CustomButton(
                      //     onpress: () {}, title: AppString.completeAppointment)
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
