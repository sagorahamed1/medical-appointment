import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../helpers/image_pic_helper.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class EditProfileScreen extends StatefulWidget {


  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameCtrl = TextEditingController();

  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: CustomText(
          text: AppString.editProfile,
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
            Container(
              child: Center(
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
                      child: GestureDetector(
                          onTap: (){
                            showImagePickerOption(context);
                          },
                          child: SvgPicture.asset(AppIcons.galaryIcon)),
                    )
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: CustomText(
                  text: AppString.chageProfilePicture,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  top: 12.h,
                  bottom: 24.h),
            ),


            _textField("Enter your name", AppIcons.person, nameCtrl),
            _textField("Enter your email", AppIcons.email, nameCtrl),
            _textField("+ 8845632140", AppIcons.call, nameCtrl),
            _textField("16 July 2000", AppIcons.dateOfBirth, nameCtrl),
            _textField("Address", AppIcons.location, nameCtrl),
            SizedBox(height: 20.h),
            // const Spacer(),
            CustomButton(
                onpress: () {
                  Get.toNamed(AppRoutes.signInScreen);
                },
                title: AppString.continues),

            SizedBox(height: 20.h)
          ],
        ),
      ),
    );
  }

  Widget _textField(
      String hinText, prefixIcon, TextEditingController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hinText,
              hintStyle: const TextStyle(color: AppColors.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              prefixIcon: Padding(
                padding:  EdgeInsets.all(12.r),
                child: SvgPicture.asset(
                  prefixIcon,
                  color: AppColors.primaryColor,
                  height: 20.h,
                  width: 20.w,
                  fit: BoxFit.contain,
                ),
              )),
        ),

        SizedBox(height: 16.h)
      ],
    );
  }

  //==================================> ShowImagePickerOption Function <===============================
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: AppColors.gray767676,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                     final image =  ImagePickerHelper.pickImageFromGallery();
                     setState(() {
                       _image = image as File?;
                     });

                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                            ),
                             CustomText(text: 'Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        final image =    ImagePickerHelper.pickImageFromCamera();
                        setState(() {
                          _image = image as File?;
                        });
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                            ),
                             CustomText(text: 'Camera')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
