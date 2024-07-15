import 'package:doctor_appointment/controllers/user/home_controller.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserBookScheduleScreen extends StatefulWidget {
  UserBookScheduleScreen({super.key});

  @override
  State<UserBookScheduleScreen> createState() => _UserBookScheduleScreenState();
}

class _UserBookScheduleScreenState extends State<UserBookScheduleScreen> {
  HomeController homeController = Get.put(HomeController());
  DateTime selectedDate = DateTime.now();
  List<String> timeSlots = Get.arguments;
  String selectedTime = '';

  @override
  void initState() {
    super.initState();
    _loadDoctorDetails();
  }

  void _loadDoctorDetails() {
    timeSlots = [];
    homeController.getDoctorDetailsHomeScreen(
      date: '$selectedDate',
      id: '${Get.parameters['id']}',
    ).then((_) {
      setState(() {
        timeSlots = homeController.doctorDetails.value.timeSlots!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppString.bookSchedule,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimensions.paddingSizeDefault.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppString.selectDate,
                fontsize: 18.h,
                fontWeight: FontWeight.w600,
                bottom: 16.h,
              ),
              Container(
                height: 306.h,
                decoration: BoxDecoration(
                  color: AppColors.fillColorE8EBF0,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.r),
                  child: CalendarDatePicker(
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                      _loadDoctorDetails();
                    },
                  ),
                ),
              ),
              CustomText(
                text: AppString.selectTime,
                fontsize: 18.h,
                fontWeight: FontWeight.w600,
                bottom: 16.h,
                top: 20.h,
              ),

              timeSlots.isEmpty ? const Center(child: CustomLoader()) :
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: timeSlots.map<Widget>((time) {
                  return ChoiceChip(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    showCheckmark: false,
                    selectedColor: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primaryColor),
                    label: CustomText(
                      text: time,
                      fontWeight: FontWeight.w600,
                      fontsize: 16,
                      color: selectedTime == time ? Colors.white : AppColors.primaryColor,
                    ),
                    selected: selectedTime == time,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    onSelected: (selected) {
                      setState(() {
                        selectedTime = selected ? time : '';
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                onpress: () {
                  Get.toNamed(AppRoutes.userPatientDetailsScreen);
                },
                title: AppString.continues,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
