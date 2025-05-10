import 'dart:io';

import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({super.key});

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  ProfileControler profileControler = Get.put(ProfileControler());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileControler.getLocalData();
      await profileControler.loadPdf(profileControler.localFilePath.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(
          text: "Insurance",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: SingleChildScrollView(
          child: Obx(() =>
             Column(
              children: [
                SizedBox(height: 5.h),

                GestureDetector(
                  onTap: profileControler.pickAndUploadPdf,
                  child: DottedBorder(
                    color: Colors.grey.shade400,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12.r),
                    dashPattern: [6, 4],
                    // Dotted pattern: 6 units line, 4 units space
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.primaryColor, width: 3.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5.r),
                              child: Icon(Icons.add,
                                  color: AppColors.primaryColor, size: 32.r),
                            ),
                          ),
                          CustomText(
                            text: "Drop your insurance here",
                            top: 15.h,
                            bottom: 15.h,
                            fontWeight: FontWeight.w800,
                            fontsize: 16.r,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                  text: "Browse file",
                                  fontsize: 12.h,
                                  color: Colors.blueAccent),
                              CustomText(text: " from your device", fontsize: 12.h),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),



                SizedBox(
                  height: 450.h,
                  child: Obx(() =>
                     PDFView(
                      filePath: profileControler.localFilePath.value,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: true,
                      pageFling: true,
                    ),
                  ),
                ),


                CustomButton(
                  onpress: () {},
                  title: profileControler.localFilePath.value != null
                      ? "Update Insurance PDF"
                      : "Upload Insurance PDF",
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
