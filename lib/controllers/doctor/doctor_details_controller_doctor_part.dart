import 'dart:convert';

import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../helpers/toast_message_helper.dart';
import '../../models/doctor/doctor_details_molel_doctor_part.dart';
import '../../models/user/user_see_details_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';
import '../../utils/app_constant.dart';

class DoctorDetailsControllerDoctorPart extends GetxController{


  RxBool doctorDetailsLoading = false.obs;
  Rx<DoctorDetailsModelDoctorPart> doctorDetails = DoctorDetailsModelDoctorPart().obs;
  getDoctorDetails()async{
    doctorDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.doctorDetailsDoctorPart);
    if(response.statusCode == 200){
      var responseData = response.body;
      doctorDetails.value = DoctorDetailsModelDoctorPart.fromJson(responseData['data']['attributes']);
      print("get succussful");
      doctorDetailsLoading(false);
    }else if(response.statusCode == 404){
      doctorDetailsLoading(false);
    }
  }



  RxBool resendLoading = false.obs;
  ///===============Resend================<>
  continueDoctorDetailsEdit(
      {String? specialist,
        experience,
        clinicAddress,
        about,
        clinicPrice,
        onlineConsultationPrice,
        emergencyPrice,
        mondayStart,
        mondayEnd,
        tuesdayStart,
        tuesdayEnd,
        wednesdayStart,
        wednesdayEnd,
        thursdayStart,
        thursdayEnd,
        fridayStart,
        fridayEnd,
        saturdayStart,
        saturdayEnd,
        sundayStart,
        sundayEnd}) async {
    resendLoading(true);
    var id = await PrefsHelper.getString(AppConstants.userId);
    var body = {
      "specialist": specialist,
      "experience": experience,
      "clinicAddress": clinicAddress,
      "about": about,
      "doctorId": id,
      "clinicPrice": clinicPrice,
      "onlineConsultationPrice": onlineConsultationPrice,
      "emergencyPrice": emergencyPrice,
      "schedule": [
        {"day": "Monday", "startTime": mondayStart, "endTime": mondayEnd},
        {"day": "Tuesday", "startTime": tuesdayStart, "endTime": tuesdayEnd},
        {"day": "Wednesday", "startTime": wednesdayStart, "endTime": wednesdayEnd},
        {"day": "Thursday", "startTime": thursdayStart, "endTime": thursdayEnd},
        {"day": "Friday", "startTime": fridayStart, "endTime": fridayEnd},
        {"day": "Saturday", "startTime": saturdayStart, "endTime": saturdayEnd},
        {"day": "Sunday", "startTime": sundayStart, "endTime": sundayEnd}
      ]
    };

    var response = await ApiClient.patch(ApiConstants.doctorEditDetailsDoctorPart, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      Get.back();
      ToastMessageHelper.showToastMessage('Doctor Details Updated');
      print("======>>> successful");
      resendLoading(false);
    }
  }

}