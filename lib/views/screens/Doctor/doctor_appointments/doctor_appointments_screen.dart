import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() => _UserAppointmentsScreenState();
}

class _UserAppointmentsScreenState extends State<DoctorAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.appointments,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
        bottom: TabBar(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          controller: _tabController,
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
            ///=======================Up Coming Lists====================>
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: AppointmentsCard(
                      image: AppImages.getStarted1,
                      name: "Sagor Ahamed",
                      appointmentsType: "Upcoming",
                      date: DateTime.now(),
                      messageIcon: AppIcons.messageIcon2,
                      time: "14:00 PM",
                      leftBtnName: 'Cancel Appoinment',
                      rightBtnName: 'See Details',
                    ),
                  );
                },
              ),
            ),

            ///=======================Completed Lists====================>
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: AppointmentsCard(
                      image: AppImages.getStarted1,
                      name: "Sagor Ahamed",
                      leftBtnName: 'See Details',
                      rightBtnName: 'Give Review',
                      appointmentsType: 'Completed',
                      date: DateTime.now(),
                      leftBtnOnTap: (){
                        Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen);
                      },
                      rightBtnOnTap: (){
                        Get.toNamed(AppRoutes.userGiveReviewScreen);
                      },

                      time: "14:00 PM",
                    ),
                  );
                },
              ),
            ),



            ///=======================Cancelled Lists====================>
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
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
            ),
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

            leftBtnName == null ? const SizedBox() :

            Column(
              children: [
                SizedBox(height: 14.h),
                const Divider(),
                SizedBox(height: 14.h),
                CustomTwoButon(
                  btnRadius: 100,
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
