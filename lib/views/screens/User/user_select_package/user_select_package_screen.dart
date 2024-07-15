import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_select_package_card.dart';
import '../../../widgets/custom_text.dart';

class UserSelectPackageScreen extends StatefulWidget {
   UserSelectPackageScreen({super.key});
  var data = Get.arguments;

  @override
  State<UserSelectPackageScreen> createState() => _UserSelectPackageScreenState();
}

class _UserSelectPackageScreenState extends State<UserSelectPackageScreen> {

  final RxInt selectedIndex = 0.obs;

  List packageList = [
    {
      'icon' : AppIcons.videoCallIcons,
      'title' : "Online Consultation",
      "description" : "video call & messages with doctor"
    },
    {
      'icon' : AppIcons.personGroup,
      'title' : "Clinic Visit",
      "description" : "Virtual visit in doctors clinic"
    }
  ];

  @override
  Widget build(BuildContext context) {
    print('====> ${widget.data}');
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
                itemCount: widget.data.packages.length,
                itemBuilder: (context, index) {
                  var package = widget.data.packages[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: CustomSelectPackageCard(
                      title: "${package.packageName}",
                      description: index == 0 ? 'Video call & messages with doctor' : "Virtual visit in doctors clinic",
                      price: '${package.packagePrice}',
                      icon: index == 0 ? AppIcons.videoCallIcons : AppIcons.personGroup,
                      selectedIndex: selectedIndex.value,
                      allIndex: index,
                      onTap: () {
                        setState(() {
                          selectedIndex.value = index;
                        });

                      },
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            CustomButton(onpress: () {
              Get.toNamed(AppRoutes.userBookScheduleScreen, arguments: widget.data.timeSlots, parameters: {
                'id' : '${Get.parameters['id']}'
              });
            }, title: AppString.continues),
            SizedBox(height: 36.h)
          ],
        ),
      ),
    );
  }
}
