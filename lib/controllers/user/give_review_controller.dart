import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/models/doctor/get_review_model.dart';
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
      print("---------------------------successful");
    }
  }







  //
  RxList <GetReviewModel> reviews =<GetReviewModel> [].obs;
  RxBool getReviewLoading = false.obs;
  getReviews()async{
    // if (page.value == 1) {
    //   emergencyDoctorLoading(true);
    // }

    var response = await ApiClient.getData(ApiConstants.doctorGetReview);
    if(response.statusCode == 200){
      var responseData = response.body;
      reviews.value = List<GetReviewModel>.from(responseData['data']['attributes']['reviews'].map((x)=> GetReviewModel.fromJson(x)));
      print("get succussful");
      getReviewLoading(false);
    }else if(response.statusCode == 404){
      getReviewLoading(false);
    }
  }

}