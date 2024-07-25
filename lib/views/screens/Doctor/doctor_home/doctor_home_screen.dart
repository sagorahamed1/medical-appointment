import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/screens/Doctor/doctor_home/inner_widgets/doctor_top_app_bar.dart';
import 'package:doctor_appointment/views/screens/User/User_Appointments/user_appointments_screen.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/doctor_home_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_strings.dart';

class DoctorHomeScreen extends StatelessWidget {
   DoctorHomeScreen({super.key});

  final DoctorHomeControllerDoctorPart _homeController = Get.put(DoctorHomeControllerDoctorPart());

  @override
  Widget build(BuildContext context) {
    _homeController.getAppointment(status: 'upcomming');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            children: [
              const DoctorTopAppBar(),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topCard("Total Appointments", '800'),
                  _topCard("Completed", '800'),
                  _topCard("Cancelled", '800'),
                ],
              ),

              ///=======================Categories and See All Text=============================>
              _SeeAll(AppString.recentAppointments, AppString.seeAll, () {
                // Get.toNamed(AppRoutes.userCategoryScreen);
              }),


              Expanded(
                child: Obx(()=>
                _homeController.appointmentLoading.value ? const CustomLoader() : _homeController.appointmentsList.isEmpty ? Image.asset(AppImages.noDataImage) :
                  ListView.builder(
                    itemCount: _homeController.appointmentsList.length,
                    itemBuilder: (context, index) {
                      var appointment = _homeController.appointmentsList[index];
                      return Padding(
                        padding:  EdgeInsets.only(bottom: 16.h),
                        child: AppointmentsCard(
                          rightBtnOnTap: () {
                            Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen);
                          },
                          leftBtnOnTap: () {},
                          image: AppImages.getStarted1,
                          name: "${appointment.patientId?.firstName} ${appointment.patientId?.lastName}",
                          messageIcon: AppIcons.messageIcon2,
                          appointmentsType: "${appointment.status}",
                          rightBtnName: "See Details",
                          leftBtnName: "Cancel Appointment",
                          date: DateTime.now(),
                          time: TimeFormatHelper.timeFormat(appointment.createdAt!),
                        ),
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _topCard(String title, howMany) {
    return Container(
      width: 112.w,
      decoration: BoxDecoration(
          color: AppColors.fillColorE8EBF0,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: AppColors.primaryColor)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            CustomText(text: title, fontsize: 10.h, color: Colors.black),
            CustomText(
                text: howMany,
                fontsize: 16.h,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }

  Widget _SeeAll(String leftText, seeAllText, VoidCallback ontap) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: leftText,
                fontsize: 18.h,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            GestureDetector(
              onTap: ontap,
              child: CustomText(
                  text: seeAllText,
                  fontsize: 16.h,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
