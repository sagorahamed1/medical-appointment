import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/categorySection.dart';
import 'package:doctor_appointment/views/screens/User/User_home/Inner_widgets/top_app_bar.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/user/home_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    _homeController.getDoctorByCetegory();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=====================top app bar =================================>

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TopAppBar(),

                      CustomText(
                          text: AppString.enhancingTheHealthcareExperience,
                          fontWeight: FontWeight.w600,
                          fontsize: 16.h,
                          bottom: 16.h,
                          top: 20.h),

                      ///========================Search box=============================>
                      CustomTextFieldWithoutBorder(
                        contenpaddingHorizontal: 20.w,
                        contenpaddingVertical: 0,
                        controller: _homeController.searchCtrl,
                        hintText: AppString.search,
                        prefixIcon: GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoutes.userSearchScreen);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: SvgPicture.asset(AppIcons.search),
                          ),
                        ),
                      ),

                      ///=======================Categories and See All Text=============================>
                      _SeeAll(AppString.categories, AppString.seeAll, (){
                        Get.toNamed(AppRoutes.userCategoryScreen);
                      }),

                      const Categorysection(),

                      ///=======================available Doctors and See All Text=============================>
                      _SeeAll(AppString.availableDoctors, AppString.seeAll, (){
                        Get.toNamed(AppRoutes.useravailablleDoctorsScreen);
                      }),
                    ],
                  ),
                ),


                ///======================available doctor list=================>
                Obx(()=>
                    _homeController.doctorLoading.value?
                        const Center(child: CustomLoader()) :
                    SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: _homeController.doctorLists.length,
                      itemBuilder: (context, index) {
                        var doctorInfo = _homeController.doctorLists[index];
                        return  Padding(
                          padding:  EdgeInsets.only(left: index == 0 ? 19.w : 7.5.w, right: index == 4-1 ? 20.w : 0.w),
                          child: AvailableDoctorsCard(
                            experience: "${doctorInfo.experience}",
                            rating: "{ing}",
                            clinicVisit: "\$${doctorInfo.clinicPrice}",
                            doctorName: "${doctorInfo.doctorId?.firstName} ${doctorInfo.doctorId?.lastName}",
                            totalConsultaion: "12",
                            onlineConsultation: '\$${doctorInfo.onlineConsultationPrice}',
                            specialist: "${doctorInfo.specialist}",
                            imageHeight: 142,
                            leftBtnText: AppString.seeDetails,
                            rightBtnText: AppString.bookAppointment,
                            leftBtnOntap: (){
                              Get.toNamed(AppRoutes.userDoctorDetailsScreen, parameters: {'id' : '${doctorInfo.doctorId?.id}'});
                            },
                            rightBtnOnTap: (){
                              Get.toNamed(AppRoutes.userSelectPackageScreen);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),


                ///=======================Emergency Doctors and See All Text=============================>
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w),
                  child: _SeeAll(AppString.emergencyDoctors, AppString.seeAll, (){
                    Get.toNamed(AppRoutes.useremergencyDoctorsScreen);
                  }),
                ),
            
            
                SizedBox(
                  height: 185.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:  EdgeInsets.only(left: index == 0 ? 19.w : 8.w, right: index == 10-1 ? 20.w : 0.w),
                        child: const AvailableDoctorsCard(
                          rating: "4.0",
                          doctorName: "Sagor Ahamed",
                          specialist: "Cardiologist",
                          onlineConsultation: r'$20',
                          totalConsultaion: '12',
                          imageHeight: 100,
                          leftBtnText: AppString.message,
                          rightBtnText: AppString.videoCall,
                        ),
                      );
                    },
                  ),
                ),


                SizedBox(height: 10.h)
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _SeeAll(String leftText, seeAllText, VoidCallback ontap) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: leftText,
                fontsize: 18.h,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor),
            GestureDetector(
              onTap: ontap,
              child: CustomText(
                  text: seeAllText,
                  fontsize: 16.h,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
