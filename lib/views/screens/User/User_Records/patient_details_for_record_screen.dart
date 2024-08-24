import 'package:doctor_appointment/models/user_records_models.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../User_doctor_details/Inner_widgets/top_doctor_box_card.dart';

class PatientDetailsForRecordScreen extends StatelessWidget {
   PatientDetailsForRecordScreen({super.key});

 final UserRecordsModel record = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.patientDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w, vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopDoctorBoxCard(
                image: '${record.doctorId?.image?.publicFileUrl}',
                specialist: '${record.doctorId?.id}',
                location: '${record.doctorId?.address}',
                doctorName: "${record.doctorId?.firstName} ${record.doctorId?.lastName}",
              ),


              ///===================Patient Information===================>
              CustomText(
                  text: AppString.patientInformation,
                  fontWeight: FontWeight.w600,
                  fontsize: 18.h,
                  top: 20.h,
                  bottom: 16.h),

              _leftAndRightText(AppString.fullName, "${record.patientDetailsId?.fullName}"),
              _leftAndRightText(AppString.gender, "${record.patientDetailsId?.gender}"),
              _leftAndRightText(AppString.age, "${record.patientDetailsId?.age}"),
              _leftAndRightText(AppString.problem, "${record.patientDetailsId?.description}"),


              SizedBox(height: 10.h),
              ///======================================>
              Container(
                color: Colors.black,
                height: 500.h,
                width: double.infinity,
                child: SfPdfViewer.network(
                  '${ApiConstants.imageBaseUrl}/${record.file?.publicFileUrl}',
                  canShowPaginationDialog: true,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                  onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                    // Handle the error case with a fallback UI
                     print("$details");
                  },
                ),
              )



            ],
          ),
        ),
      ),
    );
  }


  Widget _leftAndRightText(String leftText, rightText) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: '${leftText}  : ',
              fontsize: 16.h,
              color: AppColors.textColor5C5C5C),
          SizedBox(
              width: 252.w,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomText(
                      text: ' $rightText',
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C,
                      maxline: 10,
                      textAlign: TextAlign.start))),
        ],
      ),
    );
  }
}
