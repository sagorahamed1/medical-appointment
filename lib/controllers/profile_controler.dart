import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/models/profile_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constant.dart';
import '../views/screens/profile/profile/profile_screen.dart';

class ProfileControler extends GetxController{

  RxString? userName = "".obs;
  RxString? image = ''.obs;


  fetchData() async {
    refresh();
     userName?.value = await PrefsHelper.getString(AppConstants.userName);
     image?.value = await PrefsHelper.getString(AppConstants.image);
     update();
  }

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
      await PrefsHelper.setString(AppConstants.userName, "${responseData['data']['attributes']['firstName']} ${responseData['data']['attributes']['lastName']}");
      await PrefsHelper.setString(AppConstants.image, "${responseData['data']['attributes']['image']["publicFileURL"]}");


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

    print("****************************image path : ${image}");
    updateProfileLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody = image == null ? [] : [MultipartBody("image", image)];

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
      await PrefsHelper.setString(AppConstants.image, response.body["data"]["attributes"]["image"]["publicFileURL"]);
      fetchData();
      update();
      ToastMessageHelper.showToastMessage('${response.body["message"]}');
      updateProfileLoading(false);
    }else {
      updateProfileLoading(false);
    }
  }

}