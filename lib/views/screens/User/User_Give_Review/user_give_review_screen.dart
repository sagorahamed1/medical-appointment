import 'package:doctor_appointment/controllers/user/give_review_controller.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserGiveReviewScreen extends StatelessWidget {
   UserGiveReviewScreen({super.key});

  TextEditingController comment = TextEditingController();
  final GiveReviewController giveReviewController = Get.put(GiveReviewController());
  late double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.giveReview,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
        
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ///====================Image======================>
                    Image.asset(AppImages.getStarted1,
                        height: 160.h, width: 160.w, fit: BoxFit.cover),
        
                    CustomText(
                        text: AppString.howWasYourExperienceWithDr,
                        fontsize: 20.h,
                        fontWeight: FontWeight.w600,
                        top: 24.h,
                        bottom: 24.h,
                        maxline: 2),
        
                    ///==========================Star===========================>
        
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 1,
                      unratedColor: const Color(0xffC0C0C0),
                      itemCount: 5,
                      updateOnDrag: true,
                      wrapAlignment: WrapAlignment.start,
                      itemSize: 40.h,
                      itemBuilder: (context, index) {
                        return const Icon(Icons.star, color: Color(0xffFFB701));
                      },
                      onRatingUpdate: (value) {
                        rating = value;
                      },
                    ),
        
                  ],
                ),
              ),
        
              ///===================Write your problem===================>
              CustomText(
                  text: AppString.writeYourProblem,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  top: 24.h,
                  bottom: 16.h),
        
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 16,
                  controller: comment,
                hintText: 'Your review here...',
                maxLines: 4,
              ),
        
        
              SizedBox(height: 86.h),
        
              CustomButton(onpress: (){
                print("=====$rating");
                 giveReviewController.giveReview(rating: '$rating', comment: '${comment.text}', doctorId: '${Get.parameters['id']}');
              }, title: AppString.submitReview)
            ],
          ),
        ),
      ),
    );
  }
}
