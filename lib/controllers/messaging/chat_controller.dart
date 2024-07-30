import 'package:doctor_appointment/models/chat_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


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


  RxBool getChatLoading = false.obs;
  RxList<ChatModel> chatMessages = <ChatModel>[].obs;

  String chatId = '';
  getChatList({String id = ''})async{
    getChatLoading(true);
    if(id != ''){
      chatId = id;
    }
    var response = await ApiClient.getData(ApiConstants.getChatEndPoint(chatId));

    if(response.statusCode == 200){
      chatMessages.value = List<ChatModel>.from(response.body['data']['attributes'].map((x) => ChatModel.fromJson(x)));
      getChatLoading(false);
    }else if(response.statusCode == 404){
      getChatLoading(false);
    }
  }
}