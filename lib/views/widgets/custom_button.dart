import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../helpers/toast_message_helper.dart';
import '../../main.dart';
import '../../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
   CustomButton(
      {super.key,
      this.color,
      this.textStyle,
      this.padding = EdgeInsets.zero,
      required this.onpress,
      required this.title,
      this.loading = false,
      this.width,
      this.height, this.isNetworkNeed = true});

  final Function() onpress;
  final String title;
  final bool loading;
  final bool? isNetworkNeed;
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  final ConnectivityService connectivityService = Get.put(ConnectivityService());
  // A helper method to handle the button's onPressed logic
  void _handleOnPressed() {
    if (!connectivityService.isConnected.value) {
      ToastMessageHelper.showToastMessage("Please Connect your internet");
    } else if (!loading) {
      onpress();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
          onPressed: isNetworkNeed == true ? _handleOnPressed : onpress,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            backgroundColor: color ?? AppColors.primaryColor,
            minimumSize: Size(width ?? Get.width, height ?? 53.h),
          ),
          child: loading
              ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  title,
                  style: textStyle ??
                      const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                )),
    );
  }
}
