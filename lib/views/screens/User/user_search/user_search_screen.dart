import 'dart:ffi';

import 'package:doctor_appointment/controllers/user/search_doctor_controller.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/user/home_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_loader.dart';

class UserSearchScreen extends StatefulWidget {
  UserSearchScreen({super.key});

  @override
  State<UserSearchScreen> createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  final HomeController _homeController = Get.put(HomeController());
  final SearchDoctorController searchController = Get.put(SearchDoctorController());

  @override
  void initState() {
    searchController.getDoctorBySearch(searchText: _homeController.searchCtrl.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomTextFieldWithoutBorder(
          onChanged: (value) {
            setState(() {
              searchController.doctorLists.clear();
              searchController.getDoctorBySearch(searchText: _homeController.searchCtrl.text);
            });
          },
          contenpaddingHorizontal: 20,
          contenpaddingVertical: 0,
          controller: _homeController.searchCtrl,
          hintText: AppString.search,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SvgPicture.asset(AppIcons.search),
          ),
          sufixicons: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SvgPicture.asset(AppIcons.crossIcon),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            children: [
              Obx(() => searchController.doctorLoading.value
                  ? const Center(child: CustomLoader())
                  : searchController.doctorLists.isEmpty
                  ? Padding(
                padding: EdgeInsets.only(top: 200.h),
                child: Center(
                  child: Image.asset(AppImages.noDataImage),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: searchController.doctorLists.length,
                itemBuilder: (context, index) {
                  var doctorInfo = searchController.doctorLists[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: AvailableDoctorsCard(
                      image: '${doctorInfo.doctorId?.image?.publicFileUrl}',
                      experience: "${doctorInfo.experience}",
                      rating: "${doctorInfo.doctorId?.rating}",
                      clinicVisit: "\$${doctorInfo.clinicPrice}",
                      doctorName: "${doctorInfo.doctorId?.firstName} ${doctorInfo.doctorId?.lastName}",
                      totalConsultaion: "${doctorInfo.totalConsultation}",
                      onlineConsultation: '\$${doctorInfo.onlineConsultationPrice}',
                      specialist: "${doctorInfo.specialist}",
                      imageHeight: 142,
                      leftBtnText: AppString.seeDetails,
                      rightBtnText: AppString.bookAppointment,
                      leftBtnOntap: () {
                        Get.toNamed(AppRoutes.userDoctorDetailsScreen, parameters: {
                          'id': '${doctorInfo.doctorId?.id}'
                        });
                      },
                      rightBtnOnTap: () {
                        Get.toNamed(AppRoutes.userSelectPackageScreen,
                            arguments: doctorInfo, parameters: {
                              'id': '${doctorInfo.doctorId?.id}'
                            });
                      },
                    ),
                  );
                },
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
