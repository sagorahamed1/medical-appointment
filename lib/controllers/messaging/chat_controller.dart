import 'dart:async';
import 'dart:convert';

import 'package:doctor_appointment/models/chat_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../services/socket_services.dart';

class ChatController extends GetxController {
  late ScrollController scrollController;
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);
  RxBool getChatLoading = false.obs;
  String chatId = '';
  // String receiverId = '66a20a567945362b252447fb';


  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
    }
  }

  @override
  void onInit() {

    // listenMessage(chatId);
    // getChatList(id: chatId);
    super.onInit();
  }
  RxList<ChatModel> chatMessages = <ChatModel>[].obs;

  void listenMessage(String chatId) async {
    try {
      SocketServices.socket.on("lastMessage::$chatId", (data) {
        print("=========> Response Message: $data -------------------------");
        if (data != null) {
          ChatModel demoData = ChatModel.fromJson(data);
          print("---------------demoData: ${demoData.senderId} \n ${demoData.runtimeType}");
          chatMessages.insert(0, demoData);
          // chatMessages.add(demoData);
          chatMessages.refresh();
          update();
          print('Message added to chatMessages list');
        } else {
          print("No message data found in the response");
        }
      });
    } catch (e, s) {
      print("Error: $e");
      print("Stack Trace: $s");
    }
  }




  offSocket(String chatId) {
    SocketServices.socket.off("lastMessage::$chatId");
    debugPrint("Socket off New message");
  }


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
      chatMessages.refresh();
      update();
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




  ///  scroll bottom and end
  scrollToEnd() {
    Timer(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.minScrollExtent,
            duration: Duration(milliseconds: 100), curve: Curves.decelerate);
      }
    });
  }

  ///  scroll fast time
  scrollTime() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      scrollController.jumpTo(
        scrollController.position.minScrollExtent,
      );
    });
  }
}
