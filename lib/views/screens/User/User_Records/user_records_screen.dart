import 'package:doctor_appointment/controllers/user/user_records_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_two_button.dart';

class UserRecordsScreen extends StatelessWidget {
  UserRecordsScreen({super.key});

  UserRecordsController recordsController = Get.put(UserRecordsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.medicalRecords,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: AppString
                    .priorToConsultWithDoctorPleaseEnsureMedicalHistoryIsUpdatedWithTheMostCurrentInformation,
                fontsize: 18.h,
                maxline: 6,
                bottom: 18.h,
                textAlign: TextAlign.start,
                color: AppColors.textColor5C5C5C),

            ///========================Doctor Prescription==========================>
            CustomText(
                text: AppString.doctorsPrescription,
                fontsize: 16.h,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
                bottom: 12.h),

            SizedBox(height: 20.h),

            Obx(()=>
               Expanded(
                child: recordsController.recordsLoading.value
                    ? const CustomLoader()
                    : recordsController.records.isEmpty
                        ? Image.asset(AppImages.noDataImage)
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: recordsController.records.length,
                            itemBuilder: (context, index) {
                              var record = recordsController.records[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.fillColorE8EBF0),
                                child: Padding(
                                  padding: EdgeInsets.all(12.r),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8.r)),
                                              child: CustomNetworkImage(
                                                  imageUrl:  "${ApiConstants.imageBaseUrl}/${record.doctorId?.image?.publicFileUrl}",
                                                  height: 84.h,
                                                  width: 84.w)),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                _CustomTwoText('Doctor Name :', "${record.doctorId?.firstName} ${record.doctorId?.lastName}"),
                                                _CustomTwoText('Patient Name :', "${record.patientDetailsId?.fullName}"),
                                                _CustomTwoText('Patient Age :', "${record.patientDetailsId?.age}"),
                                                _CustomTwoText(
                                                    'Patient Gender :', "${record.patientDetailsId?.gender}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 12.h),
                                      CustomButton(
                                          onpress: () {
                                            Get.toNamed(AppRoutes.patientDetailsForRecordScreen, arguments: record);
                                          },
                                          title: 'See Record')
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _CustomTwoText(String key, value) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: key, color: AppColors.textColor5C5C5C, left: 12.w),
          CustomText(
              text: value,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600),
        ],
      ),
    );
  }
}

class DoctorsPrescriptionCard extends StatelessWidget {
  final String? doctorName;
  final VoidCallback? clickHereOntap;
  final double? imageHeight;
  final String? doctorImage;
  final String? rating;
  final String? specialist;
  final String? experience;
  final String? totalConsultaion;
  final String? onlineConsultation;
  final String? clinicVisit;

  const DoctorsPrescriptionCard({
    super.key,
    this.doctorName,
    this.doctorImage,
    this.rating,
    this.specialist,
    this.experience,
    this.totalConsultaion,
    this.onlineConsultation,
    this.clinicVisit,
    this.imageHeight,
    this.clickHereOntap,
  });

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
                          specialist == null
                              ? const SizedBox()
                              : _rowText("Specialist :", "$specialist"),
                          experience == null
                              ? const SizedBox()
                              : _rowText("Experience :", "$experience"),
                          totalConsultaion == null
                              ? const SizedBox()
                              : _rowText(
                                  "Total Consultaion :", "$totalConsultaion"),
                          onlineConsultation == null
                              ? const SizedBox()
                              : _rowText("Online Consultation :",
                                  "$onlineConsultation"),
                          clinicVisit == null
                              ? const SizedBox()
                              : _rowText("Clinic visit :", "$clinicVisit"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: AppString.prescription,
                    fontsize: 18.h,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
                GestureDetector(
                    onTap: clickHereOntap,
                    child: CustomText(
                        text: AppString.clickHere,
                        fontsize: 18.h,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor)),
              ],
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
