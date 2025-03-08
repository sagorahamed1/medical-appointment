import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../routes/app_routes.dart';
import '../../utils/app_constant.dart';

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





   ///===============account delete================<>
   RxBool deleteLoading = false.obs;
   accountDelete({
     String? password,
   }) async {
     deleteLoading(true);
     var body = {
       "password": '$password',
     };

    var bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

     var mainHeaders = {
       'Content-Type': 'application/json',
       'Authorization': 'Bearer $bearerToken'
     };

     var response = await ApiClient.postData(ApiConstants.accountDelete, jsonEncode(body), headers: mainHeaders);

     if (response.statusCode == 200 || response.statusCode == 201) {
       ToastMessageHelper.showToastMessage('Your Account Information Deleted!');
       Get.offAllNamed(AppRoutes.signInScreen);

       deleteLoading(false);
     } else {
       ToastMessageHelper.showToastMessage('${response.body["message"]}');
       deleteLoading(false);
     }
   }


}