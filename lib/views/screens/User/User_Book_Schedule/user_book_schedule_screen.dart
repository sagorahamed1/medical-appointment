import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserBookScheduleScreen extends StatefulWidget {
  const UserBookScheduleScreen({super.key});

  @override
  State<UserBookScheduleScreen> createState() => _UserBookScheduleScreenState();
}

class _UserBookScheduleScreenState extends State<UserBookScheduleScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';

  List<String> times = [
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
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
                  bottom: 16.h),

              ///========================Calender=======================>
              Container(
                height: 306.h,
                decoration: BoxDecoration(
                    color: AppColors.fillColorE8EBF0,
                    borderRadius: BorderRadius.circular(8.r)),
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
                    },
                  ),
                ),
              ),

              CustomText(
                  text: AppString.selectTime,
                  fontsize: 18.h,
                  fontWeight: FontWeight.w600,
                  bottom: 16.h,
                  top: 20.h),

              ///==========================Select Time Lists=============================>
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: times.map((time) {
                  return ChoiceChip(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                    showCheckmark: false,
                    selectedColor: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.primaryColor),
                    label: CustomText(text: time,fontWeight: FontWeight.w600,fontsize: 16,color: selectedTime == time ? Colors.white : AppColors.primaryColor),
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
            ],
          ),
        ),
      ),
    );
  }
}
