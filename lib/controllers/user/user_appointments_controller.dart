import 'dart:convert';

import 'package:doctor_appointment/models/user/user_appointments_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../utils/app_constant.dart';

class UserAppointmentsController extends GetxController{

  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);

  @override
  void onInit() {
    super.onInit();
    getAppointment();
  }

  void loadMore() {
    print('=====> ${totalPage > page.value}');
    if (totalPage > page.value) {
      page.value++;
      update();
      getAppointment();
     }
  }


  RxBool appointmentLoading = false.obs;
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList <UserAppointMentModel> appointmentList = <UserAppointMentModel> [].obs;
  
  getAppointment({String status = 'upcomming'})async{
    print("=======Call hare");
    if (page.value == 1) {
      appointmentLoading(true);
    }

    var response = await ApiClient.getData("${ApiConstants.getAppointments(status)}&limit=3&page=${page.value}");

    if(response.statusCode == 200){

      totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
      currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
      totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;

      List<UserAppointMentModel> fetchedAppointments = List<UserAppointMentModel>.from(response.body['data']['attributes'].map((x) => UserAppointMentModel.fromJson(x)));


      appointmentList.addAll(fetchedAppointments);
      appointmentLoading(false);
      setRxRequestStatus(Status.completed);
      update();
    }else if(response.statusCode == 404){
      appointmentLoading(false);
    }else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      }
      else{
        setRxRequestStatus(Status.error);
      }
    }
  }
}