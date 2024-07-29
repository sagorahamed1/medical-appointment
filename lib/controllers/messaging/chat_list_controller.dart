import 'dart:convert';

import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {

  ///====Create Chat list=====>
  createChat({String? receiverId, appointmentId}) async {
    var body = {"receiverId": "$receiverId", "appointmentId": "$appointmentId"};

    var response = await ApiClient.testPostData(ApiConstants.createChatList, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201){
      Get.toNamed(AppRoutes.chatScreen);
    }
  }

}
