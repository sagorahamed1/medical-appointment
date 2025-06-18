import 'package:doctor_appointment/models/doctor/soap_notes_model.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helpers/time_format.dart';
import '../../../widgets/custom_text.dart';

class PreviousSoapNoteDetailsScreen extends StatelessWidget {
  const PreviousSoapNoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SoapNoteModel soap = Get.arguments;

    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: "Previous SOAP NOTE",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),


      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            CustomText(text: "Information",fontWeight: FontWeight.w600, fontsize: 18.h, bottom: 12.h),


            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: "Patient Name",
                    fontsize: 16.h,
                    color: AppColors.textColor5C5C5C
                  ),
                ),


                CustomText(
                    text: ":  ${soap.userId?.firstName} ${soap.userId?.lastName}",
                    fontsize: 16.h,
                    color: AppColors.textColor5C5C5C
                )
              ],
            ),



            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: CustomText(
                      textAlign: TextAlign.start,
                      text: "Date",
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C
                  ),
                ),


                CustomText(
                    text: ":  ${TimeFormatHelper.formatDate(soap.createdAt ?? DateTime.now())}",
                    fontsize: 16.h,
                    color: AppColors.textColor5C5C5C
                )
              ],
            ),


            subjectiveCard(
              title: "Subjective",
              description: "${soap.subjective}"
            ),


            subjectiveCard(
                title: "Objective",
                description: "${soap.objective}"
            ),




            subjectiveCard(
                title: "Assesment",
                description: "${soap.assessment}"
            ),






            subjectiveCard(
                title: "Plan",
                description: "${soap.plan}"
            ),


          ],
        ),
      ),
    );
  }


  subjectiveCard({required String title, description}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "$title",fontWeight: FontWeight.w600, fontsize: 18.h, bottom: 12.h, top: 12.h),

        Container(
          decoration: BoxDecoration(
              color: Color(0xffE8EBF0),
              borderRadius: BorderRadius.circular(12.r)
          ),
          child: Padding(
            padding:  EdgeInsets.all(8.r),
            child: CustomText(
              textAlign: TextAlign.start,
              maxline: 8,
              text: "$description",),
          ),
        )

      ],
    );
  }
}
