import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final Color? bgColor;
  const CustomLoader({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      color: bgColor ?? AppColors.primaryColor,
      size: 48.h
    );
  }
}
