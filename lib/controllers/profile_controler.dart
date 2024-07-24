import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/models/profile_model.dart';
import 'package:get/get.dart';

import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constant.dart';

class ProfileControler extends GetxController{

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  final rxRequestStatus = Status.loading.obs;
  RxBool profileLoading = false.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  Rx<ProfileModel> profileInfo = ProfileModel().obs;
  getProfile()async{
    profileLoading(true);
    var response = await ApiClient.getData(ApiConstants.getProfileEndPoint);
    if(response.statusCode == 200){
      var responseData = response.body;
      profileInfo.value = ProfileModel.fromJson(responseData['data']['attributes']);
      print("get succussful");
      profileLoading(false);
      setRxRequestStatus(Status.completed);
    }else if(response.statusCode == 404){
      profileLoading(false);
      setRxRequestStatus(Status.completed);
    }else{
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      }else{
        setRxRequestStatus(Status.error);
      }
    }
  }





  ///===============profile update================<>
  RxBool updateProfileLoading = false.obs;

  profileUpdate({
    File? image,
    String? firstName, lastName, dateOfBirth, phone, address
  }) async {
    updateProfileLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody =
    image == null ? [] : [MultipartBody("image", image)];

    var headers = {
      'Authorization': 'Bearer $token'
    };

   var body = {
      "firstName": '$firstName',
      "lastName": '$lastName',
      "dateOfBirth": '$dateOfBirth',
      "phone": '$phone',
      "address": '$address',
    };
    var response = await ApiClient.putMultipartData(
        ApiConstants.profileUpdate, body,
        multipartBody: multipartBody, headers: headers);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.back();
      Get.back();
      ToastMessageHelper.showToastMessage('Profile Updated Successful');
      updateProfileLoading(false);
    }
  }

}