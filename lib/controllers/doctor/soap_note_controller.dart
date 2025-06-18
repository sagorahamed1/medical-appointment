import 'dart:convert';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/models/doctor/soap_notes_model.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class SoapNoteController extends GetxController{



  ///===============Soap ================<>
  RxBool soapNoteAddLoading = false.obs;

  soapNoteAdd(
      {String? patientId,
      subjective,
      objective,
      assessment,
      plan}) async {
    var doctorId = await PrefsHelper.getString(AppConstants.userId);
    soapNoteAddLoading(true);
    var body =
    {
      "patientId":"$patientId",
      "doctorId":"$doctorId",
      "subjective":"${subjective}",
      "objective":"$objective",
      "assessment":"$objective",
      "plan":"$plan"
    };

    var response = await ApiClient.testPostData(
        ApiConstants.soapNote, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {

      ToastMessageHelper.showToastMessage("SOAP Notes Added!");
      Get.back();
      Get.back();

      soapNoteAddLoading(false);
    }else{
      soapNoteAddLoading(false);
    }
  }



  RxBool getSoapNoteLoading = false.obs;
  RxList<SoapNoteModel> soapNotes = <SoapNoteModel>[].obs;
  getSoapNotes({required String id}) async {
    getSoapNoteLoading(true);
    var response = await ApiClient.getData("${ApiConstants.getSoapNote}/${id}?page=1&limit=100");

    if (response.statusCode == 200) {
      var responseData = response.body;
      soapNotes.value = List<SoapNoteModel>.from(responseData["data"]["attributes"].map((x)=> SoapNoteModel.fromJson(x)));

      update();
      getSoapNoteLoading(false);
    }else{
      getSoapNoteLoading(false);
    }
  }

}