import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class SelectPackageScreen extends StatefulWidget {
  SelectPackageScreen({super.key});

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  final RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.selectPackage,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [
            SizedBox(
              height: 400.h,
              child:  ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: SelectPackageCard(
                      title: "Online Consultation ",
                      description: "Video call & messages with doctor",
                      price: 40,
                      icon: AppIcons.videoCallIcons,
                      selectedIndex: selectedIndex.value,
                      allIndex: index,
                      onTap: () {
                        selectedIndex.value = index;
                        print('Selected index: $index');
                      },
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            CustomButton(onpress: () {}, title: AppString.continues),
            SizedBox(height: 36.h)
          ],
        ),
      ),
    );
  }
}

class SelectPackageCard extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? description;
  final double? price;
  final int? selectedIndex;
  final int? allIndex;
  final VoidCallback onTap;

  const SelectPackageCard(
      {super.key,
        this.icon,
        this.title,
        this.description,
        this.price,
        required this.onTap,
        this.selectedIndex,
        this.allIndex});

  @override
  Widget build(BuildContext context) {
    print("====================$allIndex and $selectedIndex");
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: AppColors.fillColorE8EBF0,
            border: Border.all(
                color: selectedIndex == allIndex
                    ? AppColors.primaryColor
                    : AppColors.fillColorE8EBF0)),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffB8C1CF)),

                ///=======================Icon===========================>
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SvgPicture.asset(
                    '$icon',
                    height: 28.h,
                    width: 28.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(
                width: 170.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///===============================Title========================:>
                    CustomText(
                        text: "$title",
                        fontWeight: FontWeight.w600,
                        fontsize: 16.h),
                    SizedBox(height: 8.h),

                    ///===============================description========================:>
                    CustomText(
                        text: "$description",
                        fontWeight: FontWeight.w400,
                        fontsize: 12.h,
                        maxline: 3,
                        textAlign: TextAlign.start),
                  ],
                ),
              ),

              ///===============================price========================:>
              Flexible(
                  child: CustomText(
                      text: "\$${price}",
                      fontWeight: FontWeight.w600,
                      fontsize: 18.h,
                      color: AppColors.primaryColor)),
            ],
          ),
        ),
      ),
    );
  }
}
