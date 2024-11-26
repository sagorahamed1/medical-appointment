import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/user/home_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/custom_text.dart';

class UserEmergencyDoctorsScreen extends StatefulWidget {
  UserEmergencyDoctorsScreen({super.key});

  @override
  State<UserEmergencyDoctorsScreen> createState() => _UserEmergencyDoctorsScreenState();
}

class _UserEmergencyDoctorsScreenState extends State<UserEmergencyDoctorsScreen> {
  final HomeController _homeController = Get.put(HomeController());

  @override
  void initState() {
    _homeController.getEmergencyDoctor();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.emergencyDoctors,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Column(
            children: [
              Expanded(
                child: Obx(()=>

                _homeController.emergencyDoctorLoading.value
                    ? const Center(child: CustomLoader())
                    : _homeController.emergencyDoctors.isEmpty
                    ? SizedBox(
                    height: 180.h,
                    width: 200.w,
                    child: Image.asset(AppImages.noDataImage))
                    :
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:_homeController.emergencyDoctors.value.length,
                    itemBuilder: (context, index) {
                      var emergencyDoctors = _homeController.emergencyDoctors.value[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child:  AvailableDoctorsCard(
                          image: '${emergencyDoctors.doctorId?.image?.publicFileUrl}',
                          rating: "${emergencyDoctors.doctorId?.rating}",
                          doctorName:
                          "${emergencyDoctors.doctorId?.firstName} ${emergencyDoctors.doctorId?.lastName}",
                          specialist:
                          "${emergencyDoctors.specialist}",
                          onlineConsultation:
                          '${emergencyDoctors.onlineConsultationPrice}',
                          totalConsultaion: '${emergencyDoctors.totalConsultation}',
                          imageHeight: 100,
                          leftBtnText: AppString.seeDetails,
                          rightBtnText: AppString.bookAppointment,
                          leftBtnOntap: () {
                            Get.toNamed(
                                AppRoutes.userDoctorDetailsScreen,
                                arguments: emergencyDoctors,
                                parameters: {
                                  'id':
                                  '${emergencyDoctors.doctorId?.id}'
                                });
                          },
                          rightBtnOnTap: () {
                            Get.toNamed(
                                AppRoutes.userPatientDetailsScreen,
                                arguments: emergencyDoctors,
                                parameters: {
                                  'id':
                                  '${emergencyDoctors.doctorId?.id}'
                                });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
