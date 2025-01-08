import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final Color? borderColor;
  final VoidCallback onTap;
  const CustomListTile({
    super.key,
    required this.title,
    this.prefixIcon,
    this.sufixIcon,
    this.borderColor, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1.w, color: borderColor ?? Colors.black)),
      child: ListTile(
        onTap: onTap,
        leading: prefixIcon,
        trailing: sufixIcon,
        horizontalTitleGap: 10.w,
        dense: true,
        title: CustomText(
          textAlign: TextAlign.left,
          text: title,
          maxline: 2,
          fontsize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
