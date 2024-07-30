import 'dart:convert';

import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../models/chat_user_model.dart';

class ChatListController extends GetxController {

  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getChatUser();
    }
  }

  @override
  void onInit() {
    chatUsers.clear();
    getChatUser();
    super.onInit();
  }


  RxBool getChatUserLoading = false.obs;
  RxList<ChatUserModel> chatUsers = <ChatUserModel>[].obs;
  getChatUser()async{
    getChatUserLoading(true);
    var response = await ApiClient.getData(ApiConstants.getUserListEndPoint);

    if(response.statusCode == 200){
      // totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      // currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      // totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
      chatUsers.value = List<ChatUserModel>.from(response.body['data']['attributes'].map((x) => ChatUserModel.fromJson(x)));
      // var data = List<ChatUserModel>.from(response.body['data']['attributes'].map((x) => ChatUserModel.fromJson(x)));
      // chatUsers.addAll(data);
      getChatUserLoading(false);
    }else if(response.statusCode == 404){
      getChatUserLoading(false);
    }
  }
  
  
  
  
  

  ///====Create Chat list=====>
  createChat({String? receiverId, appointmentId}) async {
    var body = {"receiverId": "$receiverId", "appointmentId": "$appointmentId"};

    var response = await ApiClient.testPostData(ApiConstants.createChatList, jsonEncode(body));

    if(response.statusCode == 200 || response.statusCode == 201){
      Get.toNamed(AppRoutes.chatScreen);
    }
  }

}
