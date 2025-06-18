
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../helpers/toast_message_helper.dart';
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

  String price = '';
  String packageName = '';
  final RxInt selectedIndex = (-1).obs;


  @override
  Widget build(BuildContext context) {
    print('price ====< > $price');
    print('price ====< > $packageName');
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
                      title: addSpaceBeforeCapital("${package.packageName}"), // "${package.packageName}",
                      description: index == 0 ? 'Video call & messages with doctor' : "Virtual visit in doctors clinic",
                      price: '${package.packagePrice}',
                      icon: index == 0 ? AppIcons.videoCallIcons : AppIcons.personGroup,
                      selectedIndex: selectedIndex.value,
                      allIndex: index,
                      onTap: () {
                        setState(() {
                          selectedIndex.value = index;
                          price = package.packagePrice;
                          packageName = package.packageName;
                        });

                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 150.h),
            CustomButton(onpress: () {

              if(price == '' || packageName == ''){
                ToastMessageHelper.showToastMessage('Please Select Package');
              }else{
                Get.toNamed(AppRoutes.userBookScheduleScreen, arguments: widget.data.timeSlots, parameters: {
                  'id' : '${Get.parameters['id']}',
                  'price' : price,
                  'packageName' : packageName
                });
              }
            }, title: AppString.continues),

          ],
        ),
      ),
    );
  }

  String addSpaceBeforeCapital(String input) {
    String spaced = input.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
          (Match m) => '${m.group(1)} ${m.group(2)}',
    );

    return spaced[0].toUpperCase() + spaced.substring(1);
  }
}
