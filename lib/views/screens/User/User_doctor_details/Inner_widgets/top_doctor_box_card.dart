import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/custom_text.dart';

class TopDoctorBoxCard extends StatelessWidget {
  final String? doctorName;
  final String? image;
  final String? rating;
  final String? location;
  TopDoctorBoxCard({super.key, this.doctorName, this.image, this.rating, this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.fillColorE8EBF0,
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                    child: Image.asset(
                      AppImages.getStarted1,
                      height: 120,
                      width: 110.w,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 213.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                    textAlign: TextAlign.start,
                                    text: "$doctorName",
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),
                             rating == null ? SizedBox() : Row(
                                children: [
                                  SvgPicture.asset(AppIcons.star),
                                  CustomText(
                                      text: " 4.8",
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontsize: 12.h),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          const Divider(
                            color: Color(0xffB8C1CF),
                          ),
                          CustomText(
                              text: "Immunologists",
                              color: Colors.black,
                              fontsize: 12.h,
                              fontWeight: FontWeight.w500,
                              top: 14.h,
                              bottom: 14.h),
                          CustomText(
                            text: "$location",
                            color: AppColors.textColor5C5C5C,
                            maxline: 2,
                            fontsize: 12.h,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
