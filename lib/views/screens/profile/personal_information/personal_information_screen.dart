import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import 'Inner_widgets/top_profile_card_personal_info.dart';

class PersonalInformationScreen extends StatelessWidget {
   PersonalInformationScreen({super.key});

  final ProfileControler _profileControler = Get.find<ProfileControler>();

  @override
  Widget build(BuildContext context) {
    _profileControler.getProfile();
    return Scaffold(

      body: SingleChildScrollView(
        child: Obx(() {
          var profileData = _profileControler.profileInfo.value;
          return  _profileControler.profileLoading.value ?
          Center(child: Padding(
            padding:  EdgeInsets.only(top :280.h),
            child: const CustomLoader(),
          )) :
          Column(
            children: [
              TopProfileCardPersonInfo(
                appBarText: AppString.personalInformation,
                name: "${profileData.firstName} ${profileData.lastName}",
                height: 375,
                onTap: (){
                  Get.toNamed(AppRoutes.editProfileScreen, arguments: profileData);
                },
                image: "${profileData.image?.publicFileUrl}",
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault.r),
                child: Column(
                  children: [
                    _ListTile("${profileData.firstName} ${profileData.lastName}", AppIcons.person),
                    _ListTile("${profileData.email}", AppIcons.email),
                    _ListTile("${profileData.phone}", AppIcons.call),
                    _ListTile('${profileData.dateOfBirth}', AppIcons.dateOfBirth),
                    _ListTile("${profileData.address}", AppIcons.location),
                  ],
                ),
              )
            ],
          );

        },)
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
