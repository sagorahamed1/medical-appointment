import 'package:doctor_appointment/controllers/user/give_review_controller.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import 'Inner_widgets/progress_ratingIndicator.dart';
import 'package:timeago/timeago.dart' as TimeAgo;



class ReviewScreen extends StatelessWidget {
   ReviewScreen({super.key});

  GiveReviewController giveReviewController = Get.put(GiveReviewController());

  @override
  Widget build(BuildContext context) {
    giveReviewController.getReviews();
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.reviews,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  const progressRatingIndicator(),
                  SizedBox(height: 24.h),

                  Obx(()=>
                      giveReviewController.getReviewLoading.value ? Padding(
                        padding:  EdgeInsets.only(top: 200.h),
                        child: const CustomLoader(),
                      ) :
                      giveReviewController.reviews.isEmpty ? CustomText(text: "No Review Yet!", top: 200) :
                      ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: giveReviewController.reviews.length,
                      itemBuilder: (context, index) {
                        var review = giveReviewController.reviews[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child:  TopReviewsCardForProfile(
                            image: AppImages.getStarted1,
                            description: "${review.comment}",
                            rathing: "${review.rating}",
                            reviewName: "${review.patientId?.firstName} ${review.patientId?.lastName}",
                            timeAgo: TimeAgo.format(review.createdAt ?? DateTime.now()),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
      ,
    );
  }
}




class TopReviewsCardForProfile extends StatelessWidget {
  final String? image;
  final String? description;
  final String? timeAgo;
  final String? rathing;
  final String? reviewName;

  const TopReviewsCardForProfile(
      {super.key,
        this.image,
        this.description,
        this.timeAgo,
        this.rathing,
        this.reviewName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.fillColorE8EBF0,
      ),
      child: Padding(
        padding:  EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///========================Image and Name======================>
                Row(
                  children: [
                    Container(
                        height: 48.h,
                        width: 48.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.asset(
                          '$image',
                          fit: BoxFit.cover,
                        )),
                    CustomText(
                      text: "$reviewName",
                      fontsize: 16.h,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      left: 16.w,
                    )
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.primaryColor)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppIcons.star),
                        CustomText(
                            text: "  $rathing",
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor)
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            CustomText(
              text: "$description",
              color: AppColors.textColor5C5C5C,
              maxline: 10,
              bottom: 12.h,
              textAlign: TextAlign.start,
            ),
            CustomText(
              text: '$timeAgo',
              color: AppColors.textColor5C5C5C,
              maxline: 10,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
