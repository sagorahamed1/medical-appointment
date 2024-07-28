import 'dart:io';

import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class SendPrescriptionController extends GetxController {
  RxBool sendPrescriptionLoading = false.obs;

  sendPrescription(String id, File? pdf) async {
    sendPrescriptionLoading(true);
    List<MultipartBody> multipartBody =
    pdf == null ? [] : [MultipartBody("file", pdf)];
    var body = {
      'patientId':'$id',
    };

    var response = await ApiClient.postMultipartData(
        ApiConstants.sendPrescriptionEndPoint, body, multipartBody: multipartBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("=====> send prescription successful");
      sendPrescriptionLoading(false);
    }
  }
}
