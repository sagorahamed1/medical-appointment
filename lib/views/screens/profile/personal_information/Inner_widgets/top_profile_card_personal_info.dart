
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_text.dart';

class TopProfileCardPersonInfo extends StatelessWidget {
  final String? appBarText;
  final String? image;
  final String? name;
  final double? height;
  final double? backIcon;

  const TopProfileCardPersonInfo(
      {super.key,
        this.appBarText,
        this.image,
        this.name,
        this.height,
        this.backIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height?.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xff193664),
            borderRadius: BorderRadius.circular(20.r),
            image: const DecorationImage(image: AssetImage(AppImages.bgProfile))),
        child: Column(
          children: [
            SizedBox(height: 60.h),

            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child:
                      Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    ),
                  ),

                  ///===================App bar Text======================>
                  CustomText(
                    left: 64.w,
                    text: "$appBarText",
                    fontsize: 18.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            SizedBox(height: 36.h),

            ///=====================image=====================>
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(50.r)),
              child: CustomNetworkImage(
                  imageUrl: '$image', height: 120.h, width: 120.w),
            ),

            ///=====================name ===============>
            CustomText(
              text: "$name",
              fontsize: 20.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              top: 16.h,
            ),

            SizedBox(height: 16.h),

            ///==================edit profile btn=================>
            Container(
              width: 134.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 8.5.w, vertical: 6.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.editProfile),
                    CustomText(
                        text: AppString.editProfile,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        left: 8.w)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
