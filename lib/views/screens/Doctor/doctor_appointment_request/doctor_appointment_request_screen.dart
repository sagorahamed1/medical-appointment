import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/screens/Doctor/doctor_appointments/doctor_appointments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class DoctorAppointmentRequestScreen extends StatelessWidget {
  const DoctorAppointmentRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
          title: CustomText(
        text: AppString.appointmentRequests,
        fontsize: 18.h,
        fontWeight: FontWeight.w600,
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: AppointmentsCard(
                      image: AppImages.getStarted1,
                      time: "14:00 PM",
                      messageIcon: AppIcons.messageIcon2,
                      appointmentsType: 'upcomming',
                      leftBtnName: "See Details",
                      rightBtnName: "Accept",
                      name: "Sagor Ahamed",
                      leftBtnOnTap: () {
                        Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen, parameters: {
                          'screenType' : "appointment Request"
                        });
                      },
                      rightBtnOnTap: () {},
                      date: DateTime.now(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
