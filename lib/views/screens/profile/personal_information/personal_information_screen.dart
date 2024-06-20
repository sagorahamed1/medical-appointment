import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import 'Inner_widgets/top_profile_card_personal_info.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopProfileCardPersonInfo(
              appBarText: AppString.personalInformation,
              name: "Sagor Ahamed",
              height: 375,
              image:
                  "https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630",
            ),
            Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault.r),
              child: Column(
                children: [
                  _ListTile("Sagor Ahamed", AppIcons.person),
                  _ListTile("sagorahammed@gmail.com", AppIcons.email),
                  _ListTile("01315733312445", AppIcons.call),
                  _ListTile("16 July 2000", AppIcons.dateOfBirth),
                  _ListTile("Rampura, Dhaka, Bangladesh", AppIcons.location),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _ListTile(String title, leadingIcon) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(16.r)),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 20.w),
          title: CustomText(
            maxline: 2,
              text: title,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor),
          leading: SvgPicture.asset(leadingIcon,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
              color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
