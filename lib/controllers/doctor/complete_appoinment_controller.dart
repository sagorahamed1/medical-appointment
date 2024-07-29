import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class CompleteAppointmentController extends GetxController{
  
  RxBool loading = false.obs;
  completeAppointment(String id)async{
    var body = {
      "id":"$id"
    };
    var response = await ApiClient.testPostData(ApiConstants.completeAppointmentEndPoint, jsonEncode(body));

    if(response.statusCode == 200){
      ToastMessageHelper.showToastMessage(response.body['message']);
      Get.back();
    }
  }
}