import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/utils/app_images.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/image_pic_helper.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimentions.dart';
import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/pop_up_menu.dart';

class FillProfileScreen extends StatefulWidget {
  FillProfileScreen({super.key});

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List genderList = ['male', 'female'];

  // File? image;
  DateTime selectedDate = DateTime.now();
  Uint8List? _image;
  File? selectedIMage;
  File? insuranceImageFile;
  Uint8List? insuranceImageUint;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePickerInsurence.pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        insuranceImageUint = pickedImage;
        insuranceImageFile = File.fromRawPath(pickedImage);
      });
    }
  }

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 105.h,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryColor, width: 0.5),
                          ),
                          child: _image != null
                              ? CircleAvatar(
                                  radius: 60.r, backgroundImage: MemoryImage(_image!))
                              : Container(
                                  clipBehavior: Clip.antiAlias,
                                  height: 100.h,
                                  width: 100.w,
                                  decoration:
                                      const BoxDecoration(shape: BoxShape.circle),
                                  child:
                                      // profileData?.image?.publicFileUrl == null || profileData?.image?.publicFileUrl == '' ?
                                      // CachedNetworkImage(
                                      //   imageUrl:  "${ApiConstant.imageBaseUrl}/${profileData?.image
                                      //       ?.publicFileUrl}",fit: BoxFit.cover,)
                                      //     :
                                      Image.asset(
                                    AppImages.fillProfile,
                                    fit: BoxFit.cover,
                                  )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                              onTap: () {
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
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return "Please select your gender";
                      }
                      return null;
                    },
                    sufixicons: PopUpMenu(
                      items: genderList,
                      selectedItem: "male",
                      onTap: (int index) {
                        _authController.genderCtrl.text = genderList[index];
                      },
                    )),
                SizedBox(height: 16.h),

                ///=====================Date of birth ======================>
                CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 0.h,
                  controller: _authController.dateOfBirthCtrl,
                  hintText: AppString.dateOfBirth,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Please select date of birth";
                    }
                    return null;
                  },
                  sufixicons: GestureDetector(
                    onTap: (){
                      selectDate(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: SvgPicture.asset(
                          AppIcons.calendar,
                          color: AppColors.gray767676,
                        )),
                  ),
                ),

                SizedBox(height: 16.h),


                ///=====================mobile number ======================>
                CustomTextFieldWithoutBorder(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 0.h,
                  hintText: AppString.mobileNumber,
                  controller: _authController.mobileNumberCtrl,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Enter your mobile number";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                ///=====================Address======================>
                CustomTextFieldWithoutBorder(
                  maxLines: 3,
                  contenpaddingHorizontal: 20.w,
                  contenpaddingVertical: 15.h,
                  hintText: AppString.address,
                  controller: _authController.addressCtrl,
                  validator: (value){
                    if (value == null || value.isEmpty) {
                      return "Enter your address";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 60.h,
                    width: 353.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.fillColorE8EBF0,
                      borderRadius: BorderRadius.circular(8)),
                    child: insuranceImageUint != null
                        ? Image.memory(
                      insuranceImageUint!,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    )
                        :  Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "insurance",left: 20.w),
                            Padding(
                              padding:  EdgeInsets.only(right: 20.w),
                              child: SvgPicture.asset(AppIcons.attachFile),
                            ),
                          ],
                        )),
                  ),
                ),

                SizedBox(height: 48.h),
                // const Spacer(),
                CustomButton(
                   // loading: _authController.fillProfileLoading.value,
                    onpress: () {
                     if(_formKey.currentState!.validate()){
                       _authController.fillProfileOrUpDate(selectedIMage);
                     }
                    },
                    title: AppString.continues),

                SizedBox(height: 200.h),
              ],
            ),
          ),
        ),
      ),
    );
  }


  //==================================> ShowImagePickerOption Function <===============================

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();
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
                        _pickImageFromCamera();
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

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    // Get.back();
  }

  //==================================> Calender <==================================
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      _authController.dateOfBirthCtrl.text = TimeFormatHelper.formatDate(selectedDate);
      print('Selected date: ${_authController.dateOfBirthCtrl.text}');
    }
  }
}


class ImagePickerInsurence {
  //==================================> Gallery <===============================
  static Future<Uint8List?> pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      return await File(returnImage.path).readAsBytes();
    }
    return null;
  }
}
