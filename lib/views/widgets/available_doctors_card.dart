
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/api_constants.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';
import '../../utils/app_images.dart';
import 'custom_text.dart';
import 'custom_two_button.dart';

class AvailableDoctorsCard extends StatelessWidget {
  final String? doctorName;
  final VoidCallback? leftBtnOntap;
  final VoidCallback? rightBtnOnTap;
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
  final String? image;

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
        this.rightBtnText, this.rightBtnOnTap, this.image});

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
                    child: CustomNetworkImage(
                      imageUrl : '${ApiConstants.imageBaseUrl}/$image',
                      height: imageHeight!.h,
                      width: 110.w,
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
                                  text: "$doctorName",
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600),
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.star),
                                  CustomText(
                                      text: " $rating",
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontsize: 12.h),
                                ],
                              ),
                            ],
                          ),
                          specialist == null ?const SizedBox() :  _rowText("Specialty :", "$specialist"),
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
            SizedBox(
              width: 330.w,
              child: CustomTwoButon(
                btnRadius: 8,
                width: 155.w,
                btnNameList: ["$leftBtnText", "$rightBtnText"],
                rightBtnOnTap: rightBtnOnTap,
                leftBtnOnTap: leftBtnOntap,
                initialSeclected: 0,
              ),
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
          Flexible(
            child: CustomText(
              text: leftText,
              color: AppColors.textColor5C5C5C,
            ),
          ),
          // const Spacer(),
          Expanded(
            child: CustomText(
              text: rightText,
              color: AppColors.primaryColor,
              textAlign: TextAlign.end,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      )
    );
  }
}
