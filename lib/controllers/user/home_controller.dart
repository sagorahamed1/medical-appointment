import 'dart:convert';

import 'package:doctor_appointment/controllers/models/user/doctor_data_models.dart';
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

  RxList <DoctorDataModel> doctorLists =<DoctorDataModel> [].obs;


  getDoctorByCetegory({String cetegory = 'Cardiologists'})async{
    var response = await ApiClient.getData(ApiConstants.getDoctor(cetegory));

    if(response.statusCode == 200){
      var responseData = response.body;
      
      doctorLists.value = List<DoctorDataModel>.from(responseData['data']['attributes'].map((x)=> DoctorDataModel.fromJson(x)));
      print("get succussful");
    }
  }
}