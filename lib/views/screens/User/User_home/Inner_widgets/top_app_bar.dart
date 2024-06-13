import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/custom_text.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return               Row(
      children: [
        ///---------------------profile image------------------------>
        CircleAvatar(
          radius: 20.r,
          backgroundImage: const AssetImage(AppImages.splashBgImage),
        ),
        //       : CircleAvatar(
        //   radius: 20.r,
        //   backgroundImage: NetworkImage(
        //       "${ApiConstants.imageBaseUrl}${_profileData.image?.url}"),
        // ),
        SizedBox(
          width: 12.w,
        ),

        ///---------------------------hello (profile name)----------------------->
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Good Morning 👋",
                color: AppColors.textColor5C5C5C,
              ),
              CustomText(
                text: "Sagor ahamed",
                fontsize: 16.h,
                fontWeight: FontWeight.w600,
                top: 4.h,
              )
            ],
          ),
        ),
        SizedBox(
          width: 10.w,
        ),

        GestureDetector(
          onTap: () {
             Get.toNamed(AppRoutes.notificationScreen);
          },
          child: Container(
            child: SvgPicture.asset(AppIcons.notification),
          ),
        ),
      ],
    );
  }
}
