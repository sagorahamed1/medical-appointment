import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/user/home_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/available_doctors_card.dart';
import '../../../widgets/custom_text.dart';

class UserAvailablleDoctorsScreen extends StatefulWidget {
  UserAvailablleDoctorsScreen({super.key});

  @override
  State<UserAvailablleDoctorsScreen> createState() => _UserAvailablleDoctorsScreenState();
}

class _UserAvailablleDoctorsScreenState extends State<UserAvailablleDoctorsScreen> {

  final ScrollController _scrollController = ScrollController();
  final HomeController _homeController = Get.put(HomeController());


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _homeController.getDoctorByCetegory(cetegory: '${Get.parameters['category']}', date: null);
    });
    _addScrollListener();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeController.loadMoreGetDoctors();
        print("load more true");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // _homeController.getDoctorByCetegory(cetegory: '${Get.parameters['category']}', date: null);
    print("==> Category Name ${Get.parameters['category']}");

    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.availableDoctors,
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
                child: Obx(() {
                  return  _homeController.doctorLists.isEmpty ? Image.asset(AppImages.noDataImage) : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _homeController.doctorLists.length,
                    itemBuilder: (context, index) {
                      var doctorInfo = _homeController.doctorLists[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: AvailableDoctorsCard(
                          image: "${doctorInfo.doctorId?.image?.publicFileUrl}",
                          experience: "${doctorInfo.experience}",
                          rating: "${doctorInfo.doctorId?.rating}",
                          clinicVisit: "\$${doctorInfo.clinicPrice}",
                          doctorName: "${doctorInfo.doctorId?.firstName} ${doctorInfo.doctorId?.lastName}",
                          totalConsultaion: "10",
                          onlineConsultation: '\$${doctorInfo.onlineConsultationPrice}',
                          specialist: "${doctorInfo.specialist}",
                          imageHeight: 142,
                          leftBtnText: AppString.seeDetails,
                          rightBtnText: AppString.bookAppointment,
                          leftBtnOntap: () {
                            Get.toNamed(AppRoutes.userDoctorDetailsScreen,
                                parameters: {
                                  'id': '${doctorInfo.doctorId?.id}'
                                });
                          },
                          rightBtnOnTap: () {
                            Get.toNamed(AppRoutes.userSelectPackageScreen,
                                arguments: doctorInfo,
                                parameters: {
                                  'id': '${doctorInfo.doctorId?.id}'
                                });
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
