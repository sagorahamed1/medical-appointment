
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import 'custom_text.dart';

class CustomDoctorTimeAvailableCard extends StatelessWidget {
  final String? dayName;
  final String? startTime;
  final String? endTime;
  final VoidCallback? onTapStart;
  final VoidCallback? onTapEnd;

  const CustomDoctorTimeAvailableCard(
      {super.key, this.dayName, this.startTime, this.endTime, this.onTapStart, this.onTapEnd});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: " $dayName", color: Colors.black, bottom: 14.h, top: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onTapStart,
              child: SizedBox(
                width: 167.w,
                child: Column(
                  children: [
                    ///===================Start Time============>
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w, right: 10.w),
                          child: SvgPicture.asset(AppIcons.chock,
                              width: 18.w, height: 18.h, fit: BoxFit.cover, color: AppColors.primaryColor),
                        ),
                        CustomText(
                            text: '$startTime', color: AppColors.primaryColor),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: const Divider(),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onTapEnd,
              child: SizedBox(
                width: 167.w,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 7.w, right: 10.w),
                          child: SvgPicture.asset(AppIcons.chock,
                              width: 18.w, height: 18.h, fit: BoxFit.cover, color: AppColors.primaryColor),
                        ),
                        CustomText(
                            text: '$endTime', color: AppColors.primaryColor),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: const Divider(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
