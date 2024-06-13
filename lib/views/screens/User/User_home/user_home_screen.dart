import 'package:doctor_appointment/controllers/home_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/categorySection.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/top_app_bar.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w, vertical: 8.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=====================top app bar =================================>
            
                const TopAppBar(),
            
                CustomText(
                    text: AppString.enhancingTheHealthcareExperience,
                    fontWeight: FontWeight.w600,
                    fontsize: 16.h,
                    bottom: 16.h,
                    top: 20.h),

                ///========================Search box=============================>
                CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 0,
                  controller: _homeController.searchCtrl,
                  hintText: AppString.search,
                  prefixIcon: GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoutes.userSearchScreen);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SvgPicture.asset(AppIcons.search),
                    ),
                  ),
                ),
            
                ///=======================Categories and See All Text=============================>
                _SeeAll(AppString.categories, AppString.seeAll, (){
                  Get.toNamed(AppRoutes.userCategoryScreen);
                }),
            
                const Categorysection(),
            
                ///=======================available Doctors and See All Text=============================>
                _SeeAll(AppString.availableDoctors, AppString.seeAll, (){
                  Get.toNamed(AppRoutes.availablleDoctorsScreen);
                }),


                SizedBox(
                  height: 230.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return    const AvailableDoctorsCard(
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
                      );
                    },
                  ),
                ),


                ///=======================Emergency Doctors and See All Text=============================>
                _SeeAll(AppString.emergencyDoctors, AppString.seeAll, (){
                  Get.toNamed(AppRoutes.emergencyDoctorsScreen);
                }),
            
            
                const AvailableDoctorsCard(
                  rating: "4.0",
                  doctorName: "Sagor Ahamed",
                  specialist: "Cardiologist",
                  onlineConsultation: r'$20',
                  totalConsultaion: '12',
                  imageHeight: 100,
                  leftBtnText: AppString.message,
                  rightBtnText: AppString.videoCall,
                ),
            
              ],
            ),
          ),
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
