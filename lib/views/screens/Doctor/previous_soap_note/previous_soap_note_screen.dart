import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_text.dart';

class PreviousSoapNoteScreen extends StatelessWidget {
  const PreviousSoapNoteScreen({super.key});

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
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
              return Padding(
                padding:  EdgeInsets.only(top: 8.h),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.previousSoapNoteDetailsScreen);
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 0.5),
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                  
                    child: CustomText(
                      left: 12.w,
                      textAlign: TextAlign.start,
                      top: 14.h,
                      bottom: 14.h,
                      text: "Note: 1${index}-04-2025",
                      fontWeight: FontWeight.w700,
                  
                    ),
                  ),
                ),
              );
            },)


          ],
        ),
      ),

    );
  }
}
