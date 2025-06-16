import 'dart:io';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/models/profile_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';
import '../utils/app_constant.dart';
import 'package:http/http.dart' as http;

class ProfileControler extends GetxController {
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

  getProfile() async {
    profileLoading(true);
    var response = await ApiClient.getData(ApiConstants.getProfileEndPoint);
    if (response.statusCode == 200) {
      var responseData = response.body;
      profileInfo.value =
          ProfileModel.fromJson(responseData['data']['attributes']);
      await PrefsHelper.setString(AppConstants.userName,
          "${responseData['data']['attributes']['firstName']} ${responseData['data']['attributes']['lastName']}");
      await PrefsHelper.setString(AppConstants.image,
          "${responseData['data']['attributes']['image']["publicFileURL"]}");

      print("get succussful");
      profileLoading(false);
      setRxRequestStatus(Status.completed);
    } else if (response.statusCode == 404) {
      profileLoading(false);
      setRxRequestStatus(Status.completed);
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
    }
  }

  ///===============profile update================<>
  RxBool updateProfileLoading = false.obs;

  profileUpdate(
      {File? image,
      String? firstName,
      lastName,
      dateOfBirth,
      phone,
      address}) async {
    print("****************************image path : ${image}");
    updateProfileLoading(true);
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];

    var headers = {'Authorization': 'Bearer $token'};

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
      await PrefsHelper.setString(AppConstants.image,
          response.body["data"]["attributes"]["image"]["publicFileURL"]);
      fetchData();
      update();
      ToastMessageHelper.showToastMessage('${response.body["message"]}');
      updateProfileLoading(false);
    } else {
      updateProfileLoading(false);
    }
  }

  RxString localFilePath = 'https://www.cs.toronto.edu/~vmnih/docs/dqn.pdf'.obs;

  Future<void> loadPdf(String url) async {
    final directory = await getTemporaryDirectory();
    final filePath = "${directory.path}/temp.pdf";
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    localFilePath.value = filePath;

    update();
  }

  Future<void> getLocalData() async {
    localFilePath.value = await PrefsHelper.getString(AppConstants.insurance);
    update();
  }

  ///===============profile update================<>

  RxBool insuranceUploadLoading = false.obs;
  profileUpdateInsurance({File? insurance}) async {
    insuranceUploadLoading(true);
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("insurance", insurance!)];

    var response = await ApiClient.putMultipartData(
        ApiConstants.profileUpdate, {},
        multipartBody: multipartBody);

    if (response.statusCode == 200 || response.statusCode == 201) {
      insuranceUploadLoading(false);
      print("=======> ${response.body}");
    }
    insuranceUploadLoading(false);
  }
}
