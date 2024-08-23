import 'dart:io';
import 'dart:typed_data';

import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/views/widgets/cachanetwork_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  final ProfileControler _profileControler = Get.find<ProfileControler>();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController lastNameCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  var profileData = Get.arguments;

  // File? _image;
  DateTime selectedDate = DateTime.now();
  Uint8List? _image;
  File? selectedIMage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      firstNameCtrl.text = profileData.firstName ?? '';
      lastNameCtrl.text = profileData.lastName ?? '';
      phoneCtrl.text = profileData.phone ?? '';
      dateOfBirthCtrl.text = profileData.dateOfBirth ?? '';
      addressCtrl.text = profileData.address ?? '';
    });
  }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.h,
                child: Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 60.r,
                              backgroundImage: MemoryImage(_image!))
                          : profileData.image?.publicFileUrl != null
                              ? CustomNetworkImage(
                        boxShape: BoxShape.circle,
                                  imageUrl:
                                      '${ApiConstants.imageBaseUrl}/${profileData.image?.publicFileUrl}',
                                  height: 144.h,
                                  width: 144.w)
                              : Image.asset(
                                  AppImages.fillProfile,
                                  height: 144.h,
                                  width: 144.w,
                                  fit: BoxFit.cover,
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
                    text: AppString.chageProfilePicture,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    top: 12.h,
                    bottom: 24.h),
              ),

              _textField("Enter your first name", AppIcons.person,
                  firstNameCtrl, TextInputType.text),
              _textField("Enter your last name", AppIcons.person, lastNameCtrl,
                  TextInputType.text),
              _textField("+ 8845632140", AppIcons.call, phoneCtrl,
                  TextInputType.number),
              _textField("Enter your date of birth", AppIcons.dateOfBirth,
                  dateOfBirthCtrl, TextInputType.number),
              _textField("Address", AppIcons.location, addressCtrl,
                  TextInputType.text),
              SizedBox(height: 20.h),
              // const Spacer(),
              CustomButton(
                  onpress: () {
                    _profileControler.profileUpdate(
                        image: selectedIMage,
                        firstName: firstNameCtrl.text,
                        lastName: lastNameCtrl.text,
                        phone: phoneCtrl.text,
                        address: addressCtrl.text,
                        dateOfBirth: dateOfBirthCtrl.text);
                  },
                  title: AppString.continues),

              SizedBox(height: 250.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(String hinText, prefixIcon,
      TextEditingController controller, TextInputType type) {
    return Column(
      children: [
        TextFormField(
          keyboardType: type,
          controller: controller,
          decoration: InputDecoration(
              hintText: hinText,
              hintStyle: const TextStyle(color: AppColors.primaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.r),
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
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      selectedDate = pickedDate;
      dateOfBirthCtrl.text = '$selectedDate';
      print('Selected date: ${dateOfBirthCtrl.text}');
    }
  }
}
