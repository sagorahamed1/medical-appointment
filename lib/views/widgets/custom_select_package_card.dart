
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import 'custom_text.dart';

class CustomSelectPackageCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? description;
  final String? price;
  final int? selectedIndex;
  final int? allIndex;
  final VoidCallback onTap;

  const CustomSelectPackageCard(
      {super.key,
        this.icon,
        this.title,
        this.description,
        this.price,
        required this.onTap,
        this.selectedIndex,
        this.allIndex});

  @override
  Widget build(BuildContext context) {
    print("====================$allIndex and $selectedIndex");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: AppColors.fillColorE8EBF0,
            border: Border.all(
                color: selectedIndex == allIndex
                    ? AppColors.primaryColor
                    : AppColors.fillColorE8EBF0)),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffB8C1CF)),

                ///=======================Icon===========================>
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SvgPicture.asset(
                    '$icon',
                    height: 28.h,
                    width: 28.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(
                width: 190.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///===============================Title========================:>
                    CustomText(
                        text: "$title",
                        fontWeight: FontWeight.w600,
                        fontsize: 15.h),
                    SizedBox(height: 8.h),

                    ///===============================description========================:>
                    CustomText(
                        text: "$description",
                        fontWeight: FontWeight.w400,
                        fontsize: 12.h,
                        maxline: 3,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),

              ///===============================price========================:>
              Flexible(
                  child: CustomText(
                      text: "\$${price}",
                      fontWeight: FontWeight.w600,
                      fontsize: 18.h,
                      color: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
