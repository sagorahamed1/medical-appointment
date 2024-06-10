import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
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
}