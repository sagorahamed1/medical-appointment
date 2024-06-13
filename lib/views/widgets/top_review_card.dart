
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import 'custom_text.dart';

class TopReviewsCard extends StatelessWidget {
  final String? image;
  final String? description;
  final String? timeAgo;
  final String? rathing;
  final String? reviewName;

  const TopReviewsCard(
      {super.key,
        this.image,
        this.description,
        this.timeAgo,
        this.rathing,
        this.reviewName});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          bottom: 16.h,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
