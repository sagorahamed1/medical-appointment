import 'package:doctor_appointment/models/user/user_appointments_model.dart';
import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../utils/app_constant.dart';

class UserAppointmentsController extends GetxController{
  RxBool appointmentLoading = false.obs;
  final rxRequestStatus = Status.loading.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList <UserAppointMentModel> appointmentList = <UserAppointMentModel> [].obs;
  
  getAppointment({String status = 'upcomming'})async{
    appointmentLoading(true);
    var response = await ApiClient.getData(ApiConstants.getAppointments(status));

    if(response.statusCode == 200){
      appointmentList.value = List<UserAppointMentModel>.from(response.body['data']['attributes'].map((x)=> UserAppointMentModel.fromJson(x)));
      appointmentLoading(false);
      setRxRequestStatus(Status.completed);
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