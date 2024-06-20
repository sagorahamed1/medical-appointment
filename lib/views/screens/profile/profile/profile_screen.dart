import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'inner_widgets/top_profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopProfileCard(
            appBarText: AppString.profile,
            name: "Sagor Ahamed",
            height: 341,
            image:
                "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
          ),
          
          
          
          Padding(
            padding:  EdgeInsets.all(20.r),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Color(0xFFFFFFFF), // White background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // 20% opacity black shadow
                    offset: Offset(0, 0), // No offset
                    blurRadius: 12, // Blur radius
                    spreadRadius: 0, // Spread radius
                  ),
                ],

              ),
              
              
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [

                    ListTileWidget(AppString.personalInformation, AppIcons.person, AppColors.primaryColor, (){
                      Get.toNamed(AppRoutes.personalInformationScreen);
                    }),
                    ListTileWidget(AppString.medicalRecords, AppIcons.medicalRecord, AppColors.primaryColor, (){}),
                    ListTileWidget(AppString.settings, AppIcons.setting, AppColors.primaryColor, (){}),
                    ListTileWidget(AppString.logout, AppIcons.logout, Colors.red,(){

                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 280.h,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  <Widget>[
                                  CustomText(text: "Logout",fontWeight: FontWeight.w600,fontsize: 20.h,color: Colors.red, top: 35.h, bottom: 48.h),
                                  CustomText(text: "Are you sure you want to log out?",fontsize: 18.h,color: Colors.black ,bottom: 24.h),

                                  const TwoBottonBottomSheet(),
                                  SizedBox(height: 48.h)
                                ],
                              ),
                            );
                          });
                      
                    }, isDivider: false),


                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ListTileWidget(String name, icon, Color color , VoidCallback ontap , {bool isDivider = true}){
    return   Column(
      children: [
        ListTile(
          onTap: ontap,
          title: CustomText(text: name, fontWeight: FontWeight.w600,fontsize: 16.h, textAlign: TextAlign.start, color: color,),
          leading: SvgPicture.asset(icon, color: color),
        ),

      isDivider ?    Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: const Divider(color: Color(0xffB8C1CF)),
        ) : SizedBox()
      ],
    );
  }
}


class TwoBottonBottomSheet extends StatelessWidget {
  const TwoBottonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              width: 166.w,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 18.h),
                  child: CustomText(text: "Cancel", fontsize: 16.h,fontWeight: FontWeight.w600,color: AppColors.primaryColor),
                ),
              ),
            ),
          ),



          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Container(
              width: 166.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100)
              ),
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 18.h),
                  child: CustomText(text: "Yes, Logout", fontsize: 16.h,fontWeight: FontWeight.w600,color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

