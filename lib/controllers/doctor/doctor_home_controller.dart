import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../models/doctor/doctor_appointment_model.dart';

class DoctorHomeControllerDoctorPart extends GetxController{
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


  RxBool appointmentLoading = false.obs;
  RxList <DoctorAppointmentModelDoctorPart> appointmentsList = <DoctorAppointmentModelDoctorPart> [].obs;
  getAppointment({String status = ''})async{
    if (page.value == 1) {
      appointmentLoading(true);
    }

    var response = await ApiClient.getData(ApiConstants.doctorAppointmentHomeScreenApiEndPoint(status));

    if(response.statusCode == 200){
      if(response.body != null){
        var data = List<DoctorAppointmentModelDoctorPart>.from(response.body['data']['attributes'].map((x)=> DoctorAppointmentModelDoctorPart.fromJson(x)));
        appointmentsList.value.addAll(data);
        appointmentLoading(false);
      }
    }else if(response.statusCode == 404){
      appointmentLoading(false);
    }
  }
}