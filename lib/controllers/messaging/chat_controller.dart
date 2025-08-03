import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:doctor_appointment/models/chat_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../services/socket_services.dart';
import '../../utils/app_constant.dart';

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
    print("****************************Total page : $page");
    print("****************************Total page : $totalPage");
    print("****************************Total currectPage : $currectPage");
    print("****************************Total result : $totalResult");
    if (totalPage > page.value) {
      page.value += 1;
      getChatList();
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
  RxString receiverName = ''.obs;

  void listenMessage(String chatId) async {
    try {
      SocketServices.socket?.on("lastMessage::$chatId", (data) {
        print("=========> Response Message: $data -------------------------");
        if (data != null) {
          ChatModel demoData = ChatModel.fromJson(data);
          // print("---------------demoData: ${demoData.senderId} \n ${demoData.runtimeType}");
          chatMessages.insert(0, demoData);
          //  chatMessages.add(demoData);
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
    SocketServices.socket?.off("lastMessage::$chatId");
    debugPrint("Socket off New message");
  }



  getChatList({String id = ''}) async {
    getChatLoading(true);
    if (id != '') {
      chatId = id;
    }
    var response = await ApiClient.getData(ApiConstants.getChatEndPoint(chatId, page.value));
    if (response.statusCode == 200) {
      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;

      var data = List<ChatModel>.from(response.body['data']['attributes'].map((x) => ChatModel.fromJson(x)));
      chatMessages.addAll(data);
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

  sendMessageWithImage(File? image, String receiverId, String chatId, String senderId)async{
    String token = await PrefsHelper.getString(AppConstants.bearerToken);
    List<MultipartBody> multipartBody = image == null ? [] : [MultipartBody("image", image)];
    var body = {
      'messageType' : 'image',
      'message' : 'image',
      'receiverId' : '$receiverId',
      "senderId": senderId,
      'chatId' : '$chatId',
    };

    var headers = {'Authorization': 'Bearer $token'};
    var response = await ApiClient.postMultipartData(
        ApiConstants.senMessageWithFileEndPoint, body,
        multipartBody: multipartBody, headers: headers);

    if(response.statusCode == 200 || response.statusCode == 201){
      // SocketServices.emitWithAck('send-message', body);
      // chatMessages.clear();
      // getChatList();

      // final responseBody = response.body;
      // ChatModel chatModel = ChatModel.fromJson(responseBody["data"]["attributes"]);
      // print("=============================================$chatModel");
      // chatMessages.insert(0, chatModel);
      chatMessages.value;
      update();


      print("=================message send successful");
    }
  }
}
