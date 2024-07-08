import 'dart:convert';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AuthController extends GetxController {
  bool isChecked = false;
  bool isCheckboxError = false;

  RxBool isObscure = true.obs;
  RxBool isObscureConfirmPassword = true.obs;

  toggleIsObscure() {
    isObscure.value = !isObscure.value;
  }

  toggleIsObscureConfirmPassword() {
    isObscureConfirmPassword.value = !isObscureConfirmPassword.value;
  }

  TextEditingController otpCtrl = TextEditingController();
  TextEditingController genderCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController mobileNumberCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();

  ///===============Sing up ================<>
  handleSignUp(String firstName, lastName, email, password) async {
      String role = await PrefsHelper.getString(AppConstants.role);

      var headers = {
        'Content-Type': 'application/json'
      };

      var body = jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "role": role
      });

      var response = await ApiClient.postData(
        ApiConstants.signUpEndPoint,
        body,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.offAllNamed(AppRoutes.veryfyEmailScreen,
            parameters: {'screenType': 'signUp', 'email': email});
        print("======>>> Successful");
        print("======>>> Response: ${response.body}");
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
  }


  ///===============Verfy Email================<>
  verfyEmail(String otpCode) async {
    var body = {"email": "${Get.parameters['email']}", "code": "$otpCode"};

    var response = await ApiClient.postData(ApiConstants.signUpEndPoint, body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.fillProfileScreen);
      print("======>>> successful");
      print("======>>> successful ${response.body}");
    }
  }

  ///===============Fill profile or update profile================<>
  fillProfileOrUpDate() async {
    var body = {
      "gender": "${Get.parameters['email']}",
      "dataOfBirth": "$dateOfBirthCtrl",
      "phone": "$mobileNumberCtrl",
      "address": "$addressCtrl"
    };

    var response =
        await ApiClient.postMultipartData(ApiConstants.signUpEndPoint, body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.fillProfileScreen);
      print("======>>> successful");
      print("======>>> successful ${response.body}");
    }
  }
}
