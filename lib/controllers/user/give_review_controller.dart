import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:get/get.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class GiveReviewController extends GetxController{


  RxBool giveReviewLoading = false.obs;
  giveReview({String? rating, doctorId, comment})async{
    giveReviewLoading(true);
    var body = {
        "doctorId":"$doctorId",
        "rating":"$rating",
        "comment":"$comment"
    };

    var response = await ApiClient.testPostData(ApiConstants.giveReviewEndPoint, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201){
      giveReviewLoading(false);
      ToastMessageHelper.showToastMessage('Thank you for your review');
      Get.back();
      Get.back();
      Get.back();
      print("---------------------------successful");
    }
  }



}