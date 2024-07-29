import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class EmergencyToggleController extends GetxController{



   String doctorEmergency = '';
  toggleEmergencyDoctor({String? isEmergency})async{

    if(isEmergency == 'false'){
      doctorEmergency = 'true';
    }else if(isEmergency == "true"){
      doctorEmergency = 'false';
    }

    var body = {
      "isEmergency":"$doctorEmergency"
    };
    
    
    var response = await ApiClient.testPostData(ApiConstants.emergencyToggleEndPoint, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode ==201){
      print("====> successful");
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }
}