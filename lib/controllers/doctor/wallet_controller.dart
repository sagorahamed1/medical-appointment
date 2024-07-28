
import 'dart:convert';

import 'package:doctor_appointment/helpers/toast_message_helper.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../models/doctor/withdraw_list_model.dart';

class WalletController extends GetxController {


  num earnThisMonth = 0;
  num totalEarn = 0;
  RxBool getEarningMonthlyLoading = false.obs;
  getEarningMonthly() async {
    getEarningMonthlyLoading(true);
    var response = await ApiClient.getData(ApiConstants.getEarningMonthlyEndPoint);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      var attributes = jsonResponse['data']['attributes'];
      earnThisMonth = attributes['earnThisMonth'];
      totalEarn = attributes['totalEarn'];
      getEarningMonthlyLoading(false);
      update();
    }else if(response.statusCode == 404){
      getEarningMonthlyLoading(false);
    }
  }



///============Get Withdraw List===========>
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);

  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getWithdrawList();
    }
  }
  RxBool getWithdrawListLoading = false.obs;
  RxList<WithdrawListModel> withdrawalList = <WithdrawListModel>[].obs;
  getWithdrawList() async {
    if (page.value == 1) {
      withdrawalList.clear();
      getWithdrawListLoading(true);
    }

    var response = await ApiClient.getData("${ApiConstants.getWithdrawListEndPoint}?page=${page.value}&limit=8");
    if (response.statusCode == 200) {
      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
      var data = List<WithdrawListModel>.from(response.body['data']['attributes'].map((x) => WithdrawListModel.fromJson(x)));
      withdrawalList.addAll(data);
      getWithdrawListLoading(false);
      update();
    }else if(response.statusCode == 404){
      getWithdrawListLoading(false);
    }
  }




  RxBool withDrawRequestLoading = false.obs;
  withDrawRequest({String? bankName, accountType, accountNumber, withDrawAmount}) async {
    var body = {
      "bankName":"$bankName",
      "accountType":"$accountType",
      "accountNumber":"$accountNumber",
      "withdrawAmount":"$withDrawAmount"
    };
    withDrawRequestLoading(true);
    var response = await ApiClient.testPostData(ApiConstants.withdrawRequestEndPoint, jsonEncode(body));
    if (response.statusCode == 200) {
      Get.back();
      withDrawRequestLoading(false);
      getWithdrawList();
      getEarningMonthly();
      ToastMessageHelper.showToastMessage(response.body['message']);
      update();
    }else if(response.statusCode == 404){
      withDrawRequestLoading(false);
    }
  }
}
