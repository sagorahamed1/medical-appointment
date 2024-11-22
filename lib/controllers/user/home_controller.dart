
import 'dart:convert';

import 'package:doctor_appointment/models/user/cetegory_model.dart';
import 'package:doctor_appointment/models/user/doctor_details_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/doctor/emergeny_doctor_model.dart';
import '../../models/user/doctor_data_models.dart';



class HomeController extends GetxController{
  TextEditingController searchCtrl = TextEditingController();


  RxList <CetegoryModel> cetegoryLists =<CetegoryModel> [].obs;
  RxList cetegoryNames = [].obs;
  RxBool cetegoryLoading = false.obs;
  getCetegory()async{
    var headers = {
      'Content-Type': 'application/json'
    };
    cetegoryLoading(true);
    var response = await ApiClient.getData(ApiConstants.category,headers: headers);
    if(response.statusCode == 200){
      var responseData = response.body;
      cetegoryLists.value = List<CetegoryModel>.from(responseData['data']['attributes'].map((x)=> CetegoryModel.fromJson(x)));
      // for(var data in cetegoryLists.value){
      //  cetegoryNames.add(data.name);
      // }
      cetegoryNames.clear();
      cetegoryLists.forEach((x) {
        if (x.name != null) {
          cetegoryNames.add(x.name!);}});
      print("get succussful");
      cetegoryLoading(false);
    }else if(response.statusCode == 404){
      cetegoryLoading(false);
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


///=======================Load More For Get Doctors=================================

  void loadMoreGetDoctors() {
    print('=====> ${totalPage > pageForDoctors.value}');
    if (totalPage > pageForDoctors.value) {
      pageForDoctors.value++;
      update();
      getDoctorByCetegory();
    }
  }

  RxInt pageForDoctors = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


  ///===========Get doctor by cetegory==============>
  RxList <DoctorDataModel> doctorLists =<DoctorDataModel> [].obs;
  RxBool doctorLoading = false.obs;
  getDoctorByCetegory({String cetegory = '', date})async{
    doctorLoading(true);
    var response = await ApiClient.getData('${ApiConstants.getDoctor(cetegory)}&date=$date?page=${pageForDoctors.value}');
    if(response.statusCode == 200){
      var responseData = response.body;

      doctorLists.value = List<DoctorDataModel>.from(responseData['data']['attributes'].map((x)=> DoctorDataModel.fromJson(x)));
      // totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      // currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      // totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
      print("get succussful");
      doctorLoading(false);
    }else if(response.statusCode == 404){
      doctorLoading(false);
    }
  }







  ///===========Get doctor by cetegory==============>

  RxInt page = 1.obs;

  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getEmergencyDoctor();
    }
  }


  RxList <EmergenyDoctorModel> emergencyDoctors =<EmergenyDoctorModel> [].obs;
  RxBool emergencyDoctorLoading = false.obs;
  getEmergencyDoctor()async{
    if (page.value == 1) {
      emergencyDoctorLoading(true);
    }

    var response = await ApiClient.getData('${ApiConstants.emergencyDoctors}?page=${page.value}');
    if(response.statusCode == 200){
      var responseData = response.body;
      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
      emergencyDoctors.value = List<EmergenyDoctorModel>.from(responseData['data']['attributes'].map((x)=> EmergenyDoctorModel.fromJson(x)));
      print("get succussful");
      emergencyDoctorLoading(false);
    }else if(response.statusCode == 404){
      emergencyDoctorLoading(false);
    }
  }

}