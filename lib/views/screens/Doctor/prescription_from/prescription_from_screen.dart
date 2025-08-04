import 'dart:io';

import 'package:doctor_appointment/controllers/doctor/send_prescription_controller.dart';
import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/utils/app_icons.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../models/doctor/doctor_see_details_model.dart';
import '../../../widgets/pop_up_menu.dart';

class PrescriptionFormScreen extends StatefulWidget {
  @override
  PrescriptionFormScreenState createState() => PrescriptionFormScreenState();
}

class PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyMedicine = GlobalKey<FormState>();
  final pharmachiesFormKey = GlobalKey<FormState>();
  final List<Medication> _medications = [];
  DoctorSeeDetailsModel data = Get.arguments;
  SendPrescriptionController sendPrescriptionController =
      Get.put(SendPrescriptionController());

  TextEditingController doctorNameCtrl = TextEditingController();
  TextEditingController contactInfoCtrl = TextEditingController();
  TextEditingController patientNameCtrl = TextEditingController();
  TextEditingController patienAgeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController diagnosisCtrl = TextEditingController();
  TextEditingController npiCtrl = TextEditingController();
  TextEditingController medicineNameCtrl = TextEditingController();
  TextEditingController dosageCtrl = TextEditingController();
  TextEditingController frequencyCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();
  TextEditingController madicineNameCtrl = TextEditingController();
  TextEditingController instructionsCtrl = TextEditingController();
  TextEditingController followUpDateCtrl = TextEditingController();

  String pathPDF = "";
  late File pdfFile;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: "Prescription",
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeDefault.w,
            vertical: Dimensions.paddingSizeDefault.h),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Header Section
              _buildHeaderSection(),
              // Body Section
              _buildBodySection(),
              const SizedBox(height: 20),
              // Footer Section
              _buildFooterSection(),
              const SizedBox(height: 20),
              // Submit Button

              CustomButton(
                  onpress: () async {
                    if (_formKey.currentState!.validate()) {
                      if(!_medications.isEmpty){
                        await generatePDF();
                        if (pathPDF.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PdfViewerScreen(pathPDF: pathPDF)));
                          sendPrescriptionController.sendPrescription(
                              '${data.patientId?.id}',
                              '${data.patientDetailsId?.id}',
                              pdfFile);
                        }
                      }else{
                        ToastMessageHelper.showToastMessage("Please add medications");
                      }
                    }
                  },
                  title: 'Submit Prescription')
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Patient’s Information",
          fontWeight: FontWeight.w600,
          fontsize: 18.h,
          color: AppColors.primaryColor,
        ),

        SizedBox(height: 16.h),

        ///=========================Contact Information===============<

        Row(
          children: [
            const Text("Patient Name : "),
            Expanded(child: Text("${data.patientDetailsId?.fullName}"))
          ],
        ),
        Row(
          children: [
            const Text("Age : "),
            Expanded(child: Text("${data.patientDetailsId?.age}"))
          ],
        ),
        Row(
          children: [
            const Text("Gender : "),
            Expanded(child: Text("${data.patientDetailsId?.gender}"))
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Problem : "),
            Expanded(child: Text("${data.patientDetailsId?.description}"))
          ],
        ),

        CustomText(
          text: "Pharmacy",
          fontWeight: FontWeight.w600,
          fontsize: 18.h,
          top: 20.h,
          color: AppColors.primaryColor,
        ),

        SizedBox(height: 16.h),

        // CustomTextFieldWithoutBorder(
        //     contenpaddingHorizontal: 20,
        //     contenpaddingVertical: 0,
        //     hintText: 'Pharmacy',
        //     sufixicons: PopUpMenu(
        //       items: pharmacies,
        //       selectedItem: diagnosisCtrl.text,
        //       onTap: (int index) {
        //         setState(() {
        //           diagnosisCtrl.text = pharmacies[index];
        //         });
        //       },
        //     ),
        //     validator: (value) {
        //       if (value!.isEmpty) return 'Please enter diagnosis';
        //       return null;
        //     },
        //     controller: diagnosisCtrl),

        
        
        CustomTextFieldWithoutBorder(
          contenpaddingHorizontal: 20,
          contenpaddingVertical: 0,
          hintText: 'Search Pharmacy',
          sufixicons: Padding(
            padding:  EdgeInsets.all(16.r),
            child: SvgPicture.asset(AppIcons.search),
          ),
          onChanged: (value) {
            sendPrescriptionController.searchPharmacies(value);
            sendPrescriptionController.isSuggestions(true);
          },
          validator: (value) {
            if (value!.isEmpty) return 'Please enter diagnosis';
            return null;
          },
          controller: diagnosisCtrl,
        ),

        Obx(() => sendPrescriptionController.suggestions.isEmpty || !sendPrescriptionController.isSuggestions.value
            ? const SizedBox()
            : Container(
          height: sendPrescriptionController.suggestions.length >= 6 ? 200.h : (40 * sendPrescriptionController.suggestions.length).toDouble().h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            border: const Border(
              bottom: BorderSide( color: Colors.black, width: 0.5),
              left: BorderSide( color: Colors.black, width: 0.5),
              right: BorderSide( color: Colors.black, width: 0.5),
            ),
          ),
          child: ListView.builder(
            itemCount: sendPrescriptionController.suggestions.length,
            itemBuilder: (context, index) {
              var pharmacy = sendPrescriptionController.suggestions[index];
              return GestureDetector(
                onTap: () {
                  diagnosisCtrl.text = pharmacy;
                  sendPrescriptionController.isSuggestions(false);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: CustomText(
                    text: pharmacy,
                    textAlign: TextAlign.start,
                    left: 12.w,
                  ),
                ),
              );
            },
          ),
        ),
        ),

        SizedBox(height: 16.h),

        CustomTextFieldWithoutBorder(
            contenpaddingHorizontal: 20,
            contenpaddingVertical: 0,
            hintText: 'NPI number',
            validator: (value) {
              if (value!.isEmpty) return 'Please enter NPI';
              return null;
            },
            controller: npiCtrl),


      ],
    );
  }

  Widget _buildBodySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Medications",
          fontWeight: FontWeight.w600,
          fontsize: 18.h,
          top: 20.h,
          color: AppColors.primaryColor,
        ),
        ..._medications.map((medication) {
          int index = _medications.indexOf(medication);
          return Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(medication.name ?? ""),
                      Text(medication.dosage ?? ""),
                      Text(medication.frequency ?? ""),
                      Text(medication.duration ?? ""),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              IconButton(
                  onPressed: () {
                    _medications.removeAt(index);

                    setState(() {
                      medicineNameCtrl.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          );
        }),
        SizedBox(
          height: 10.h,
        ),
        Form(
          key: _formKeyMedicine,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              ///=========================Medicine Name===============<
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: 'Medicine Name',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter medicine name';
                    return null;
                  },
                  controller: medicineNameCtrl),

              SizedBox(height: 16.h),

              ///=========================Dosage===============<
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: 'Dosage',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter dosage';
                    return null;
                  },
                  controller: dosageCtrl),

              SizedBox(height: 16.h),

              ///=========================Frequency===============<
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: 'Frequency',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter frequency';
                    return null;
                  },
                  controller: frequencyCtrl),

              SizedBox(height: 16.h),

              ///=========================Duration===============<
              CustomTextFieldWithoutBorder(
                  contenpaddingHorizontal: 20,
                  contenpaddingVertical: 0,
                  hintText: 'Duration',
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter duration';
                    return null;
                  },
                  controller: durationCtrl),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              if (_formKeyMedicine.currentState!.validate()) {
                _medications.add(Medication(
                    name: medicineNameCtrl.text,
                    dosage: dosageCtrl.text,
                    frequency: frequencyCtrl.text,
                    duration: durationCtrl.text));

                medicineNameCtrl.clear();
                dosageCtrl.clear();
                frequencyCtrl.clear();
                durationCtrl.clear();
                setState(() {});
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 16.h),
              width: 220.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.fillColorE8EBF0,
                  border: Border.all(color: AppColors.primaryColor)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Center(
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: AppColors.primaryColor),
                      CustomText(
                          text: "  Add Medication",
                          color: AppColors.primaryColor)
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildFooterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Instructions",
          fontWeight: FontWeight.w600,
          fontsize: 18.h,
          top: 0.h,
          color: AppColors.primaryColor,
        ),

        SizedBox(height: 16.h),

        ///=========================Instructions===============<
        CustomTextFieldWithoutBorder(
            contenpaddingHorizontal: 20,
            contenpaddingVertical: 0,
            hintText: 'Instructions',
            validator: (value) {
              if (value!.isEmpty) return 'Please enter instructions';
              return null;
            },
            controller: instructionsCtrl),
      ],
    );
  }



  Future<void> generatePDF() async {
    final pdf = pw.Document();
    final diagnosis = diagnosisCtrl.text;
    final instruction = instructionsCtrl.text;
    const PdfColor containerColor = PdfColor.fromInt(0xFF193664);

    final headerStyle1 = pw.TextStyle(fontSize: 35.h, fontWeight: pw.FontWeight.bold);
    final headerStyle = pw.TextStyle(fontSize: 27.h, fontWeight: pw.FontWeight.bold);
    final mediumStyle = pw.TextStyle(fontSize: 22.h);

    // Helper: build medication table
    pw.Widget buildMedicationTable(List<Medication> meds) {
      return pw.Table.fromTextArray(
        data: [
          ["Medicine Name", "Dosage", "Frequency", "Duration"],
          for (var med in meds)
            [
              med.name ?? '',
              med.dosage ?? '',
              med.frequency ?? '',
              med.duration ?? '',
            ]
        ],
        cellStyle: mediumStyle,
        headerDecoration: pw.BoxDecoration(color: PdfColors.grey200),
        headerStyle: pw.TextStyle(
            color: PdfColors.black, fontSize: 20.h, fontWeight: pw.FontWeight.bold),
        cellAlignment: pw.Alignment.center,
        cellHeight: 30,
        headerHeight: 40,
      );
    }

    // Helper: split list into chunks
    List<List<T>> chunkList<T>(List<T> list, int size) {
      List<List<T>> chunks = [];
      for (int i = 0; i < list.length; i += size) {
        chunks.add(list.sublist(i, i + size > list.length ? list.length : i + size));
      }
      return chunks;
    }

    // Split medications dynamically
    final medicationChunks = _medications.length > 8 ? chunkList(_medications, 6) : [_medications];

    // Build first page
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Center(child: pw.Text('Prescription', style: headerStyle1)),
            pw.SizedBox(height: 12),
            pw.Container(height: 4, width: double.infinity, color: containerColor),
            pw.SizedBox(height: 12),
            pw.Row(children: [
              pw.Text('Prescription No : ', style: mediumStyle),
              pw.Text('${data.patientDetailsId?.id}', style: mediumStyle),
            ]),
            pw.SizedBox(height: 8),
            pw.Row(children: [
              pw.Text('Prescription Date: ', style: mediumStyle),
              pw.Text(TimeFormatHelper.formatDate(data.date!), style: mediumStyle),
            ]),
            pw.SizedBox(height: 12),
            pw.Text('Patient Information', style: headerStyle),
            pw.SizedBox(height: 10),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name: ${data.patientDetailsId?.fullName}', style: mediumStyle),
                  pw.Text('Age: ${data.patientDetailsId?.age} Years', style: mediumStyle),
                ]),
            pw.SizedBox(height: 8),
            pw.Text('Gender: ${data.patientDetailsId?.gender}', style: mediumStyle),
            pw.SizedBox(height: 8),
            pw.Row(children: [
              pw.Text('Problem: ', style: mediumStyle),
              pw.Expanded(
                child: pw.Text('${data.patientDetailsId?.description}',
                    style: mediumStyle, maxLines: 10),
              )
            ]),
            pw.SizedBox(height: 12),
            pw.Container(height: 3, width: double.infinity, color: PdfColors.amber),
            pw.SizedBox(height: 8),
            pw.Text('Rx', style: headerStyle1),
            pw.SizedBox(height: 8),
            buildMedicationTable(medicationChunks[0]),

            if ((_medications.length >= 6 && _medications.length <= 8 && instruction.length > 60) || (_medications.length < 5)) ...[
              pw.SizedBox(height: 10),
              pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text('Instructions: ', style: mediumStyle),
                pw.SizedBox(width: 300, child: pw.Text(instruction, style: mediumStyle, maxLines: 20)),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('Pharmacy: ', style: mediumStyle),
                pw.Text(diagnosis, style: mediumStyle),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('NPI Number: ', style: mediumStyle),
                pw.Text(npiCtrl.text, style: mediumStyle),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('Doctor Signature: ', style: mediumStyle),
                pw.Text('${data.doctorId?.firstName} ${data.doctorId?.lastName}',
                    style: mediumStyle),
              ]),
            ]
          ],
        ),
      ),
    );

    // Add 2nd page if meds are more or instruction too long
    if (_medications.length > 7 || (_medications.length >= 4 && _medications.length <= 7 )) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (medicationChunks.length > 1) ...[
                pw.Text('Continued Medications', style: headerStyle),
                pw.SizedBox(height: 8),
                for (int i = 1; i < medicationChunks.length; i++)
                  buildMedicationTable(medicationChunks[i]),
              ],
              pw.SizedBox(height: 10),
              pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                pw.Text('Instructions: ', style: mediumStyle),
                pw.SizedBox(width: 300, child: pw.Text(instruction, style: mediumStyle, maxLines: 20)),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('Pharmacy: ', style: mediumStyle),
                pw.Text(diagnosis, style: mediumStyle),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('NPI Number: ', style: mediumStyle),
                pw.Text(npiCtrl.text, style: mediumStyle),
              ]),
              pw.SizedBox(height: 10),
              pw.Row(children: [
                pw.Text('Doctor Signature: ', style: mediumStyle),
                pw.Text('${data.doctorId?.firstName} ${data.doctorId?.lastName}',
                    style: mediumStyle),
              ]),
            ],
          ),
        ),
      );
    }

    // Save file
    final output = await getTemporaryDirectory();
    final outputFilePath = "${output.path}/personal_info.pdf";
    final file = File(outputFilePath);
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfFile = file;
      pathPDF = outputFilePath;
      print("PDF saved at: $pathPDF");
    });
  }


///==============================PDF Generator==============>
  // Future<void> generatePDF() async {
  //   final pdf = pw.Document();
  //   final diagnosis = diagnosisCtrl.text;
  //   final instrction = instructionsCtrl.text;
  //
  //   final headerStyle1 =
  //       pw.TextStyle(fontSize: 35.h, fontWeight: pw.FontWeight.bold);
  //   final headerStyle =
  //       pw.TextStyle(fontSize: 27.h, fontWeight: pw.FontWeight.bold);
  //   final mediuamStyle = pw.TextStyle(fontSize: 22.h);
  //   const PdfColor containerColor = PdfColor.fromInt(0xFF193664);
  //
  //   pdf.addPage(
  //     pw.Page(
  //       build: (pw.Context context) => pw.Center(
  //         child: pw.Column(
  //           mainAxisAlignment: pw.MainAxisAlignment.center,
  //           crossAxisAlignment: pw.CrossAxisAlignment.center,
  //           children: [
  //             ///================topic Name================>
  //             pw.Text('Prescription', style: headerStyle1),
  //
  //             pw.SizedBox(height: 12),
  //             pw.Container(
  //                 height: 4, width: double.infinity, color: containerColor),
  //
  //             ///===================Prescription No==========>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 16),
  //               pw.Row(children: [
  //                 pw.Text('Prescription No :', style: mediuamStyle),
  //                 pw.Text('${data.patientDetailsId?.id}', style: mediuamStyle),
  //               ])
  //             ]),
  //
  //             ///===================Prescription Date==========>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 8),
  //               pw.Row(children: [
  //                 pw.Text('Prescription Date: ', style: mediuamStyle),
  //                 pw.Text(TimeFormatHelper.formatDate(data.date!),
  //                     style: mediuamStyle),
  //               ])
  //             ]),
  //
  //             // pw.SizedBox(height: 20),
  //             //
  //             // pw.Container(
  //             //     height: 15, width: double.infinity, color: PdfColors.amber),
  //             pw.SizedBox(height: 8),
  //
  //             ///====================Patient Information============>
  //             pw.Align(
  //               alignment: pw.Alignment.centerLeft,
  //               child: pw.Text('Patient Information', style: headerStyle),
  //             ),
  //
  //             pw.SizedBox(height: 12),
  //
  //             ///===================Name and Age==========>
  //             pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.SizedBox(
  //                     width: 150.w,
  //                     child: pw.Column(children: [
  //                       pw.Row(children: [
  //                         pw.Text('Name: ', style: mediuamStyle),
  //                         pw.Text('${data.patientDetailsId?.fullName}',
  //                             style: mediuamStyle),
  //                       ])
  //                     ]),
  //                   ),
  //                   pw.Column(children: [
  //                     pw.Row(children: [
  //                       pw.Text('Age: ', style: mediuamStyle),
  //                       pw.Text('${data.patientDetailsId?.age} Years',
  //                           style: mediuamStyle),
  //                     ])
  //                   ]),
  //                 ]),
  //
  //             ///===================Phone Number and Age==========>
  //             pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Column(children: [
  //                     pw.SizedBox(height: 20),
  //                     pw.Row(children: [
  //                       pw.Text('Gender: ', style: mediuamStyle),
  //                       pw.Text('${data.patientDetailsId?.gender}',
  //                           style: mediuamStyle),
  //                     ])
  //                   ]),
  //                 ]),
  //
  //             pw.SizedBox(height: 10),
  //
  //             pw.Row(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text('Problem: ', style: mediuamStyle),
  //                   pw.Expanded(
  //                     child: pw.Text('${data.patientDetailsId?.description}',
  //                         style: mediuamStyle, maxLines: 10),
  //                   )
  //                 ]),
  //
  //             pw.SizedBox(height: 8),
  //
  //             pw.Container(
  //                 height: 3, width: double.infinity, color: PdfColors.amber),
  //
  //             pw.SizedBox(height: 8),
  //
  //             ///====================List of Prescribed Medications============>
  //             // pw.Align(
  //             //     alignment: pw.Alignment.centerLeft,
  //             //     child: pw.Text('List of Prescribed Medications',
  //             //         style: headerStyle)),
  //             pw.Align(
  //               alignment: pw.Alignment.centerLeft,
  //               child: pw. Text('Rx', style: headerStyle1)
  //             ),
  //             pw.SizedBox(height: 8),
  //
  //             pw.Table.fromTextArray(
  //               context: context,
  //               data: [
  //                 // Header row
  //                 ["Medicine Name", "Dosage", "Frequency", "Duration"],
  //                 // Medication rows
  //                 for (var medication in _medications)
  //                   [
  //                     medication.name ?? '',
  //                     medication.dosage ?? '',
  //                     medication.frequency ?? '',
  //                     medication.duration ?? '',
  //                   ],
  //               ],
  //               cellStyle: mediuamStyle,
  //               headerDecoration:
  //                   const pw.BoxDecoration(color: PdfColors.grey200),
  //               headerStyle: pw.TextStyle(
  //                   color: PdfColors.black,
  //                   fontSize: 20.h,
  //                   fontWeight: pw.FontWeight.bold),
  //               cellAlignment: pw.Alignment.center,
  //               cellHeight: 30,
  //               headerHeight: 40,
  //             ),
  //
  //             ///==============Instructions===============>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 10),
  //                 pw.SizedBox(
  //                   child:   pw.Row(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                     pw.Text('Instructions: ', style: mediuamStyle),
  //                     pw.SizedBox(
  //                       width: 265,
  //                       child: pw.Text(instrction, style: mediuamStyle,maxLines: 5),
  //                     )
  //                   ])
  //                 )
  //             ]),
  //
  //
  //             ///==============Pharmacy===============>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 10),
  //               pw.Row(children: [
  //                 pw.Text('Pharmacy: ', style: mediuamStyle),
  //                 pw.Text('$diagnosis', style: mediuamStyle),
  //               ])
  //             ]),
  //
  //             ///==============NPI===============>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 10),
  //               pw.Row(children: [
  //                 pw.Text('NPI Number: ', style: mediuamStyle),
  //                 pw.Text(npiCtrl.text, style: mediuamStyle),
  //               ])
  //             ]),
  //
  //             ///===================Physician Name and Physician Signature==========>
  //             pw.Column(children: [
  //               pw.SizedBox(height: 10),
  //               pw.Row(children: [
  //                 pw.Text('Doctor Signature: ', style: mediuamStyle),
  //                 pw.Text(
  //                     '${data.doctorId?.firstName} ${data.doctorId?.lastName}',
  //                     style: mediuamStyle),
  //               ])
  //             ]),
  //             pw.SizedBox(height: 12),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   final output = await getTemporaryDirectory();
  //   final outputFilePath = "${output.path}/personal_info.pdf";
  //   final file = File(outputFilePath);
  //   await file.writeAsBytes(await pdf.save());
  //
  //   setState(() {
  //     pdfFile = file;
  //     pathPDF = outputFilePath;
  //     print("=----------------------------> $pdfFile");
  //   });
  // }



}



//
// class PdfViewerScreen extends StatelessWidget {
//   final String pathPDF;
//
//   const PdfViewerScreen({super.key, required this.pathPDF});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           leading: const SizedBox(),
//         ),
//         body: Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onTap: () {
//                   Get.offAllNamed(AppRoutes.doctorBottomNavBar);
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(left: 20.w),
//                   decoration: BoxDecoration(
//                     color: AppColors.primaryColor,
//                     borderRadius: BorderRadius.circular(16.r),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: CustomText(
//                         text: "Go to Home Page", color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//             pathPDF.isNotEmpty
//                 ? Center(
//                     child: SizedBox(
//                       height: 600.h,
//                       width: 600.w,
//                       child: PDFView(
//                         fitEachPage: false,
//                         filePath: pathPDF,
//                         enableSwipe: true,
//                         swipeHorizontal: false,
//                         autoSpacing: true,
//                         pageFling: true,
//                         onError: (error) {
//                           print(error.toString());
//                         },
//                       ),
//                     ),
//                   )
//                 : const Text("Pdf not found"),
//           ],
//         ));
//   }
// }




class PdfViewerScreen extends StatelessWidget {
  final String pathPDF;

  const PdfViewerScreen({super.key, required this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("PDF Viewer")),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                Get.offAllNamed(AppRoutes.doctorBottomNavBar);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Go to Home Page", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
          Expanded(
            child: SfPdfViewer.file(
              File(pathPDF),
              canShowScrollStatus: true,
              canShowPaginationDialog: true,
              onDocumentLoaded: (details) {
                print("++++++++++++++ page : ${details.document.pages.count}");
              },
            ),
          ),
        ],
      ),
    );
  }
}



class Medication {
  String? name;
  String? dosage;
  String? frequency;
  String? duration;

  Medication({this.name, this.dosage, this.frequency, this.duration});
}
