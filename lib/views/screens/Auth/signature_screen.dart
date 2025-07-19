
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../widgets/custom_text.dart';

class SignatureViewScreen extends StatelessWidget {
  const SignatureViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "TELEMEDICINE CONSENT FORM", fontsize: 17.h, fontWeight: FontWeight.w600),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              SizedBox(height: 16.h),
              Text(
                "I consent to receive healthcare services via telemedicine from Medroof Urgent Care & Spa. I understand the potential benefits and risks of telehealth and agree to participate voluntarily.",
                style: TextStyle(
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),





              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Signature:",
                          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                        ),


                        SizedBox(width: 10.w),


                        Column(
                          children: [
                            Text(
                              "${Get.arguments["name"]}",
                              style: TextStyle(fontSize: 14.sp),
                            ),

                            Container(
                              width: 200.w,
                              height: 1.h,
                              color: Colors.black38,
                            ),
                          ],
                        ),

                      ],
                    ),


                    SizedBox(height: 20.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date:",
                          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                        ),


                        SizedBox(width: 10.w),
                        Column(
                          children: [
                            Text(
                              "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                              style: TextStyle(fontSize: 14.sp),
                            ),

                            Container(
                              width: 90.w,
                              height: 1.h,
                              color: Colors.black38,
                            ),
                          ],
                        ),

                      ],
                    ),




                  ],
                ),
              ),


              Spacer(),


              CustomButton(onpress: () {

                Get.toNamed(AppRoutes.veryfyEmailScreen, parameters: {'screenType': 'signUp', 'email': Get.arguments["email"]});

              }, title: "Agree"),



              SizedBox(height: 150.h)


            ],
          ),
        ),
      ),
    );
  }
}