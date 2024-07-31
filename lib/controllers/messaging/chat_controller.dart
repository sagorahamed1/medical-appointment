import 'package:doctor_appointment/models/chat_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/socket_services.dart';

class ChatController extends GetxController {
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);
  RxBool getChatLoading = false.obs;
  RxList<ChatModel> chatMessages = <ChatModel>[].obs;

  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
    }
  }

  @override
  void onInit() {
    chatMessages.clear();
    super.onInit();
  }



  listenMessage(String chatId) async {
    SocketServices.init();
    print('Setting up listener for chat::$chatId');
    try{
      SocketServices.socket.on("lastMessage::$chatId", (data) {
        print("=========> Response Message: $data -------------------------");

        if (data['message'] != null) {
          ChatModel demoData = ChatModel.fromJson(data['message']);
          chatMessages.add(demoData);
          chatMessages.refresh();
          update();

        } else {
          print("No message data found in the response");
        }
      });
    }catch(e, s){
      print("--------------e : $e");
      print("--------------s : $s");
    }

  }


  offSocket(String receiverId) {
    SocketServices.socket.off("chat::$receiverId");
    debugPrint("Socket off New message");
  }

  String chatId = '';
  String receiverId = '66a20a567945362b252447fb';

  // String chatId = '';
  getChatList({String id = ''}) async {
    getChatLoading(true);
    if (id != '') {
      chatId = id;
    }
    var response =
        await ApiClient.getData(ApiConstants.getChatEndPoint(chatId));

    if (response.statusCode == 200) {
      chatMessages.value = List<ChatModel>.from(response.body['data']
              ['attributes']
          .map((x) => ChatModel.fromJson(x)));
      getChatLoading(false);
    } else if (response.statusCode == 404) {
      getChatLoading(false);
    }
  }


  // Send a message
  void sendMessage(String message, String receiverId, String senderId, String chatId) {
    final body = {
      "message": message,
      "receiverId": receiverId,
      "senderId": senderId,
      "chatId": chatId,
    };
    SocketServices.emit('send-message', body);
  }
}
