import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/categorySection.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/top_app_bar.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  TextEditingController searchCtrl = TextEditingController();

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
            
                CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 0,
                  controller: searchCtrl,
                  hintText: AppString.search,
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SvgPicture.asset(AppIcons.search),
                  ),
                ),
            
                ///=======================Categories and See All Text=============================>
                _SeeAll(AppString.categories, AppString.seeAll),
            
                const Categorysection(),
            
                ///=======================available Doctors and See All Text=============================>
                _SeeAll(AppString.availableDoctors, AppString.seeAll),


                SizedBox(
                  height: 230.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return    const AvailableDoctorsCard(
                        experience: "kk",
                        rating: "4.0",
                        clinicVisit: "dkdk",
                        doctorName: "Sagor Ahamed",
                        specialist: "dkdkdk",
                        imageHeight: 142,
                      );
                    },
                  ),
                ),


                ///=======================Emergency Doctors and See All Text=============================>
                _SeeAll(AppString.availableDoctors, AppString.seeAll),
            
            
                const AvailableDoctorsCard(
                  experience: "kk",
                  rating: "4.0",
                  clinicVisit: "dkdk",
                  doctorName: "Sagor Ahamed",
                  specialist: "dkdkdk",
                  imageHeight: 100,
                ),
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _SeeAll(String leftText, seeAllText) {
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
            CustomText(
                text: seeAllText,
                fontsize: 16.h,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
