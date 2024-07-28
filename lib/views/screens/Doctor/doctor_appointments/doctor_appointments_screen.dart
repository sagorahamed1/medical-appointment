import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_two_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/doctor_home_controller.dart';
import '../../../../helpers/newwork_connection.dart';
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

  final DoctorHomeControllerDoctorPart _homeController = Get.put(DoctorHomeControllerDoctorPart());
  final NetworkController networkController = Get.put(NetworkController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addScrollListener();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _homeController.loadMore();
        print("load more true");
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    _tabController?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    print("============> ${ networkController.isConnected ? 'Connected' : 'Not Connected'}");
    // _homeController.getAppointment();
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.appointments,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
        bottom: TabBar(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          controller: _tabController,
          onTap: (int value) {
            if (value == 0) {
              _homeController.appointmentsList.clear();
              _homeController.page.value = 1;
              _homeController.getAppointment(status: 'upcomming');
            } else if (value == 1) {
              _homeController.appointmentsList.clear();
              _homeController.page.value = 1;
              _homeController.getAppointment(status: 'active');
            } else {
              _homeController.appointmentsList.clear();
              _homeController.page.value = 1;
              _homeController.getAppointment(status: 'completed');
            }
          },
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Active'),
            Tab(text: 'completed'),
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
            Obx(()=>
            _homeController.appointmentLoading.value ? Center(child: Padding(
              padding:  EdgeInsets.only(top: 100.h),
              child: const CustomLoader(),
            )) : _homeController.appointmentsList.isEmpty ? Image.asset(AppImages.noDataImage) :
               ListView.builder(
                 controller: _scrollController,
                itemCount: _homeController.appointmentsList.length+1,
                itemBuilder: (context, index) {

                  if(index < _homeController.appointmentsList.length){
                    var appointment = _homeController.appointmentsList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: AppointmentsCard(
                        image: AppImages.getStarted1,
                        name: "${appointment.patientId?.firstName} ${appointment.patientId?.lastName}",
                        appointmentsType: "${appointment.status}",
                        date: appointment.createdAt,
                        time:  TimeFormatHelper.timeFormat(appointment.createdAt!),
                        btnText: 'See Details',
                        btnOnTap: () {
                          Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen, parameters: {
                            'id' : '${appointment.id}',
                            'type' : 'upcomming'
                          });
                        },
                      ),
                    );
                  }else if (index >=
                      _homeController.totalResult) {
                    return null;
                  } else {
                    return const CustomLoader();
                  }

                },
              ),
            ),

            ///=======================Active Lists====================>
            Obx(()=>
               _homeController.appointmentLoading.value ? Center(child: Padding(
                 padding:  EdgeInsets.only(top: 100.h),
                 child: const CustomLoader(),
               )) : _homeController.appointmentsList.isEmpty ? Image.asset(AppImages.noDataImage) :
               ListView.builder(
                 controller: _scrollController,
                itemCount: _homeController.appointmentsList.length+1,
                itemBuilder: (context, index) {
                  if(index < _homeController.appointmentsList.length){
                    var appointment = _homeController.appointmentsList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: AppointmentsCard(
                        image: AppImages.getStarted1,
                        name: "${appointment.patientId?.firstName} ${appointment.patientId?.lastName}",
                        leftBtnName: 'See Details',
                        rightBtnName: 'Message',
                        appointmentsType:  "${appointment.status}",
                        date: appointment.createdAt,
                        time:  TimeFormatHelper.timeFormat(appointment.createdAt!),
                        leftBtnOnTap: () {
                          Get.toNamed(AppRoutes.dcotorAppointmentsDetailsScreen, parameters: {
                            'id' : "${appointment.id}"
                          });
                        },
                        rightBtnOnTap: () {
                           Get.toNamed(AppRoutes.chatScreen);
                        },

                      ),
                    );
                  }else if (index >=
                      _homeController.totalResult) {
                    return null;
                  } else {
                    return const CustomLoader();
                  }

                },
              ),
            ),

            ///=======================completed Lists====================>
            Obx(()=>
            _homeController.appointmentLoading.value ? Center(child: Padding(
              padding:  EdgeInsets.only(top: 100.h),
              child: const CustomLoader(),
            )) : _homeController.appointmentsList.isEmpty ? Image.asset(AppImages.noDataImage) :
               ListView.builder(
                 controller: _scrollController,
                itemCount: _homeController.appointmentsList.length+1,
                itemBuilder: (context, index) {
                  if(index < _homeController.appointmentsList.length){
                    var appointment = _homeController.appointmentsList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: AppointmentsCard(
                        image: AppImages.getStarted1,
                        name: "${appointment.patientId?.firstName} ${appointment.patientId?.lastName}",
                        appointmentsType:  "${appointment.status}",
                        date: appointment.createdAt,
                        time:  TimeFormatHelper.timeFormat(appointment.createdAt!),
                        leftBtnName: 'See Details',
                        rightBtnName: 'Send Prescription',
                      ),
                    );
                  }else if (index >= _homeController.totalResult) {
                    return null;
                  } else {
                    return const CustomLoader();
                  }

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
  final String? btnText;
  final VoidCallback? btnOnTap;

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
        this.rightBtnOnTap, this.btnText, this.btnOnTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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

            leftBtnName == null ? Column(
              children: [
                SizedBox(height: 14.h),
                GestureDetector(
                  onTap: btnOnTap,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: AppColors.primaryColor
                    ),
                    child: Center(
                      child: CustomText(text: '$btnText', color: Colors.white),
                    ),
                  ),
                )
              ],
            )
                :

            Column(
              children: [
                SizedBox(height: 14.h),
                const Divider(),
                SizedBox(height: 14.h),
                leftBtnName == null ? CustomButton(onpress: (){btnOnTap;}, title: '$btnText') :
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
