import 'dart:convert';

import 'package:doctor_appointment/controllers/messaging/chat_controller.dart';
import 'package:doctor_appointment/helpers/prefs_helper.dart';
import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/routes/app_routes.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:doctor_appointment/utils/app_constant.dart';
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

  getChatUser() async {
    getChatUserLoading(true);
    var response = await ApiClient.getData(ApiConstants.getUserListEndPoint);

    if (response.statusCode == 200) {
      // totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      // currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      // totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
      chatUsers.value = List<ChatUserModel>.from(response.body['data']
              ['attributes']
          .map((x) => ChatUserModel.fromJson(x)));
      // var data = List<ChatUserModel>.from(response.body['data']['attributes'].map((x) => ChatUserModel.fromJson(x)));
      // chatUsers.addAll(data);
      getChatUserLoading(false);
    } else if (response.statusCode == 404) {
      getChatUserLoading(false);
    }
  }

  ///====Create Chat list=====>
  createChat({String? receiverId, appointmentId, name}) async {

    var body = {"receiverId": "$receiverId", "appointmentId": "$appointmentId"};
    var currentUserId = await PrefsHelper.getString(AppConstants.userId);
    var response = await ApiClient.testPostData(
        ApiConstants.createChatList, jsonEncode(body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var chatId = response.body['data']['attributes']['_id'];
      print("----------Chat id : $chatId");
      Get.toNamed(AppRoutes.chatScreen, parameters: {
        'id': '$chatId',
        'receiverId': '$receiverId',
        'userName' : '$name'

      });

      var chatCtrl = Get.put(ChatController());
      chatCtrl.sendMessage(
          'fistMessage_klfdpk41324/kd2@367687jkdkjhjhjlajlfjdjdjjdlllncnjdjhfhdhfaiuhajfkajflajkfaahflkhafl',
          '$receiverId',
          currentUserId,
          '$chatId');
    } else {
      ToastMessageHelper.showToastMessage(response.body['message']);
    }
  }
}
