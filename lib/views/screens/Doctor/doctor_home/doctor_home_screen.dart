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
import '../../../../controllers/profile_controler.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_strings.dart';

class DoctorHomeScreen extends StatelessWidget {
   DoctorHomeScreen({super.key});

  final DoctorHomeControllerDoctorPart _homeController = Get.put(DoctorHomeControllerDoctorPart());
   final ProfileControler _profileControler = Get.put(ProfileControler());

  @override
  Widget build(BuildContext context) {
    _homeController.getDoctorStatus();
    _profileControler.getProfile();
    // _homeController.getAppointment(status: 'upcomming');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
          child: Column(
            children: [

             Obx((){
               var profileData = _profileControler.profileInfo.value;
              return Column(
                 children: [
                    DoctorTopAppBar(
                     image: profileData.image?.publicFileUrl,
                      name: '${profileData.firstName} ${profileData.lastName}',
                   ),
                   SizedBox(height: 20.h),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       _topCard("Total Appointments","${_homeController.status.value.totalAppointments}"),
                       _topCard("Active", "${_homeController.status.value.activeAppointments}"),
                       _topCard("Completed", "${_homeController.status.value.completedAppointments}"),
                     ],
                   ),

                 ],
               );
             },
             ) ,


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
                          btnOntap: () {
                            Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen, parameters: {
                              'id' : '${appointment.id}',
                              'type' : 'upcomming'
                            });
                          },
                          btnName: 'See Details',
                          leftBtnOnTap: () {},
                          image: '${appointment.patientId?.image?.publicFileUrl}',
                          name: "${appointment.patientId?.firstName} ${appointment.patientId?.lastName}",
                          appointmentsType: "${appointment.status}",
                          date: appointment.date,
                          time: '${appointment.timeSlot}',
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
