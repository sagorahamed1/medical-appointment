import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/home_controller.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';

class UserEmergencyDoctorsScreen extends StatelessWidget {
  UserEmergencyDoctorsScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.emergencyDoctors,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: const AvailableDoctorsCard(
                        rating: "4.0",
                        doctorName: "Sagor Ahamed",
                        specialist: "Cardiologist",
                        onlineConsultation: r'$20',
                        totalConsultaion: '12',
                        imageHeight: 100,
                        leftBtnText: AppString.message,
                        rightBtnText: AppString.videoCall,
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
