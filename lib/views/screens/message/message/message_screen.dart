import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.message,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,),
        child: Column(
          children: [

             SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 16.h),
                    child: GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoutes.chatScreen);
                        },
                        child: _messageCard(AppImages.getStarted1, "Sagor Ahamed", "how are you?", "1m Ago")),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageCard(String image, name, lastMessage, time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///===============================Image=========================>?
            Container(
              padding: EdgeInsets.only(right: 20.w),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Image.asset("$image",
                  height: 40.h, width: 40.h, fit: BoxFit.cover),
            ),

            ///=======================Name and last message ==========================>
            SizedBox(
              width: 175.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: "$name",
                      fontsize: 16.h,
                      fontWeight: FontWeight.w600),
                  CustomText(text: "$lastMessage", color: AppColors.gray767676),
                ],
              ),
            )
          ],
        ),

        ///====================time ago======================>
        CustomText(
          text: "$time",
          color: AppColors.gray767676,
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}
