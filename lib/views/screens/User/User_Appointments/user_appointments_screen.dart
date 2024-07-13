import 'package:doctor_appointment/controllers/user/user_appointments_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserAppointmentsScreen extends StatefulWidget {
  const UserAppointmentsScreen({super.key});

  @override
  State<UserAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<UserAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  UserAppointmentsController appointmentsController =
      Get.put(UserAppointmentsController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("===========${_tabController.index}");
    appointmentsController.getAppointment(status: 'upcomming');
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.appointments,
          fontsize: 18,
          fontWeight: FontWeight.w600,
        ),
        bottom: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 20),
           controller: _tabController,
          onTap: (int value) {
            if (value == 0) {
              appointmentsController.appointmentList.clear();
              appointmentsController.getAppointment(status: 'upcomming');
            } else if (value == 1) {
              appointmentsController.appointmentList.clear();
              appointmentsController.getAppointment(status: 'active');
            } else {
              appointmentsController.appointmentList.clear();
              appointmentsController.getAppointment(status: 'completed');
            }
          },
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Completed'),
            Tab(text: 'Cancelled'),
          ],
          labelColor: AppColors.primaryColor,
          unselectedLabelStyle: const TextStyle(color: Colors.red),
          unselectedLabelColor: const Color(0xff767676),
          indicatorColor: AppColors.primaryColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 1.0,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: TabBarView(
           controller: _tabController,
          children: [
            // Upcoming Tab
            Obx(
              () => appointmentsController.appointmentLoading.value
                  ? const CustomLoader()
                  : appointmentsController.appointmentList.isEmpty
                      ? Image.asset(AppImages.noDataImage)
                      : ListView.builder(
                          itemCount:
                              appointmentsController.appointmentList.length,
                          itemBuilder: (context, index) {
                            var appointments =
                                appointmentsController.appointmentList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AppointmentsCard(
                                image: AppImages.getStarted1,
                                name:
                                    "${appointments.doctorId?.firstName}${appointments.doctorId?.lastName}",
                                appointmentsType: "upcoming",
                                date: DateTime.now(),
                                messageIcon: AppIcons.messageIcon2,
                                time: "14:00 PM",
                                leftBtnName: 'Cancel Appointment',
                                rightBtnName: 'See Details',
                              ),
                            );
                          },
                        ),
            ),

            // Completed Tab
            Obx(
              () => appointmentsController.appointmentLoading.value
                  ? const CustomLoader()
                  : appointmentsController.appointmentList.isEmpty
                      ? Image.asset(AppImages.noDataImage)
                      : ListView.builder(
                          itemCount: appointmentsController.appointmentList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AppointmentsCard(
                                image: AppImages.getStarted1,
                                name: "Sagor Ahamed",
                                leftBtnName: 'See Details',
                                rightBtnName: 'Give Review',
                                appointmentsType: 'Completed',
                                date: DateTime.now(),
                                leftBtnOnTap: () {
                                  Get.toNamed(
                                      AppRoutes.userAppointmentsDetailsScreen);
                                },
                                rightBtnOnTap: () {
                                  Get.toNamed(AppRoutes.userGiveReviewScreen);
                                },
                                time: "14:00 PM",
                              ),
                            );
                          },
                        ),
            ),

            // Cancelled Tab
            Obx(
              () => appointmentsController.appointmentLoading.value
                  ? const CustomLoader()
                  : appointmentsController.appointmentList.isEmpty
                      ? Image.asset(AppImages.noDataImage)
                      : ListView.builder(
                          itemCount:  appointmentsController.appointmentList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AppointmentsCard(
                                image: AppImages.getStarted1,
                                name: "Sagor Ahamed",
                                appointmentsType: 'Cancelled',
                                date: DateTime.now(),
                                time: "14:00 PM",
                              ),
                            );
                          },
                        ),
            )
          ],
        ),
      ),
    );
  }
}

class AppointmentsCard extends StatelessWidget {
  final String? image;
  final String? name;
  final String? messageIcon;
  final String? appointmentsType;
  final DateTime? date;
  final String? time;
  final String? leftBtnName;
  final VoidCallback? leftBtnOnTap;
  final String? rightBtnName;
  final VoidCallback? rightBtnOnTap;

  const AppointmentsCard(
      {super.key,
      this.image,
      this.name,
      this.messageIcon,
      this.appointmentsType,
      this.date,
      this.time,
      this.leftBtnName,
      this.leftBtnOnTap,
      this.rightBtnName,
      this.rightBtnOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.fillColorE8EBF0,
          borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          children: [
            Row(
              children: [
                ///=======================Image=========================>
                Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
                    child: Image.asset(
                      "$image",
                      height: 120,
                      width: 110.w,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: 213.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ///==========================Doctor Name=========================>
                              Expanded(
                                child: CustomText(
                                    textAlign: TextAlign.start,
                                    text: "$name",
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600),
                              ),

                              ///=======================Message Icon=========================>
                              messageIcon == null
                                  ? const SizedBox()
                                  : Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffB8C1CF)),
                                      child: Padding(
                                        padding: EdgeInsets.all(6.r),
                                        child: SvgPicture.asset("$messageIcon"),
                                      )),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
                            children: [
                              CustomText(
                                  text: "Clinic Visit -  ",
                                  color: Colors.black,
                                  fontsize: 12.h,
                                  fontWeight: FontWeight.w500,
                                  top: 14.h,
                                  bottom: 14.h),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.h, horizontal: 10.w),
                                  child: CustomText(
                                    text: "$appointmentsType",
                                    fontWeight: FontWeight.w600,
                                    fontsize: 10.h,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          CustomText(
                            text:
                                "${TimeFormatHelper.formatDate(date!)} | $time",
                            color: Colors.black,
                            maxline: 2,
                            fontsize: 12.h,
                            top: 14.h,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            leftBtnName == null
                ? const SizedBox()
                : Column(
                    children: [
                      SizedBox(height: 14.h),
                      const Divider(),
                      SizedBox(height: 14.h),
                      CustomTwoButon(
                          btnRadius: 8,
                          width: 154.w,
                          btnNameList: ["$leftBtnName", '$rightBtnName'],
                          rightBtnOnTap: rightBtnOnTap,
                          leftBtnOnTap: leftBtnOnTap,
                          initialSeclected: 0)
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
