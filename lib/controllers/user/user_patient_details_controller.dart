import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../utils/app_constant.dart';

class UserPatientDetailsController extends GetxController{



  patienDetailsAdd({String? fullName, gender,age, description, doctorId, price, packName, timeSlot, date})async{
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var body = {
      "fullName": "$fullName",
      "gender": "$gender",
      "age": '$age',
      "description": "$description",
      "doctorId": "$doctorId"
    };
    
    var response = await ApiClient.postData(ApiConstants.patientDetailsAdd, body, headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201){
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
    String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken'
    };
    var bodys =  {
      "date":"$date",
      "timeSlot":"$timeSlot",
      "doctorId":"$doctorId",
      "package":{
        "packageName":"$packageName",
        "packagePrice":"$price"
      },
      "amount":"$price",
      "stripeToken": "tok_visa_cartesBancaires"
    };


    var response = await ApiClient.postData(ApiConstants.userPayment, bodys, headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201){
      ToastMessageHelper.showToastMessage('Doctor book successful');
    }else{
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }
}