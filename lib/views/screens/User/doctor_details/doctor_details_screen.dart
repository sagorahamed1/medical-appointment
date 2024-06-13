import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/top_review_card.dart';
import 'Inner_widgets/top_doctor_box_card.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ======================top Doctor Box Card==========================>
              TopDoctorBoxCard(),
          
              SizedBox(height: 16.h),
          
              ///======================Rating and Experience Card====================>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ratingExperience(
                      '10+', "Years experience", AppIcons.experienceIcon),
                  _ratingExperience('4.5', "Rating", AppIcons.star),
                  _ratingExperience('4,942', "Reviews", AppIcons.messageIcon),
                ],
              ),
          
              ///===============================Custom Two Text==================================>
              _customTwoText(
                AppString.aboutDoctor,
                'Dr. Jenny Watson is the top most Immunologists specialist in Christ Hospital at London. She achived several awards for her wonderful contribution in medical field. She is available for private consultation.',
              ),
              _customTwoText(
                AppString.workingTime,
                'Monday - Friday, 08.00 AM - 20.00 PM',
              ),
          
              ///======================Top Review Text=========================>
              CustomText(
                  text: AppString.topReviews,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  color: Colors.black,
                  top: 16.h,
                  bottom: 16.h),
          
              ///=============================Top Review List views=======================>
              SizedBox(
                height: 490.h,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const TopReviewsCard(
                      image: AppImages.getStarted2,
                      description:
                          'Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved. 😍😍',
                      rathing: "5",
                      reviewName: "Sagor Ahamed",
                      timeAgo: "2 days ago",
                    );
                  },
                ),
              ),
          
              ///===========================Button=============================>
              SizedBox(height: 20.h),
              CustomButton(onpress: () {
                Get.toNamed(AppRoutes.selectPackageScreen);
              }, title: AppString.bookAppointment)
            ],
          ),
        ),
      ),
    );
  }

  Widget _ratingExperience(String rating, experience, icon) {
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.fillColorE8EBF0),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: SvgPicture.asset(
                icon,
                color: AppColors.primaryColor,
                height: 23.h,
                width: 23.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomText(
              text: rating,
              fontWeight: FontWeight.w600,
              fontsize: 16.h,
              color: AppColors.primaryColor,
              top: 4.h,
              bottom: 4.h),
          CustomText(
              text: experience,
              fontWeight: FontWeight.w600,
              fontsize: 12.h,
              color: AppColors.textColor5C5C5C,
              top: 4.h,
              bottom: 4.h),
        ],
      ),
    );
  }

  Widget _customTwoText(String title, description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: title,
            fontWeight: FontWeight.w600,
            fontsize: 18.h,
            color: Colors.black,
            top: 16.h,
            bottom: 8.h),
        CustomText(
          text: description,
          color: AppColors.textColor5C5C5C,
          maxline: 10,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
