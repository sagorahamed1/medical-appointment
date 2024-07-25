import 'package:get/get.dart';

import '../../models/doctor/doctor_see_details_model_doctor_part.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class SeeDetailsController extends GetxController{
  RxBool doctorSeeDetailsLoading = false.obs;
  Rx<DoctorSeeDetailsModelDoctorPart> seeDetails = DoctorSeeDetailsModelDoctorPart().obs;
  getSeeDetails({String id = ''})async{
    doctorSeeDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.seeDetailsDoctorPart(id));
    if(response.statusCode == 200){
      var responseData = response.body;
      seeDetails.value = DoctorSeeDetailsModelDoctorPart.fromJson(responseData['data']['attributes']);
      print("get succussful");
      doctorSeeDetailsLoading(false);
    }else if(response.statusCode == 404){
      doctorSeeDetailsLoading(false);
    }
  }
}