import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var inticatorIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.h),
        child: Obx(()=>
          Column(
            children: [
              SizedBox(height: 264.h),
               Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault.r),
                ),
                child: Image.asset(
                  "assets/images/getStarted${inticatorIndex.value}.png",
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                  height: 236.h,
                ),
              ),

              SizedBox(height: 24.h),

              Center(
                child: SizedBox(
                  height: 14.w,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Container(
                          width: 12.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: inticatorIndex.value == index+1
                                ? AppColors.primaryColor
                                : AppColors.fillColorE8EBF0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 191.h),

              CustomButton(
                onpress: () {
                  if (inticatorIndex.value < 3) {
                    inticatorIndex.value++;
                  } else {
                    inticatorIndex.value = 1;
                  }
                },
                title: AppString.getStarted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
