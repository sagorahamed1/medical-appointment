import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: const NetworkImage(
                    "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Adjust the opacity here
                  BlendMode.darken,
                ))),
        child: Column(
          children: [
            SizedBox(height: 242.h),
            Container(
              height: 126.h,
              width: 126.w,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
                fit: BoxFit.cover,
              ),
            ),
            CustomText(
                text: "Sagor Ahamed",
                fontsize: 24.h,
                fontWeight: FontWeight.w500,
                top: 16.h,
                bottom: 10.h,
                color: Colors.white),
            CustomText(
                text: "Incoming call", fontsize: 18.h, color: Colors.white),
            SizedBox(height: 180.h),
            Column(
              children: [
                SvgPicture.asset(AppIcons.messageIcon2,
                    color: Colors.white,
                    height: 19.h,
                    width: 19.w,
                    fit: BoxFit.cover),
                CustomText(text: "Message", fontsize: 16.h, color: Colors.white)
              ],
            ),
            SizedBox(height: 43.h),


            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault.w),
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Color(0xff686868)),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: SvgPicture.asset(AppIcons.call2,
                            color: Colors.white, height: 20.h, width: 20.w),
                      ),
                    ),
                    SizedBox(width: 11.w),
                    CustomText(
                        text: "Slide to answer",
                        fontsize: 18.h,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)
                  ],
                ),
              ),
            ),



            //
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Dimensions.paddingSizeDefault.w),
            //   child: Container(
            //     height: 60.h,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(16.r),
            //         color: Colors.white),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //
            //         CallControllerFeature(AppIcons.videoMute, Colors.white, Colors.black),
            //         CallControllerFeature(AppIcons.speaker, Colors.white, Colors.black),
            //         CallControllerFeature(AppIcons.voice, Colors.white, Colors.black),
            //         CallControllerFeature(AppIcons.crossIcon, Colors.white, Colors.red),
            //
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget CallControllerFeature(String icon, Color iconColor, bgColor){
    return  Container(
      clipBehavior: Clip.antiAlias,
      decoration:  BoxDecoration(
          shape: BoxShape.circle, color: bgColor),
      child: Padding(
        padding: EdgeInsets.all(9.r),
        child: SvgPicture.asset(icon,
            color: iconColor, height: 20.h, width: 20.w),
      ),
    );
  }
}
