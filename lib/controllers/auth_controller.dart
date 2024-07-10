import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

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
  RxBool signUpLoading = false.obs;

  ///===============Sing up ================<>
  handleSignUp(String firstName, lastName, email, password) async {
    signUpLoading(true);
    String role = await PrefsHelper.getString(AppConstants.role);

    var headers = {'Content-Type': 'application/json'};

    var body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "role": role
    };

    var response = await ApiClient.postData(
      ApiConstants.signUpEndPoint,
      jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var id = response.body['data']['attributes']['userId'];
      PrefsHelper.setString(AppConstants.userId, id);
      print('====> id $id');
      Get.toNamed(AppRoutes.veryfyEmailScreen,
          parameters: {'screenType': 'signUp', 'email': email});
      print("======>>> Successful");
      print("======>>> Response: ${response.body}");
      ToastMessageHelper.showToastMessage(
          'Signup successful! Check your email for the OTP.');
      signUpLoading(false);
    } else {
      print("Failed with status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }

  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;

  verfyEmail(String otpCode, email,  {String type = ''}) async {
    verfyLoading(true);
    var body = {"email": email, "code": otpCode};

    var response = await ApiClient.postData(
        ApiConstants.verifyOtpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('============Type $type');
      if(type == 'forgotPassword'){
        Get.toNamed(AppRoutes.setPasswordScreen, parameters: {'email' : "${Get.parameters['email']}"});
      }else{
        Get.toNamed(AppRoutes.fillProfileScreen);
        ToastMessageHelper.showToastMessage(
            'OTP verified successfully! Your account is now active.');
      }
      verfyLoading(false);
    }
  }



  ///===============Fill profile or update profile================<>
  RxBool fillProfileLoading = false.obs;

  fillProfileOrUpDate(File? image) async {
    fillProfileLoading(true);
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];
    var userId = await PrefsHelper.getString(AppConstants.userId);

    var headers = {'Content-Type': 'application/json'};

    var body = {
      "gender": genderCtrl.text,
      "dataOfBirth": dateOfBirthCtrl.text,
      "phone": mobileNumberCtrl.text,
      "address": addressCtrl.text,
      "userId": userId,
    };

    var response = await ApiClient.postMultipartData(
        ApiConstants.fillUpProfileEndPoint, body,
        multipartBody: multipartBody, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      AppConstants.roleMock == "doctor"
          ? Get.toNamed(AppRoutes.continueDoctorDetailsScreen)
          : Get.toNamed(AppRoutes.signInScreen);

      ToastMessageHelper.showToastMessage('Account Create Successful');
      print("======>>> successful");
      print("======>>> successful ${response.body}");
      fillProfileLoading(false);
    }
  }

  ///===============Log in================<>
  RxBool logInLoading = false.obs;

  handleLogIn(String email, password) async {
    logInLoading(true);

    var headers = {'Content-Type': 'application/json'};

    var body = {
      "email": email,
      "password": password,
    };

    var response = await ApiClient.postData(
        ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data'];
      await PrefsHelper.setString(
          AppConstants.role, data['attributes']['role']);
      await PrefsHelper.setString(AppConstants.token, data['token']);
      await PrefsHelper.setString(AppConstants.isLogged, true);
      var role = data['attributes']['role'];
      var isAdmin = data['attributes']['isAdmin'];

      if (!isAdmin) {
        if (role == "user") {
          // Get.toNamed(AppRoutes.userBottomNavBar);
        } else {
          // Get.toNamed(AppRoutes.doctorBottomNavBar);
        }
      }

      ToastMessageHelper.showToastMessage('');
      print("======>>> successful");
      print("======>>> successful ${response.body}");
      logInLoading(false);
    }
  }

  ///===============Forgot Password================<>
  RxBool forgotLoading = false.obs;

  handleForgot(String email, screenType) async {
    forgotLoading(true);
    var body = {"email": email};

    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (screenType == 'forgotPassword') {
        Get.toNamed(AppRoutes.veryfyEmailScreen, parameters: {
          "email" : email
        });
      } else {
        Get.toNamed(AppRoutes.veryfyEmailScreen,
            parameters: {"screenType": "forgotPassword"});
      }

      ToastMessageHelper.showToastMessage('');
      print("======>>> successful");
      forgotLoading(false);
    }
  }

  ///===============Set Password================<>
  RxBool setPasswordLoading = false.obs;
  setPassword(String email, password) async {
    setPasswordLoading(true);
    var body = {
      "email": email,
      "password": password
    };

    var response = await ApiClient.postData(
        ApiConstants.forgotPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.signInScreen);
      ToastMessageHelper.showToastMessage('Password Changed');
      print("======>>> successful");
      setPasswordLoading(false);
    }
  }
}
