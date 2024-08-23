import 'dart:convert';

import 'package:get/get.dart';

import '../models/notification_model.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';

class NotificationController extends GetxController{



  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }


  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getNotifications();
    }
  }



  RxBool notificationLoading = false.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;



  getNotifications() async {

    if (page.value == 1) {
      notificationLoading(true);
    }

    var response = await ApiClient.getData(
        "${ApiConstants.notificationEndPoint}?limit=3&page=${page.value}");

    if (response.statusCode == 200) {
      if (response.body != null) {
        totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
        currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
        totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
        var data = List<NotificationModel>.from(response.body['data']['attributes'].map((x) => NotificationModel.fromJson(x)));
        notifications.addAll(data);
        notificationLoading(false);
      }
    } else if (response.statusCode == 404) {
      notificationLoading(false);
    }
  }

}