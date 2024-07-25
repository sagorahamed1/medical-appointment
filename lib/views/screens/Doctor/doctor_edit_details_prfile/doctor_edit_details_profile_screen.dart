import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/doctor_details_controller_doctor_part.dart';
import '../../../../helpers/time_format.dart';
import '../../../../models/doctor/doctor_details_molel_doctor_part.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_doctor_time_available_card.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field_without_border.dart';

class DoctorEditDetailsProfileScreen extends StatefulWidget {
  DoctorDetailsModelDoctorPart? doctorData;
   DoctorEditDetailsProfileScreen({super.key, this.doctorData});

  @override
  State<DoctorEditDetailsProfileScreen> createState() => _DoctorEditDetailsProfileScreenState();
}

class _DoctorEditDetailsProfileScreenState extends State<DoctorEditDetailsProfileScreen> {

  DoctorDetailsControllerDoctorPart doctorDetailsCtrl =
  Get.put(DoctorDetailsControllerDoctorPart());


  TextEditingController specialistCtrl = TextEditingController();
  TextEditingController experienceCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController aboutDoctorCtrl = TextEditingController();
  TextEditingController priceForClinicCtrl = TextEditingController();
  TextEditingController priceForOnlineCtrl = TextEditingController();
  TextEditingController priceForEmargenceCtrl = TextEditingController();

  @override
  void initState() {
    specialistCtrl.text = widget.doctorData?.specialist.toString() ?? '';
    experienceCtrl.text = widget.doctorData?.experience.toString() ?? '';
    addressCtrl.text = widget.doctorData?.clinicAddress.toString() ?? '';
    aboutDoctorCtrl.text = widget.doctorData?.about.toString() ?? '';
    priceForClinicCtrl.text = widget.doctorData?.clinicPrice.toString() ?? '';
    priceForOnlineCtrl.text = widget.doctorData?.onlineConsultationPrice.toString() ?? '';
    priceForEmargenceCtrl.text = widget.doctorData?.emergencyPrice.toString() ?? '';
    super.initState();
  }



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
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.editDoctorDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
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
                  hintText: "Cardiologists",
                  controller: specialistCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: "2 Years Experience",
                  controller: experienceCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "2972 Westheimer Rd. Santa Ana, Illinois 85486 ",
                  controller: addressCtrl),

              SizedBox(height: 16.h),
              CustomTextFieldWithoutBorder(
                  maxLines: 4,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
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
              SizedBox(height: 20.h),


              ///=======================Price for Clinic Controller ============================>
              CustomTextFieldWithoutBorder(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "Set Price for clinic visit",
                  controller: priceForClinicCtrl),

              SizedBox(height: 16.h),

              ///=======================Price for Online Controller ============================>
              CustomTextFieldWithoutBorder(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "Set Price for online consultation",
                  controller: priceForOnlineCtrl),

              SizedBox(height: 16.h),

              ///=======================Price for emergency Controller ============================>
              CustomTextFieldWithoutBorder(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 15,
                  hintText: "Set Price for emergency consultation",
                  controller: priceForEmargenceCtrl),

              SizedBox(height: 20.h),

              CustomButton(
                loading: doctorDetailsCtrl.doctorDetailsLoading.value,
                  onpress: (){
                doctorDetailsCtrl.continueDoctorDetailsEdit(
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



              }, title: AppString.updateDetails),

              SizedBox(height: 35.h)
            ],
          ),
        ),
      ),
    );
  }
}
