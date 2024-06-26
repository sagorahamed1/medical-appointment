import 'package:doctor_appointment/utils/app_colors.dart';
import 'package:doctor_appointment/utils/app_dimentions.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PrescriptionFormScreen extends StatefulWidget {
  @override
  PrescriptionFormScreenState createState() => PrescriptionFormScreenState();
}

class PrescriptionFormScreenState extends State<PrescriptionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyMedicine = GlobalKey<FormState>();
  final List<Medication> _medications = [];

  TextEditingController doctorNameCtrl = TextEditingController();
  TextEditingController contactInfoCtrl = TextEditingController();
  TextEditingController patientNameCtrl = TextEditingController();
  TextEditingController patienAgeCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController diagnosisCtrl = TextEditingController();
  TextEditingController medicineNameCtrl = TextEditingController();
  TextEditingController dosageCtrl = TextEditingController();
  TextEditingController frequencyCtrl = TextEditingController();
  TextEditingController durationCtrl = TextEditingController();
  TextEditingController madicineNameCtrl = TextEditingController();
  TextEditingController instructionsCtrl = TextEditingController();
  TextEditingController followUpDateCtrl = TextEditingController();

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
              SizedBox(height: 20),
              // Footer Section
              _buildFooterSection(),
              SizedBox(height: 20),
              // Submit Button

              CustomButton(
                  onpress: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the prescription
                    }
                  },
                  title: 'Submit Prescription')
              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.validate()) {
              //       // Process the prescription
              //     }
              //   },
              //   child: Text('Submit Prescription'),
              // ),
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
            Text("Patient Name : "),
            Expanded(child: Text("Sagor Ahamed"))
          ],
        ),
        Row(
          children: [Text("Age : "), Expanded(child: Text("25"))],
        ),
        Row(
          children: [Text("Gender : "), Expanded(child: Text("Male"))],
        ),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Problem : "),
            Expanded(
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit "))
          ],
        ),

        CustomText(
          text: "Diagnosis",
          fontWeight: FontWeight.w600,
          fontsize: 18.h,
          top: 20.h,
          color: AppColors.primaryColor,
        ),

        SizedBox(height: 16.h),

        ///=========================Contact Information===============<
        CustomTextFieldWithoutBorder(
            contenpaddingHorizontal: 20,
            contenpaddingVertical: 0,
            hintText: 'Diagnosis',
            validator: (value) {
              if (value!.isEmpty) return 'Please enter diagnosis';
              return null;
            },
            controller: diagnosisCtrl),
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
                          text: "  Add Medication", color: AppColors.primaryColor)
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
        // ElevatedButton(
        //   onPressed: _addMedication,
        //   child: Text('Add Medication'),
        // ),
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
}

class Medication {
  String? name;
  String? dosage;
  String? frequency;
  String? duration;

  Medication({this.name, this.dosage, this.frequency, this.duration});
}
