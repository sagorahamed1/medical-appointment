import 'package:doctor_appointment/controllers/user/user_patient_details_controller.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class UserPatientDetailsScreen extends StatelessWidget {
  UserPatientDetailsScreen({super.key});

  final UserPatientDetailsController _patientDetailsController = Get.put(UserPatientDetailsController());
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();
  TextEditingController problemCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();



  var dropDownList = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {

    RxBool isDropDown = false.obs;
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.patientDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault.w,
              vertical: Dimensions.paddingSizeDefault.h),
          child: Obx(()=>
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///===================Write Full Name TextField================>?
                _textAndTextField(AppString.fullName, "Type your full name", "", fullNameCtrl, 1, TextInputType.text),
                CustomText(
                    text: AppString.selecteGender,
                    fontsize: 18.h,
                    fontWeight: FontWeight.w600,
                    bottom: 20.h),

                   CustomTextFieldWithoutBorder(
                     onTap: (){
                       if(isDropDown.value == true){
                         isDropDown(false);
                       }
                       isDropDown(true);
                     },
                     readOnly: true,
                     contenpaddingHorizontal: 20,
                     contenpaddingVertical: 0,
                     controller: genderCtrl,
                     hintText: 'Select gender',
                     sufixicons: Padding(
                       padding:
                           EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                       child: SvgPicture.asset(
                         AppIcons.arrowDown,
                         color: AppColors.primaryColor,
                         height: 20.h,
                         width: 20.w,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),

                SizedBox(height: 5.h),
                isDropDown.value?
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.fillColorE8EBF0,
                    borderRadius: BorderRadius.all(Radius.circular(8.r) )
                  ),
                  height: 142.h,
                  child: ListView.builder(
                    itemCount: dropDownList.length,
                    itemBuilder: (context, index) {
                      var dropDownItems = dropDownList[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.w),
                        title: CustomText(text: dropDownItems,textAlign: TextAlign.start),
                        onTap: (){
                          isDropDown(false);
                          genderCtrl.text = dropDownItems;
                        },
                      );
                    },
                  ),
                ) : const SizedBox() ,

                SizedBox(height: 16.h),
                ///===================Write you Age TextField================>
                _textAndTextField(AppString.yourAge, "Write your Age", "", ageCtrl, 1, TextInputType.number),
                ///===================Write Problem TextField================>?
                _textAndTextField(AppString.writeYourProblem, AppString.writeYourProblem, "", problemCtrl, 10, TextInputType.text),
                SizedBox(height: 20.h),
                CustomButton(onpress: () {
                  _patientDetailsController.patienDetailsAdd(
                    fullName: fullNameCtrl.text,
                    age: ageCtrl.text,
                    gender: genderCtrl.text,
                    description: problemCtrl.text,
                    doctorId: "${Get.parameters['id']}",
                    price: "${Get.parameters['price']}",
                    packName: "${Get.parameters['packageName']}",
                    timeSlot: "${Get.parameters['timeSlot']}",
                    date: '${Get.parameters['date']}'
                  );
                }, title: AppString.continues),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textAndTextField(String title, hinText, icon,
      TextEditingController controller, int maxLine, TextInputType keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
            text: "$title",
            fontsize: 18.h,
            fontWeight: FontWeight.w600,
            bottom: 20.h),
        CustomTextFieldWithoutBorder(
          contenpaddingHorizontal: 20,
          contenpaddingVertical: 10,
          controller: controller,
          maxLines: maxLine,
          keyboardType: keyboardType,
          hintText: '$hinText',
          sufixicons: icon == ""
              ? const SizedBox()
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                  child: SvgPicture.asset(
                    AppIcons.arrowDown,
                    color: AppColors.primaryColor,
                    height: 20.h,
                    width: 20.w,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        SizedBox(height: 16.h)
      ],
    );
  }
}
