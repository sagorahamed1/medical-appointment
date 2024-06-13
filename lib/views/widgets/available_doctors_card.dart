
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_images.dart';
import 'custom_text.dart';
import 'custom_two_button.dart';

class AvailableDoctorsCard extends StatelessWidget {
  final String? doctorName;
  final VoidCallback? leftBtnOntap;
  final double? imageHeight;
  final String? doctorImage;
  final String? rating;
  final String? specialist;
  final String? experience;
  final String? totalConsultaion;
  final String? onlineConsultation;
  final String? clinicVisit;
  final String? leftBtnText;
  final String? rightBtnText;

  const AvailableDoctorsCard(
      {super.key,
        this.doctorName,
        this.doctorImage,
        this.rating,
        this.specialist,
        this.leftBtnOntap,
        this.experience,
        this.totalConsultaion,
        this.onlineConsultation,
        this.clinicVisit,
        this.leftBtnText,
        this.imageHeight,
        this.rightBtnText});

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
                      height: imageHeight?.h,
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text: "${doctorName}",
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.star),
                                  CustomText(
                                      text: " ${rating}",
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontsize: 12.h),
                                ],
                              ),
                            ],
                          ),
                          specialist == null ?const SizedBox() :  _rowText("Specialist :", "$specialist"),
                          experience == null ?const SizedBox() :    _rowText("Experience :", "$experience"),
                          totalConsultaion == null ?const SizedBox() :    _rowText("Total Consultaion :", "$totalConsultaion"),
                          onlineConsultation == null ?const SizedBox() :   _rowText("Online Consultation :", "$onlineConsultation"),
                          clinicVisit == null ?const SizedBox() :    _rowText("Clinic visit :", "$clinicVisit"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            CustomTwoButon(
              width: 159.w,
              btnNameList: ["$leftBtnText", "$rightBtnText"],
              rightBtnOnTap: () {},
              leftBtnOnTap: leftBtnOntap,
              initialSeclected: 0,
            )
          ],
        ),
      ),
    );
  }

  Widget _rowText(String leftText, rightText) {
    return Padding(
      padding: EdgeInsets.only(top: 3.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: leftText, color: AppColors.textColor5C5C5C),
          CustomText(
              text: "$rightText",
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}
