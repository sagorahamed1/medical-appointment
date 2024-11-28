import 'package:doctor_appointment/controllers/user/home_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
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
import 'package:timeago/timeago.dart' as TimeAgo;

class UserDoctorDetailsScreen extends StatelessWidget {
  UserDoctorDetailsScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    _homeController.getDoctorDetailsHomeScreen(id: '${Get.parameters['id']}');
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
          child: Obx(() {
            var doctorInfo = _homeController.doctorDetails.value;
            return
              _homeController.doctorDetailsLoading.value ?
               Center(child: Padding(
                padding: EdgeInsets.only(top: 300.h),
                child: const CustomLoader(),
              )) :
              _homeController.doctorDetails == null ? Image.asset(
                  AppImages.noDataImage) :
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ======================top Doctor Box Card==========================>
                  TopDoctorBoxCard(
                    image: doctorInfo.doctorId?.image?.publicFileUrl,
                    doctorName: '${doctorInfo.doctorId?.firstName} ${doctorInfo.doctorId?.lastName}',
                    location: doctorInfo.clinicAddress,
                    specialist: doctorInfo.specialist,
                  ),

                  SizedBox(height: 16.h),

                  ///======================Rating and Experience Card====================>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ratingExperience(
                          '${doctorInfo.experience}', "Years experience", AppIcons.experienceIcon),
                      _ratingExperience('${doctorInfo.doctorId?.rating}', "Rating", AppIcons.star),
                      _ratingExperience(
                          '${doctorInfo.doctorId?.reviewCount}', "Reviews", AppIcons.messageIcon),
                    ],
                  ),

                  ///===============================Custom Two Text==================================>
                  _customTwoText(
                    AppString.aboutDoctor,
                    '${doctorInfo.about}',
                  ),


                  CustomText(
                      text: 'Working Time',
                      fontWeight: FontWeight.w600,
                      fontsize: 18.h,
                      color: Colors.black,
                      top: 16.h,
                      bottom: 8.h),

                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctorInfo.allSchedule?.length,
                      itemBuilder: (context, index) {
                        var timeSchedule = doctorInfo.allSchedule![index];
                        return
                          CustomText(
                            text: '${timeSchedule.day}, ${timeSchedule.startTime} - ${timeSchedule.endTime}',
                            color: AppColors.textColor5C5C5C,
                            bottom: 5.h,
                            textAlign: TextAlign.start,
                          );

                      },
                    ),
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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: doctorInfo.topReviews?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var review = doctorInfo.topReviews![index];
                      return TopReviewsCard(
                        image: AppImages.getStarted2,
                        description: '${review.comment}',
                        rathing: "${review.rating}",
                        reviewName: "${review.patientId?.firstName} ${review.patientId?.lastName}",
                        timeAgo: TimeAgo.format(review.createdAt ?? DateTime.now()),
                      );
                    },
                  ),

                  ///===========================Button=============================>
                  SizedBox(height: 20.h),
                  CustomButton(onpress: () {
                    print("====================> ${doctorInfo.doctorId?.isEmergency}");
                    if(doctorInfo.doctorId?.isEmergency == true && Get.parameters['emergencyDoctor'] == 'emergencyDoctor'){
                      Get.toNamed(
                          AppRoutes.userPatientDetailsScreen,
                          arguments: doctorInfo,
                          parameters: {
                            'id':
                            '${doctorInfo.doctorId?.id}',
                            'isEmergency' : 'true'
                          });
                    }else{
                      Get.toNamed(AppRoutes.userSelectPackageScreen, arguments: doctorInfo, parameters: {
                        'id' : '${Get.parameters['id']}'
                      });
                    }
                  }, title: AppString.bookAppointment)
                ],
              );
          }),
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
