import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/genaral_error_screen.dart';
import '../../../widgets/no_internet_screen.dart';
import 'inner_widgets/top_profile_card.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileControler _profileControler = Get.find<ProfileControler>();

  @override
  Widget build(BuildContext context) {
    _profileControler.getProfile();
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          var profileData = _profileControler.profileInfo.value;
          switch (_profileControler.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader();
            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  _profileControler.getProfile();
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  _profileControler.getProfile();
                },
              );
            case Status.completed:
              return Column(
                children: [
                   TopProfileCard(
                    appBarText: AppString.profile,
                    name: '${profileData.firstName} ${profileData.lastName}',
                    height: 341,
                    image:
                    "${profileData.image?.publicFileUrl}",
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 0),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Column(
                          children: [

                            ///=========================Personal Information=========================>

                            ListTileWidget(AppString.personalInformation,
                                AppIcons.person, AppColors.primaryColor, () {
                                  Get.toNamed(
                                      AppRoutes.personalInformationScreen);
                                }),

                            ///=========================Doctor Details=========================>
                            profileData.role == "doctor"
                                ? ListTileWidget(
                                AppString.doctorDetails,
                                AppIcons.medicalRecord,
                                AppColors.primaryColor, () {
                              Get.toNamed(
                                  AppRoutes.doctorDetailsProfileScreen);
                            })
                                : const SizedBox(),

                            ///=========================Appointment Requests=========================>
                            profileData.role == "doctor"
                                ? ListTileWidget(
                                AppString.appointmentRequests,
                                AppIcons.medicalRecord,
                                AppColors.primaryColor, () {
                              Get.toNamed(AppRoutes
                                  .doctorAppointmentRequestScreen);
                            })
                                : const SizedBox(),

                            ///=========================Earning=========================>
                            profileData.role == "doctor"
                                ? ListTileWidget(
                                AppString.earnings,
                                AppIcons.earning,
                                AppColors.primaryColor, () {
                              Get.toNamed(AppRoutes.walletScreen);
                            })
                                : const SizedBox(),

                            ///=========================Review=========================>
                            profileData.role== "doctor"
                                ? ListTileWidget(
                                AppString.reviews,
                                AppIcons.reviewStar,
                                AppColors.primaryColor, () {
                              Get.toNamed(AppRoutes.reviewScreen);
                            })
                                : const SizedBox(),

                            ///=========================Medical Records=========================>
                            profileData.role == "user"
                                ? ListTileWidget(
                                AppString.medicalRecords,
                                AppIcons.medicalRecord,
                                AppColors.primaryColor, () {
                              Get.toNamed(AppRoutes.userRecordsScreen);
                            })
                                : const SizedBox(),

                            ///=========================Setting=========================>
                            ListTileWidget(AppString.settings,
                                AppIcons.setting, AppColors.primaryColor, () {
                                  Get.toNamed(AppRoutes.settingScreen, parameters: {
                                    'role' : '${profileData.role}',
                                    'emergency' : '${profileData.isEmergency}'
                                  });
                                }),
                            ListTileWidget(
                                AppString.logout, AppIcons.logout, Colors.red,
                                    () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 280.h,
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              CustomText(
                                                  text: "Logout",
                                                  fontWeight: FontWeight.w600,
                                                  fontsize: 20.h,
                                                  color: Colors.red,
                                                  top: 35.h,
                                                  bottom: 48.h),
                                              CustomText(
                                                  text:
                                                  "Are you sure you want to log out?",
                                                  fontsize: 18.h,
                                                  color: Colors.black,
                                                  bottom: 24.h),
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
              );
          }
        }
                    )

      ),
    );
  }

  Widget ListTileWidget(String name, icon, Color color, VoidCallback ontap,
      {bool isDivider = true}) {
    return Column(
      children: [
        ListTile(
          onTap: ontap,
          title: CustomText(
            text: name,
            fontWeight: FontWeight.w600,
            fontsize: 16.h,
            textAlign: TextAlign.start,
            color: color,
          ),
          leading: SvgPicture.asset(icon, color: color),
        ),
        isDivider
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: const Divider(color: Color(0xffB8C1CF)),
              )
            : const SizedBox()
      ],
    );
  }
}

class TwoBottonBottomSheet extends StatelessWidget {
  const TwoBottonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 166.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: CustomText(
                    text: "Cancel",
                    fontsize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async{
            AppConstants.roleMock = '';
            // await PrefsHelper.remove(AppConstants.token);
            await PrefsHelper.remove(AppConstants.userId);
            await PrefsHelper.remove(AppConstants.role);
            await PrefsHelper.remove(AppConstants.roleMock);
            await PrefsHelper.remove(AppConstants.bearerToken);
            await PrefsHelper.remove(AppConstants.mockRole);
            await PrefsHelper.remove(AppConstants.isLogged);
            Get.toNamed(AppRoutes.roleScreen);
          },
          child: Container(
            width: 166.w,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: CustomText(
                    text: "Yes, Logout",
                    fontsize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
