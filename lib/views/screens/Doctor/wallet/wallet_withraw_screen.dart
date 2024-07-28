import 'package:doctor_appointment/controllers/doctor/wallet_controller.dart';
import 'package:doctor_appointment/views/widgets/custom_button.dart';
import 'package:doctor_appointment/views/widgets/custom_text_field_without_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_strings.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class WalletWithdrawalScreen extends StatefulWidget {
  const WalletWithdrawalScreen({super.key});

  @override
  State<WalletWithdrawalScreen> createState() => _WalletWithdrawalScreenState();
}

class _WalletWithdrawalScreenState extends State<WalletWithdrawalScreen> {
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountTypeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController withdrawalAmountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///-----------------------------------app bar section-------------------------->
      appBar: AppBar(
        title: CustomText(
          text: AppString.bankAccountDetails,
          fontsize: 18.h,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                //===============================> Request <===============================
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: AppString
                                  .pleaseProvideTheFollowingInformationForTheWithdrawal,
                              fontsize: 18.h,
                              color: Colors.black,
                              maxline: 2,
                              textAlign: TextAlign.start),

                          SizedBox(height: 16.h),
                          CustomTextFieldWithoutBorder(
                            hintText: "Bank Name",
                              contenpaddingHorizontal: 20,
                              contenpaddingVertical: 0,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter your bank name!';
                                }return null;
                              },
                              controller: bankNameController),


                          SizedBox(height: 16.h),
                          CustomTextFieldWithoutBorder(
                            hintText: 'Account Type',
                              contenpaddingHorizontal: 20,
                              contenpaddingVertical: 0,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter your account type!';
                                }return null;
                              },
                              controller: accountTypeController),


                          SizedBox(height: 16.h),
                          CustomTextFieldWithoutBorder(
                              hintText: 'Account Number',
                              contenpaddingHorizontal: 20,
                              contenpaddingVertical: 0,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter your account number!';
                                }return null;
                              },
                              controller: accountNumberController),


                          SizedBox(height: 16.h),
                          CustomTextFieldWithoutBorder(
                            keyboardType: TextInputType.number,
                              hintText: 'Withdraw Amount',
                              contenpaddingHorizontal: 20,
                              contenpaddingVertical: 0,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return 'Please enter amount';
                                }return null;
                              },
                              controller: withdrawalAmountController),

                          SizedBox(height: 280.h),

                          CustomButton(
                             loading: walletController.withDrawRequestLoading.value,
                              onpress: (){
                            if(_formKey.currentState!.validate()){
                              walletController.withDrawRequest(
                                  accountNumber: accountNumberController.text,
                                  accountType: accountTypeController.text,
                                  bankName: bankNameController.text,
                                  withDrawAmount: withdrawalAmountController.text
                              );
                            }

                          }, title: AppString.requestWithdrawal),



                          SizedBox(height: 24.h)


                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
