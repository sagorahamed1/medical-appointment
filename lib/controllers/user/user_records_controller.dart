import 'dart:convert';
import 'package:get/get.dart';
import '../../models/user_records_models.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';


class UserRecordsController extends GetxController{
  @override
  void onInit() {
    getRecords();
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
      getRecords();
    }
  }



  RxBool recordsLoading = false.obs;
  RxList<UserRecordsModel> records = <UserRecordsModel>[].obs;



  getRecords() async {
    if (page.value == 1) {
      recordsLoading(true);
    }
    var response = await ApiClient.getData(
        "${ApiConstants.userRecordsEndPoint}?limit=6&page=${page.value}");

    if (response.statusCode == 200) {
      if (response.body != null) {
        totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
        currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
        totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
        var data = List<UserRecordsModel>.from(response.body['data']['attributes'].map((x) => UserRecordsModel.fromJson(x)));
        records.addAll(data);
        recordsLoading(false);
      }
    } else if (response.statusCode == 404) {
      recordsLoading(false);
    }
  }
}