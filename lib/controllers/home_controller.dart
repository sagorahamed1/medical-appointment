import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  TextEditingController searchCtrl = TextEditingController();

  getCetegory()async{
    var response = await ApiClient.getData(ApiConstants.category);

    if(response.statusCode == 200){
      print("get succussful");
    }
  }
}