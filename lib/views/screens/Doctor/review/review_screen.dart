import 'package:doctor_appointment/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import 'Inner_widgets/progress_ratingIndicator.dart';


class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: const TopReviewsCardForProfile(
                          image: AppImages.getStarted1,
                          description: "Dr. Jenny is very professional in her work and responsive. I have consulted and my problem is solved. 😍😍",
                          rathing: "4.5",
                          reviewName: "Swapon",
                          timeAgo: "1 month ago",
                        ),
                      );
                    },
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
