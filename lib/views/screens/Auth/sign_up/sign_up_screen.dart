import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_strings.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameCtrl = TextEditingController();

  TextEditingController lastNameCtrl = TextEditingController();

  TextEditingController emailCtrl = TextEditingController();

  TextEditingController passwordCtrl = TextEditingController();

  TextEditingController confirmPasswordCtrl = TextEditingController();

   bool _isChecked = false;

   bool isCheckboxError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: AppString.signUp,fontsize: 18.h),
      ),

      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault.w, vertical: Dimensions.paddingSizeDefault.h),
        child: Column(
          children: [

            CustomText(text: AppString.signUpToJoin,  bottom: 24.h),

            ///==========================first name ============================>
            CustomTextField(
                contenpaddingHorizontal: 20,
                contenpaddingVertical: 20,
                controller: firstNameCtrl,
               hintText: AppString.firstName,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.person, color: AppColors.gray767676,)),
            ),



            SizedBox(height: 16.h),
            ///==========================last name ============================>
            CustomTextField(
              contenpaddingHorizontal: 20,
              contenpaddingVertical: 20,
              controller: lastNameCtrl,
              hintText: AppString.lastName,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.person, color: AppColors.gray767676,)),
            ),




            SizedBox(height: 16.h),
            ///==========================email name ============================>
            CustomTextField(
              contenpaddingHorizontal: 20,
              contenpaddingVertical: 20,
              controller: emailCtrl,
              hintText: AppString.email,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.email, color: AppColors.gray767676,)),
            ),



            SizedBox(height: 16.h),
            ///==========================password name ============================>
            CustomTextField(
              contenpaddingHorizontal: 20,
              contenpaddingVertical: 20,
              controller: passwordCtrl,
              hintText: AppString.password,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.email, color: AppColors.gray767676,)),

              ///===============sufix Icon==================>
              sufixicons: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.obsecureHide, color: AppColors.gray767676,)),
            ),



            SizedBox(height: 16.h),
            ///==========================confirm password name ============================>
            CustomTextField(
              contenpaddingHorizontal: 20,
              contenpaddingVertical: 20,
              controller: confirmPasswordCtrl,
              hintText: AppString.confirmPassword,
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.email, color: AppColors.gray767676,)),


              ///===============sufix Icon==================>
              sufixicons: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 12.w),
                  child: SvgPicture.asset(AppIcons.obsecureHide, color: AppColors.gray767676,)),
            ),


            SizedBox(height: 24.h),

            _checkbox(),


            SizedBox(height: 104.h),


            CustomButton(onpress: (){}, title: AppString.signUp),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: AppString.alreadyHaveAnAccount),
                CustomText(text: AppString.signUp,color: AppColors.primaryColor),
              ],
            )
          ],
        ),
      ),
    );
  }

   _checkbox() {
     return Row(
       children: [
         Checkbox(
           value: _isChecked,
           activeColor: AppColors.primaryColor,
           isError: isCheckboxError,
           onChanged: (bool? value) {
             setState(() {
               _isChecked = value!;
             });
           },
         ),
         FittedBox(
           fit: BoxFit.cover,
           child: RichText(
             maxLines: 5,
             text: TextSpan(
               style: TextStyle(
                 fontSize: 14.h,
                 color: Colors.black,
                 overflow: TextOverflow.ellipsis,
               ),
               //===============================> By Creating An Account TextSpan Section <===============================
               children: <TextSpan>[
                 TextSpan(
                   text: AppString.byCratingAnAccount,
                   style: const TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: Dimensions.fontSizeDefault,
                     overflow: TextOverflow.ellipsis,
                     color: Colors.black,
                     fontFamily: "OpenSans-Regular",
                   ),
                 ),
                 TextSpan(
                     text: AppString.termsCondition,
                     style: const TextStyle(
                       fontWeight: FontWeight.w400,
                       overflow: TextOverflow.ellipsis,
                       fontSize: Dimensions.fontSizeDefault,
                       color: AppColors.primaryColor,
                       fontFamily: "OpenSans-Regular",
                     ),
                     recognizer: TapGestureRecognizer()
                       ..onTap = () {
                         //==========================> on tap here <==========================
                         // Get.toNamed(AppRoutes.termsConditionScreen);
                       }),
                 const TextSpan(
                   text: ' & ',
                   style: TextStyle(
                     fontWeight: FontWeight.w400,
                     fontSize: Dimensions.fontSizeDefault,
                     color: Colors.black,
                     fontFamily: "OpenSans-Regular",
                   ),
                 ),
                 TextSpan(
                     text: AppString.privacyPolicy,
                     style: const TextStyle(
                       fontWeight: FontWeight.w400,
                       fontSize: Dimensions.fontSizeDefault,
                       color: AppColors.primaryColor,
                       fontFamily: "OpenSans-Regular",
                     ),
                     recognizer: TapGestureRecognizer()
                       ..onTap = () {
                         //==========================> on tap here <==========================
                         // Get.toNamed(AppRoutes.privacyPolicyScreen);
                       }),
               ],
             ),
           ),
         ),
       ],
     );
   }
}
