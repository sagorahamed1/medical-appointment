import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/pop_up_menu.dart';

class FillProfileScreen extends StatelessWidget {
  FillProfileScreen({super.key});

  final AuthController _authController = Get.put(AuthController());

  List genderList = ['Male', 'Female', "Others"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: AppString.fillPourProfile,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 24.h, horizontal: Dimensions.paddingSizeDefault.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Image.asset(
                    AppImages.fillProfile,
                    height: 144.h,
                    width: 144.w,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(AppIcons.galaryIcon),
                  )
                ],
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: CustomText(
                  text: AppString.uploadProfilePicture,
                  color: AppColors.textColor193664,
                  top: 8.h,
                  bottom: 24.h),
            ),

            ///=====================Gender ======================>
               CustomTextFieldWithoutBorder(
                readOnly: true,
                contenpaddingHorizontal: 20.w,
                contenpaddingVertical: 0.h,
                controller: _authController.genderCtrl,
                hintText: AppString.gender,
                sufixicons: PopUpMenu(
                  items: genderList,
                  selectedItem: "Male",
                  onTap: (int index) {
                  },

                )
            ),
            SizedBox(height: 16.h),

            ///=====================Date of birth ======================>
            CustomTextFieldWithoutBorder(
              contenpaddingHorizontal: 20.w,
              contenpaddingVertical: 0.h,
              controller: _authController.dateOfBirthCtrl,
              hintText: AppString.dateOfBirth,
              sufixicons: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: SvgPicture.asset(
                    AppIcons.calendar,
                    color: AppColors.gray767676,
                  )),
            ),

            SizedBox(height: 16.h),

            ///=====================mobile number ======================>
            CustomTextFieldWithoutBorder(
              contenpaddingHorizontal: 20.w,
              contenpaddingVertical: 0.h,
              hintText: AppString.mobileNumber,
              controller: _authController.mobileNumberCtrl,
            ),

            SizedBox(height: 16.h),

            ///=====================Address======================>
            CustomTextFieldWithoutBorder(
              maxLines: 3,
              contenpaddingHorizontal: 20.w,
              contenpaddingVertical: 15.h,
              hintText: AppString.address,
              controller: _authController.addressCtrl,
            ),

            SizedBox(height: 48.h),
            // const Spacer(),
            CustomButton(
                onpress: () {
                 AppConstants.roleMock == "doctor" ?Get.toNamed(AppRoutes.continueDoctorDetailsScreen) :  Get.toNamed(AppRoutes.signInScreen);
                },
                title: AppString.continues),

          ],
        ),
      ),
    );
  }
}


/*
Padding(
padding: EdgeInsets.only(left: 20.w, right: 20.w),
child: SvgPicture.asset(
AppIcons.dropdown,
color: AppColors.gray767676,
)),
*/


//
// class DropDown extends StatefulWidget {
//   const DropDown({super.key});
//
//   @override
//   State<DropDown> createState() => _DropDownState();
// }
//
// class _DropDownState extends State<DropDown> {
//   String? _selectedSpecialist;
//
//   final List<String> _specialists = [
//     'Dentist',
//     'Immunologists',
//     'Cardiologists',
//     'Neurologist',
//     'Orthopedics',
//     'Ophthalmologist',
//     'Therapist',
//     'Nutritionist',
//     'Gynecologic',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DropdownButton<String>(
//         value: _selectedSpecialist,
//         hint: Text('Select Specialist'),
//         items: _specialists.map((String specialist) {
//           return DropdownMenuItem<String>(
//             value: specialist,
//             child: Text(specialist),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             _selectedSpecialist = newValue!;
//           });
//         },
//       ),
//     );
//   }
// }