import 'dart:io';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:get/get.dart';

class SendPrescriptionController extends GetxController {
  RxBool sendPrescriptionLoading = false.obs;

  sendPrescription(String id, String patientDetailsId, File? pdf) async {
    sendPrescriptionLoading(true);
    List<MultipartBody> multipartBody =
    pdf == null ? [] : [MultipartBody("file", pdf)];
    var body = {
      'patientId':'$id',
      'patientDetailsId':'$patientDetailsId',
    };

    var response = await ApiClient.postMultipartData(
        ApiConstants.sendPrescriptionEndPoint, body, multipartBody: multipartBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      PrefsHelper.setBool(AppConstants.isPrescription, true);
      // PrefsHelper.setBool(AppConstants.role, true);
      print("=====> send prescription successful");
      sendPrescriptionLoading(false);
    }
  }




  RxBool isSuggestions = false.obs;
  var suggestions = <String>[].obs;
  List<String> pharmacies = [
    'CVS Pharmacy',
    'Walgreens',
    'Rite Aid',
    'Walmart Pharmacy',
    'Kroger Pharmacy',
    'Albertsons/Safeway Pharmacy',
    'Costco Pharmacy',
    'Publix Pharmacy',
    'H-E-B Pharmacy',
    'Hy-Vee Pharmacy'
  ];

  void searchPharmacies(String text) {
    print("Searching pharmacies for: $text");
    if (text.isEmpty) {
      suggestions.value = pharmacies;
    } else {
      suggestions.value = pharmacies
          .where((pharmacy) =>
          pharmacy.toLowerCase().contains(text.toLowerCase()))
          .toList();
    }
    update();
  }




}
