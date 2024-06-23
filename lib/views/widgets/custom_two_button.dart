import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'custom_text.dart';

class CustomTwoButon extends StatelessWidget {
  final List? btnNameList;
  final VoidCallback? leftBtnOnTap;
  final double? width;
  final double btnRadius;
  final int initialSeclected;
  final VoidCallback? rightBtnOnTap;

  const CustomTwoButon(
      {super.key, this.btnNameList, this.leftBtnOnTap, this.rightBtnOnTap, this.width,required this.initialSeclected, required this.btnRadius});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(btnNameList!.length, (index) {
        return GestureDetector(
          onTap: index == 0 ? leftBtnOnTap : rightBtnOnTap,

          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius:  BorderRadius.circular(btnRadius.r),
                color: index == 0+initialSeclected ? Colors.white : AppColors.primaryColor),
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomText(
                  text: btnNameList![index],
                  color: index == 0+initialSeclected ? AppColors.primaryColor : Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      }),
    );
  }
}