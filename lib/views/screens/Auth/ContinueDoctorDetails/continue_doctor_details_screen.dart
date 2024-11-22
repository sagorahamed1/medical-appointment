import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/controllers/user/home_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_doctor_time_available_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class ContinueDoctorDetailsScreen extends StatefulWidget {
  ContinueDoctorDetailsScreen({super.key});

  @override
  State<ContinueDoctorDetailsScreen> createState() =>
      _ContinueDoctorDetailsScreenState();
}

class _ContinueDoctorDetailsScreenState
    extends State<ContinueDoctorDetailsScreen> {
  TextEditingController specialistCtrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController aboutDoctorCtrl = TextEditingController();
  TextEditingController priceForClinicCtrl = TextEditingController();
  TextEditingController priceForOnlineCtrl = TextEditingController();
  TextEditingController priceForEmargenceCtrl = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  final HomeController _homeController = Get.put(HomeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> experience = [
    '1 Year',
    '2 Years',
    '3 Years',
    '4 Years',
    '5 Years',
    '6 Years',
    '7 Years',
    '8 Years',
    '9 Years',
    '10 Years',
    '11 Years',
    '12 Years',
    '13 Years',
  ];

  String mondayStart = '08:00';
  String mondayEnd = '14:00';
  String tuesDayStart = '08:00';
  String tuesDayEnd = '14:00';
  String wednesdayStart = '08:00';
  String wednesdayEnd = '14:00';
  String thursdayStart = '08:00';
  String thursdayEnd = '14:00';
  String fridayStart = '08:00';
  String fridayEnd = '14:00';
  String saturdayStart = '08:00';
  String saturdayEnd = '14:00';
  String sundayStart = '08:00';
  String sundayEnd = '14:00';

  @override
  Widget build(BuildContext context) {
    _homeController.getCetegory();
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.doctorDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: AppString.pleaseFillUpTheDetailsToJoinAsDoctor,
                    fontsize: 18.h,
                    color: Colors.black,
                    maxline: 2,
                    bottom: 15.h,
                    textAlign: TextAlign.start),

                SizedBox(height: 16.h),
                CustomTextFieldWithoutBorder(
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 0,
                    hintText: "Specialist",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select your specialist";
                      }
                      return null;
                    },
                    sufixicons: PopUpMenu(
                      items: _homeController.cetegoryNames,
                      selectedItem: "Dentist",
                      onTap: (int selceted) {
                        specialistCtrl.text =
                            _homeController.cetegoryNames[selceted];
                      },
                    ),
                    controller: specialistCtrl),

                SizedBox(height: 16.h),
                CustomTextFieldWithoutBorder(
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 0,
                    hintText: "2 Years Experience",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Select your experience";
                      }
                      return null;
                    },
                    sufixicons: PopUpMenu(
                      items: experience,
                      selectedItem: "1 Year",
                      onTap: (int selceted) {
                        experienceCtrl.text = experience[selceted];
                      },
                    ),
                    controller: experienceCtrl),

                SizedBox(height: 16.h),
                CustomTextFieldWithoutBorder(
                    maxLines: 4,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 15,
                    hintText: "Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your address";
                      }
                      return null;
                    },
                    controller: addressCtrl),

                SizedBox(height: 16.h),
                CustomTextFieldWithoutBorder(
                    maxLines: 4,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Type something about you!";
                      }
                      return null;
                    },
                    hintText: "About Doctor",
                    controller: aboutDoctorCtrl),

                ///=======================Avoidable Doctors=====================>
                CustomText(
                    text: AppString.availableDoctors,
                    top: 16.h,
                    bottom: 10.h,
                    fontsize: 16.h,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    textAlign: TextAlign.start),

                ///====================monday ================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        mondayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        mondayEnd = selectTime;
                      });
                    });
                  },
                  startTime: mondayStart,
                  endTime: mondayEnd,
                  dayName: AppString.monday,
                ),

                ///====================tuesday ================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        tuesDayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        tuesDayEnd = selectTime;
                      });
                    });
                  },
                  startTime: tuesDayStart,
                  endTime: tuesDayEnd,
                  dayName: AppString.tuesday,
                ),

                ///====================wednesday ================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        wednesdayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        wednesdayEnd = selectTime;
                      });
                    });
                  },
                  startTime: wednesdayStart,
                  endTime: wednesdayEnd,
                  dayName: AppString.wednesday,
                ),

                ///==================Thursday====================?
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        thursdayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        thursdayEnd = selectTime;
                      });
                    });
                  },
                  startTime: thursdayStart,
                  endTime: thursdayEnd,
                  dayName: AppString.thursday,
                ),

                ///===============Friday==================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        fridayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        fridayEnd = selectTime;
                      });
                    });
                  },
                  startTime: fridayStart,
                  endTime: fridayEnd,
                  dayName: AppString.friday,
                ),

                ///===================Saturday==================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        saturdayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        saturdayEnd = selectTime;
                      });
                    });
                  },
                  startTime: saturdayStart,
                  endTime: saturdayEnd,
                  dayName: AppString.saturday,
                ),

                ///===================Sunday=====================>
                CustomDoctorTimeAvailableCard(
                  onTapStart: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        sundayStart = selectTime;
                      });
                    });
                  },
                  onTapEnd: () {
                    TimeFormatHelper.selectTime(context, (selectTime) {
                      setState(() {
                        sundayEnd = selectTime;
                      });
                    });
                  },
                  startTime: sundayStart,
                  endTime: sundayEnd,
                  dayName: AppString.sunday,
                ),

                SizedBox(height: 16.h),

                ///=======================Price for Clinic Controller ============================>
                CustomTextFieldWithoutBorder(
                    keyboardType: TextInputType.number,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your clinic price";
                      }
                      return null;
                    },
                    hintText: "Set Price for clinic visit",
                    controller: priceForClinicCtrl),

                SizedBox(height: 16.h),

                ///=======================Price for Online Controller ============================>
                CustomTextFieldWithoutBorder(
                    keyboardType: TextInputType.number,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your online price";
                      }
                      return null;
                    },
                    hintText: "Set Price for online consultation",
                    controller: priceForOnlineCtrl),

                SizedBox(height: 16.h),

                ///=======================Price for emergency Controller ============================>
                CustomTextFieldWithoutBorder(
                    keyboardType: TextInputType.number,
                    contenpaddingHorizontal: 20,
                    contenpaddingVertical: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your emergency price";
                      }
                      return null;
                    },
                    hintText: "Set Price for emergency consultation",
                    controller: priceForEmargenceCtrl),

                SizedBox(height: 20.h),

                Obx(()=>
                   CustomButton(
                    loading: _authController.continueDoctorDetailLoading.value,
                      onpress: () {
                        if (_formKey.currentState!.validate()) {
                          _authController.continueDoctorDetails(
                            specialist: specialistCtrl.text,
                            experience: experienceCtrl.text,
                            clinicAddress: addressCtrl.text,
                            about: aboutDoctorCtrl.text,
                            clinicPrice: priceForClinicCtrl.text,
                            onlineConsultationPrice: priceForOnlineCtrl.text,
                            emergencyPrice: priceForEmargenceCtrl.text,
                            mondayStart: mondayStart,
                            mondayEnd: mondayEnd,
                            tuesdayStart: tuesDayStart,
                            tuesdayEnd: tuesDayEnd,
                            wednesdayStart: wednesdayStart,
                            wednesdayEnd: wednesdayEnd,
                            thursdayStart: thursdayStart,
                            thursdayEnd: thursdayEnd,
                            fridayStart: fridayStart,
                            fridayEnd: fridayEnd,
                            saturdayStart: saturdayStart,
                            saturdayEnd: saturdayEnd,
                            sundayStart: sundayStart,
                            sundayEnd: sundayEnd,
                          );
                        }
                      },
                      title: AppString.continues),
                ),

                SizedBox(height: 35.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
