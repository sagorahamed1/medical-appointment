import 'dart:convert';
import 'dart:io';
import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/services/firebase_services.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../views/widgets/call_invitation.dart';

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
    String role = await PrefsHelper.getString(AppConstants.mockRole);
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

      ///***********firebase code*************///
      AuthService authService = AuthService();
      authService.signUp(firstName, lastName, email, password, role, userId: id);
      ///***********firebase code*************///


      print('====> id $id');
      Get.toNamed(AppRoutes.veryfyEmailScreen, parameters: {'screenType': 'signUp', 'email': email});
      ToastMessageHelper.showToastMessage('Signup successful! Check your email for the OTP.');
      signUpLoading(false);
    }else{
      signUpLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"].toString());
    }
  }


  ///===============Log in================<>
  RxBool logInLoading = false.obs;

  handleLogIn(String email, password) async {
    final ProfileControler _profileControler = Get.find<ProfileControler>();
    _profileControler.getProfile();
    logInLoading(true);
    var headers = {'Content-Type': 'application/json'};
    var body = {
      "email": email,
      "password": password,
    };
    var response = await ApiClient.postData(ApiConstants.signInEndPoint, jsonEncode(body),
        headers: headers);
    var userName = await PrefsHelper.getString(AppConstants.userName);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = response.body['data'];
      await PrefsHelper.setString(AppConstants.role, data['attributes']['role']);
      // await PrefsHelper.setString(AppConstants.token, data['token']);
      await PrefsHelper.setString(AppConstants.bearerToken, data['token']);
      await PrefsHelper.setString(AppConstants.email, email);
      await PrefsHelper.setString(AppConstants.userId, data['attributes']['_id']);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      await PrefsHelper.setString(AppConstants.pas, password);
      await PrefsHelper.setString(AppConstants.image, data["attributes"]["image"]["publicFileURL"]);

      var role = data['attributes']['role'];
      var isAdmin = data['attributes']['isAdmin'];

      print("==============> ${data['attributes']['_id']}");
      ///***********firebase code*************///
      AuthService authService = AuthService();
      authService.login(email, password, data['attributes']['_id']);
      ///***********firebase code*************///
      if (!isAdmin) {
        if (role == "user") {
          Get.offAllNamed(AppRoutes.userBottomNavBar);
        } else {
          Get.offAllNamed(AppRoutes.doctorBottomNavBar);
        }
        ToastMessageHelper.showToastMessage('Your are logged in!');
      }
      logInLoading(false);


      ///***********firebase code*************///
      authService.signUp("${userName.split(" ")[0]}", "${userName.split(" ")[1]}", email, password, role, userId: data["attributes"]["_id"]);
      ///***********firebase code*************///


      var image = data["attributes"]["image"];
      initializeCallInvitation(
        name: "$userName",
        id: "$email",
        image: image.toString()
      );


      await PrefsHelper.setString(AppConstants.insurance, data["attributes"]["insurance"]["publicFileURL"]);

      // onUserLogin



    }else if(response.statusCode == 1){
      logInLoading(false);
      ToastMessageHelper.showToastMessage("Some thing want wrong try again!");
    }else{
      logInLoading(false);
      print("*****************************${response.body['message']}");
      if(response.body['message'] == "you are not veryfied"){
        Get.toNamed(AppRoutes.veryfyEmailScreen, parameters: {'screenType': 'signUp', 'email': email});
      }
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }


  ///===============Verify Email================<>
  RxBool verfyLoading = false.obs;

  verfyEmail(String otpCode, email, type) async {
    verfyLoading(true);
    var body = {"email": email, "code": otpCode};

    var response = await ApiClient.postData(
        ApiConstants.verifyOtpEndPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('============Type $type');
      if (type == 'forgotPassword') {
        Get.toNamed(AppRoutes.setPasswordScreen,
            parameters: {'email': "${Get.parameters['email']}"});
      } else if (type == 'signUp') {
        Get.toNamed(AppRoutes.fillProfileScreen);
        ToastMessageHelper.showToastMessage('OTP verified successfully! Your account is now active.');
      }
      verfyLoading(false);
    }else{
      verfyLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"].toString());
    }
  }

  ///===============Fill profile or update profile================<>
  RxBool fillProfileLoading = false.obs;

  fillProfileOrUpDate(File? image) async {
    fillProfileLoading(true);
    List<MultipartBody> multipartBody = image == null ? [] : [MultipartBody("image", image)];
    var userId = await PrefsHelper.getString(AppConstants.userId);

    var headers = {'Content-Type': 'application/json'};
    print("===============================================file type : $image");

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
      var jsonResponse = response.body;
      var role = jsonResponse['data']['attributes']['role'];

      if (role == "doctor") {
        Get.toNamed(AppRoutes.continueDoctorDetailsScreen);
        ToastMessageHelper.showToastMessage('Account Create Successful \n Please give your information');
      } else if (role == 'user') {
        Get.toNamed(AppRoutes.signInScreen);
        ToastMessageHelper.showToastMessage('Account Create Successful');
      }
      fillProfileLoading(false);
    }else{
      fillProfileLoading(false);
      ToastMessageHelper.showToastMessage(response.body["message"]);
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
      print('=================screen type $screenType');
      Get.toNamed(AppRoutes.veryfyEmailScreen,
          parameters: {"screenType": "forgotPassword", 'email': email});
      // ToastMessageHelper.showToastMessage('');
      print("======>>> successful");
      forgotLoading(false);
    }
  }

  ///===============Set Password================<>
  RxBool setPasswordLoading = false.obs;

  setPassword(String email, password) async {
    setPasswordLoading(true);
    var body = {"email": email, "password": password};

    var response = await ApiClient.postData(
        ApiConstants.setPasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.offAllNamed(AppRoutes.signInScreen);
      ToastMessageHelper.showToastMessage('Password Changed');
      print("======>>> successful");
      setPasswordLoading(false);
    }
  }

  ///===============Resend================<>
  RxBool resendLoading = false.obs;

  reSendOtp(String email) async {
    resendLoading(true);
    var body = {"email": email};

    var response =
        await ApiClient.postData(ApiConstants.reSendOtpPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Get.offAllNamed(AppRoutes.signInScreen);
      // ToastMessageHelper.showToastMessage('You have got an one time code to your email');
      print("======>>> successful");
      resendLoading(false);
    }
  }

  RxBool continueDoctorDetailLoading = false.obs;
  ///===============Resend================<>
  continueDoctorDetails(
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
    continueDoctorDetailLoading(true);
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

    var response = await ApiClient.postData(ApiConstants.continueDoctorPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
       Get.offAllNamed(AppRoutes.signInScreen);
      ToastMessageHelper.showToastMessage('Your account create successful! \n please Sign In');
      print("======>>> successful");
       continueDoctorDetailLoading(false);
    }else{
      continueDoctorDetailLoading(false);
    }
  }


  ///===============Change Password================<>
  RxBool changePasswordLoading = false.obs;

  changePassword(String oldPassword, newPassword) async {
    changePasswordLoading(true);
    var body = {
      "oldPassword": "$oldPassword",
      "newPassword": "$newPassword"
    };

    var response = await ApiClient.testPostData(
        ApiConstants.changePasswordPoint, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      ToastMessageHelper.showToastMessage('Password Changed Successful');
      print("======>>> successful");
      changePasswordLoading(false);
    }else{
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }



}
