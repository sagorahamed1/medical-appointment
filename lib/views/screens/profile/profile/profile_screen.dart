import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopProfileCard(
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

                    ListTileWidget(AppString.personalInformation, AppIcons.person, AppColors.primaryColor),
                    ListTileWidget(AppString.medicalRecords, AppIcons.medicalRecord, AppColors.primaryColor),
                    ListTileWidget(AppString.settings, AppIcons.setting, AppColors.primaryColor),
                    ListTileWidget(AppString.logout, AppIcons.logout, Colors.red, isDivider: false),


                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget ListTileWidget(String name, icon, Color color, {bool isDivider = true}){
    return   Column(
      children: [
        ListTile(
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

class TopProfileCard extends StatelessWidget {
  final String? appBarText;
  final String? image;
  final String? name;
  final double? height;
  final double? backIcon;

  const TopProfileCard(
      {super.key,
      this.appBarText,
      this.image,
      this.name,
      this.height,
      this.backIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height?.h,
        width: double.infinity,
        decoration: BoxDecoration(
            color: const Color(0xff193664),
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(image: AssetImage(AppImages.bgProfile))),
        child: Column(
          children: [
            SizedBox(height: 60.h),

            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: 20.w),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  Spacer(),
                  CustomText(
                    text: "$appBarText",
                    fontsize: 18.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    right: Get.width / 2.4,
                  ),
                ],
              ),
            ),

            SizedBox(height: 36.h),

            ///=====================image=====================>
            Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50.r)),
              child: CustomNetworkImage(
                  imageUrl: '$image', height: 120.h, width: 120.w),
            ),

            CustomText(
              text: "$name",
              fontsize: 20.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              top: 16.h,
            ),
          ],
        ));
  }
}
