import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/user/home_controller.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';




class UserAvailablleDoctorsScreen extends StatelessWidget {
  UserAvailablleDoctorsScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.availableDoctors,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return    Padding(
                      padding:  EdgeInsets.only(bottom: 16.h),
                      child: const AvailableDoctorsCard(
                        experience: "6 years",
                        rating: "4.0",
                        clinicVisit: r"$20",
                        doctorName: "Sagor Ahamed",
                        totalConsultaion: "12",
                        onlineConsultation: r'$50',
                        specialist: "Therapist",
                        imageHeight: 142,
                        leftBtnText: AppString.seeDetails,
                        rightBtnText: AppString.bookAppointment,
                      ),
                    );
                  },
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
