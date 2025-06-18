import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/views/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/soap_note_controller.dart';
import '../../../widgets/custom_text.dart';

class PreviousSoapNoteScreen extends StatefulWidget {
   PreviousSoapNoteScreen({super.key});

  @override
  State<PreviousSoapNoteScreen> createState() => _PreviousSoapNoteScreenState();
}

class _PreviousSoapNoteScreenState extends State<PreviousSoapNoteScreen> {
  SoapNoteController soapNoteController = Get.put(SoapNoteController());


  @override
  void initState() {
    soapNoteController.getSoapNotes(id: Get.arguments["patientId"]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: "Previous SOAP NOTE",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [

            Obx(() => soapNoteController.getSoapNoteLoading.value ? const Center(child: CustomLoader()) :
                
                soapNoteController.soapNotes.isEmpty ? Center(child: CustomText(text: "No data found!")) :
               ListView.builder(
                shrinkWrap: true,
                itemCount: soapNoteController.soapNotes.length,
                itemBuilder: (context, index) {
                  var soap = soapNoteController.soapNotes[index];
                return Padding(
                  padding:  EdgeInsets.only(top: 8.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.previousSoapNoteDetailsScreen, arguments: soap);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 0.5),
                        borderRadius: BorderRadius.circular(12.r)
                      ),
              
                      child: CustomText(
                        left: 12.w,
                        textAlign: TextAlign.start,
                        top: 14.h,
                        bottom: 14.h,
                        text: "Note: ${TimeFormatHelper.formatDate(soap.createdAt ?? DateTime.now())}",
                        fontWeight: FontWeight.w700,
              
                      ),
                    ),
                  ),
                );
              },),
            )


          ],
        ),
      ),

    );
  }
}
