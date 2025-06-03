import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_text.dart';

class PreviousSoapNoteDetailsScreen extends StatelessWidget {
  const PreviousSoapNoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    text: ":  Sagor Ahammed",
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
                      text: "Patient Name",
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C
                  ),
                ),


                CustomText(
                    text: ":  Sagor Ahammed",
                    fontsize: 16.h,
                    color: AppColors.textColor5C5C5C
                )
              ],
            ),


            subjectiveCard(
              title: "Subjective",
              description: "Lorem ipsum dolor sit amet consectetur. Eget nullam feugiat integer dui nunc imperdiet tortor sed eros."
            ),


            subjectiveCard(
                title: "Objective",
                description: "Lorem ipsum dolor sit amet consectetur. Eget nullam feugiat integer dui nunc imperdiet tortor sed eros."
            ),




            subjectiveCard(
                title: "Assesment",
                description: "Lorem ipsum dolor sit amet consectetur. Eget nullam feugiat integer dui nunc imperdiet tortor sed eros."
            ),






            subjectiveCard(
                title: "Plan",
                description: "Lorem ipsum dolor sit amet consectetur. Eget nullam feugiat integer dui nunc imperdiet tortor sed eros."
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
