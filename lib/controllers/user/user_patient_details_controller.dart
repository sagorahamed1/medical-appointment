import 'dart:convert';

import 'package:doctor_appointment/helpers/time_format.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../helpers/prefs_helper.dart';
import '../../utils/app_constant.dart';

class UserPatientDetailsController extends GetxController{



  RxBool patientDetailsLoading = false.obs;
  patienDetailsAdd({String? fullName, gender,age, description, doctorId, price, packName, timeSlot, date})async{
    patientDetailsLoading(true);
    var body = {
      "fullName": "$fullName",
      "gender": "${gender.toString().toLowerCase()}",
      "age": '$age',
      "description": "$description",
      "doctorId": "$doctorId"
    };
    
    var response = await ApiClient.testPostData(ApiConstants.patientDetailsAdd, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201){
      patientDetailsLoading(false);
      payment(
        price: price,
        doctorId: doctorId,
        date: date,
        packageName: packName,
        timeSlot: timeSlot
      );
      print("---------------------------successful");
    }
  }


  payment({String? price, packageName, date, timeSlot, doctorId })async{
    var newData = TimeFormatHelper.justDateWithUnderscoll(DateTime.parse(date));
    print('=========date $newData');
    patientDetailsLoading(true);
    var body =  {
      "date":'$newData',
      "timeSlot":"$timeSlot",
      "doctorId":"$doctorId",
      "package":{
        "packageName":"$packageName",
        "packagePrice":"$price"
      },
      "amount":"$price",
      "stripeToken": "tok_visa_cartesBancaires"
    };


    var response = await ApiClient.testPostData(ApiConstants.userPayment, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201){
      patientDetailsLoading(false);
      Get.back();
      Get.back();
      Get.back();
      ToastMessageHelper.showToastMessage('Doctor book successful');
    }else{
      ToastMessageHelper.showToastMessage(response.body['message']);
      patientDetailsLoading(false);
    }
  }
}