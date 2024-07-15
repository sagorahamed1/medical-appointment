
import 'package:doctor_appointment/models/user/cetegory_model.dart';
import 'package:doctor_appointment/models/user/doctor_details_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user/doctor_data_models.dart';



class HomeController extends GetxController{
  TextEditingController searchCtrl = TextEditingController();

  RxList <CetegoryModel> cetegoryLists =<CetegoryModel> [].obs;
  getCetegory()async{
    var response = await ApiClient.getData(ApiConstants.category);

    if(response.statusCode == 200){
      var responseData = response.body;
      cetegoryLists.value = List<CetegoryModel>.from(responseData['data']['attributes'].map((x)=> CetegoryModel.fromJson(x)));
      print("get succussful");
    }
  }

  RxList <DoctorDataModel> doctorLists =<DoctorDataModel> [].obs;
  RxBool doctorLoading = false.obs;
  getDoctorByCetegory({String cetegory = '', date})async{
    doctorLoading(true);
    var response = await ApiClient.getData('${ApiConstants.getDoctor(cetegory)}&date=$date');
    if(response.statusCode == 200){
      var responseData = response.body;
      doctorLists.value = List<DoctorDataModel>.from(responseData['data']['attributes'].map((x)=> DoctorDataModel.fromJson(x)));
      print("get succussful");
      doctorLoading(false);
    }else if(response.statusCode == 404){
      doctorLoading(false);
    }
  }




  RxBool doctorDetailsLoading = false.obs;
  Rx<DoctorDetailsModel> doctorDetails = DoctorDetailsModel().obs;
  getDoctorDetailsHomeScreen({String id = '',String date = ''})async{
    doctorDetailsLoading(true);
    var response = await ApiClient.getData('${ApiConstants.doctorDetailsHomeScreen(id)}&date=$date');
    if(response.statusCode == 200){
      var responseData = response.body;
      doctorDetails.value = DoctorDetailsModel.fromJson(responseData['data']['attributes']); //responseData['data']['attributes'];
      print("get succussful");
      doctorDetailsLoading(false);
    }else if(response.statusCode == 404){
      doctorDetailsLoading(false);
    }
  }
}