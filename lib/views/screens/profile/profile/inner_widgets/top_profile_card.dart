
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_images.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_text.dart';

class TopProfileCard extends StatelessWidget {
  final String? appBarText;
  final String? image;
  final String? name;
  final double? height;
  final double? backIcon;

  const TopProfileCard(
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

            CustomText(
              text: "$appBarText",
              fontsize: 18.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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

            CustomText(
              text: "$name",
              fontsize: 20.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              top: 16.h,
            ),
          ],
        ));
  }
}
