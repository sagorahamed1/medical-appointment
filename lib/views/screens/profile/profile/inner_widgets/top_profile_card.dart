import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../services/api_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/cachanetwork_image.dart';
import '../../../../widgets/custom_text.dart';

class TopProfileCard extends StatelessWidget {
  final String? appBarText;
  final String? image;
  final String? name;
  final bool? isBackButton;
  final double? height;
  final double? backIcon;

  const TopProfileCard(
      {super.key,
      this.appBarText,
      this.image,
      this.name,
      this.height,
      this.backIcon, this.isBackButton});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height?.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xff193664),
            borderRadius: BorderRadius.circular(20.r),
            image:
                const DecorationImage(image: AssetImage(AppImages.bgProfile))),
        child: Column(
          children: [
            SizedBox(height: 60.h),


            isBackButton == false ?
            CustomText(
              text: "$appBarText",
              fontsize: 18.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ) :

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [

                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                       GestureDetector(
                           onTap: (){
                             Get.back();
                             Get.parameters.clear();
                           },
                           child: const Icon(Icons.arrow_back, color: Colors.white)),
                    ],
                  ),
                ),

                CustomText(
                  textAlign: TextAlign.center,
                  text: "$appBarText",
                  fontsize: 18.h,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                const Spacer(),
              ],
            ),


            SizedBox(height: 36.h),

            ///=====================image=====================>
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                   color: Colors.black,
                  borderRadius: BorderRadius.circular(50.r)),
              child: CustomNetworkImage(
                  imageUrl: '${ApiConstants.imageBaseUrl}/$image',
                  height: 120.h,
                  width: 120.w),
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
