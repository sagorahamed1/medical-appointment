import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/doctor/soap_note_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';

class AddSoapNoteScreen extends StatelessWidget {
   AddSoapNoteScreen({super.key});

  TextEditingController subjectiveCtrl = TextEditingController();
  TextEditingController objectiveCtrl = TextEditingController();
  TextEditingController assessmentCtrl = TextEditingController();
  TextEditingController planCtrl = TextEditingController();

   SoapNoteController soapNoteController = Get.put(SoapNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: CustomText(
          text: "SOAP NOTE",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
          
              CustomText(text: "Information",fontWeight: FontWeight.w600, fontsize: 18.h, bottom: 12.h),
          
          
              Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    child: CustomText(
                        textAlign: TextAlign.start,
                        text: "Patient Name",
                        fontsize: 16.h,
                        color: AppColors.textColor5C5C5C
                    ),
                  ),
          
          
                  CustomText(
                      text: ":  Sagor Ahammed",
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C
                  )
                ],
              ),
          
          
          
              Row(
                children: [
                  SizedBox(
                    width: 120.w,
                    child: CustomText(
                        textAlign: TextAlign.start,
                        text: "Date",
                        fontsize: 16.h,
                        color: AppColors.textColor5C5C5C
                    ),
                  ),
          
          
                  CustomText(
                      text: ":  14-05-2025",
                      fontsize: 16.h,
                      color: AppColors.textColor5C5C5C
                  )
                ],
              ),
          
          
              subjectiveCard(
                title: "Subjective",
                controller: subjectiveCtrl
              ),
          
          
              subjectiveCard(
                  title: "Objective",
                  controller: objectiveCtrl
              ),
          
          
              subjectiveCard(
                  title: "Assessment",
                  controller: assessmentCtrl
              ),
          
          
              subjectiveCard(
                  title: "Plan",
                  controller: planCtrl
              ),
          
          
              SizedBox(height: 50.h),
          
          
              Obx(() =>
                 CustomButton(
                     loading: soapNoteController.soapNoteAddLoading.value,
                     onpress: (){

                  soapNoteController.soapNoteAdd(
                    patientId: "${Get.arguments["patientId"]}",
                    assessment: "${assessmentCtrl.text}",
                    objective: "${objectiveCtrl.text}",
                    subjective: "${subjectiveCtrl.text}",
                    plan: "${planCtrl.text}"
                  );


                }, title: "Save"),
              ),
          
          

              SizedBox(height: 30.h)
            ],
          ),
        ),
      ),

    );
  }



  subjectiveCard({required String title,required TextEditingController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "$title",fontWeight: FontWeight.w600, fontsize: 18.h, bottom: 12.h, top: 12.h),


        CustomTextField(
          maxLines: 6,
            contenpaddingHorizontal: 8,
            contenpaddingVertical: 12,
            controller: controller,
          hintText: "Enter Text",
        )

      ],
    );
  }

}
