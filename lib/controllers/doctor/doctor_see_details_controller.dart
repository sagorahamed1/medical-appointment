import 'package:get/get.dart';

import '../../models/doctor/doctor_see_details_model.dart';
import '../../models/user/user_see_details_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class DoctorSeeDetailsController extends GetxController{
  RxBool doctorSeeDetailsLoading = false.obs;
  Rx<DoctorSeeDetailsModel> seeDetails = DoctorSeeDetailsModel().obs;
  getSeeDetails({String id = ''})async{
    doctorSeeDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.seeDetailsDoctorPart(id));
    if(response.statusCode == 200){
      var responseData = response.body;
      seeDetails.value = DoctorSeeDetailsModel.fromJson(responseData['data']['attributes']);
      print("get succussful");
      doctorSeeDetailsLoading(false);
    }else if(response.statusCode == 404){
      doctorSeeDetailsLoading(false);
    }
  }
}