import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../widgets/custom_text.dart';


class WalletAmountCard extends StatelessWidget {
  final String? title;
  final double? amount;

  const WalletAmountCard({super.key, this.title, this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 166.h,
      width: 158.w,
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 140.h,
              width: 158.w,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(20.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 52.h),
                      CustomText(text: '$title', fontsize: 16.h, bottom: 4.h),
                      CustomText(
                          text: '\$$amount',
                          fontsize: 18.h,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0.w,
              right: 0.w,
              child: Container(
                height: 65.h,
                width: 65.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: AppColors.fillColorE8EBF0,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryColor)),
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.5, vertical: 16.h),
                  child: SvgPicture.asset(AppIcons.walletIcon,
                      color: AppColors.primaryColor),
                ),
              ))
        ],
      ),
    );
  }
}