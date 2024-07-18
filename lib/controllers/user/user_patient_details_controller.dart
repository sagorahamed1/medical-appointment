import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class UserPatientDetailsController extends GetxController{



  patienDetailsAdd({String? fullName, gender,age, description, doctorId})async{
    var body = {
      "fullName": "$fullName",
      "gender": "$gender",
      "age": '$age',
      "description": "$description",
      "doctorId": "$doctorId"
    };
    
    var response = await ApiClient.postData(ApiConstants.patientDetailsAdd, body);

    if(response.statusCode == 200 || response.statusCode == 201){
      print("---------------------------successful");
    }
  }
}