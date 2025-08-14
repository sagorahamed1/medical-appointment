import 'package:doctor_appointment/controllers/auth_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class InsuranceInfoScreen extends StatefulWidget {
  const InsuranceInfoScreen({super.key});

  @override
  State<InsuranceInfoScreen> createState() => _InsuranceInfoScreenState();
}

class _InsuranceInfoScreenState extends State<InsuranceInfoScreen> {

  TextEditingController payerCodeCtrl = TextEditingController();
  TextEditingController payerNameCtrl = TextEditingController();
  TextEditingController npiCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController dosStartDateCtrl = TextEditingController();
  TextEditingController dosEndDateCtrl = TextEditingController();

  final AuthController _authController = Get.find<AuthController>();

  String type = "";

  @override
  void initState() {
    getDateFromPriviusScreen();
    super.initState();
  }

  getDateFromPriviusScreen()async{
    type = Get.arguments["type"];
    payerNameCtrl.text = await PrefsHelper.getString(AppConstants.payerName);
    payerCodeCtrl.text = await PrefsHelper.getString(AppConstants.payerCode);
    npiCtrl.text = await PrefsHelper.getString(AppConstants.npi);
    pinCtrl.text = await PrefsHelper.getString(AppConstants.pin);
    dateOfBirthCtrl.text = await PrefsHelper.getString(AppConstants.dateOfBirth);
    dosStartDateCtrl.text = await PrefsHelper.getString(AppConstants.startDate);
    dosEndDateCtrl.text = await PrefsHelper.getString(AppConstants.endDate);
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(text: "Insurance Information",
            fontsize: 18.h,
            fontWeight: FontWeight.w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Payer Code",
                  bottom: 4.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: payerCodeCtrl,
                  hintText: "Payer Code",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "Payer Name",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: payerNameCtrl,
                  hintText: "Payer Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your payer name";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "NPI",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: npiCtrl,
                  hintText: "NPI",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your NPI";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "PIN",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  keyboardType: TextInputType.number,
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: pinCtrl,
                  hintText: "PIN",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your PIN";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "Date of Birth",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================Date of birth============================>
                CustomTextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000), // You can change this default
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      dateOfBirthCtrl.text = formattedDate;
                    }
                  },
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: dateOfBirthCtrl,
                  hintText: "Date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "doS Start Date",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///==========================first name ============================>
                CustomTextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000), // You can change this default
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      dosStartDateCtrl.text = formattedDate;
                    }
                  },
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: dosStartDateCtrl,
                  hintText: "Date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your doS start date";
                    }
                    return null;
                  },
                ),


                CustomText(
                  text: "doS End Date",
                  bottom: 4.h,
                  top: 8.h,
                  color: AppColors.primaryColor,
                ),

                ///========================== ============================>
                CustomTextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000), // You can change this default
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                      dosEndDateCtrl.text = formattedDate;
                    }
                  },
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  controller: dosEndDateCtrl,
                  hintText: "Date",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your doS End Date";
                    }
                    return null;
                  },
                ),


                SizedBox(height: 16.h),
               type == "profile" ? SizedBox() : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "If you don’t have the insurance you can "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                          text: "Skip.", color: AppColors.primaryColor),
                    ),
                  ],
                ),


                SizedBox(height: 16.h),


                CustomButton(onpress: () {
                  _authController.insuranceUpload(
                    payerCode: payerCodeCtrl.text.trim(),
                    payerName: payerNameCtrl.text,
                    dateOfBirth: dateOfBirthCtrl.text,
                    pin: pinCtrl.text,
                    nip: npiCtrl.text,
                    endDate: dosEndDateCtrl.text,
                    startDate: dosStartDateCtrl.text,
                    type: type == "profile" ? "profile" : "sign up"
                  );

                }, title: "Submit"),


                SizedBox(height: 40.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


