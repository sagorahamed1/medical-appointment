import 'dart:convert';

import 'package:doctor_appointment/services/api_client.dart';
import 'package:doctor_appointment/services/api_constants.dart';
import 'package:get/get.dart';

import '../../models/doctor/doctor_appointment_model.dart';

class DoctorHomeControllerDoctorPart extends GetxController {
  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getAppointment();
    }
  }

  @override
  void onInit() {
    appointmentsList.clear();
    getAppointment(status: 'upcomming');
    super.onInit();
  }

  RxBool appointmentLoading = false.obs;
  RxList<DoctorAppointmentModelDoctorPart> appointmentsList =
      <DoctorAppointmentModelDoctorPart>[].obs;
  String currentStatus = '';
  getAppointment({String status = ''}) async {
    if(status != ''){
      currentStatus = status;
    }
    if (page.value == 1) {
      appointmentLoading(true);
    }

    var response = await ApiClient.getData(
        "${ApiConstants.doctorAppointmentHomeScreenApiEndPoint(currentStatus)}&limit=3&page=${page.value}");

    if (response.statusCode == 200) {
      if (response.body != null) {
        totalPage = jsonDecode(response.body['pagination']['totalPages'].toString());
        currectPage = jsonDecode(response.body['pagination']['currentPage'].toString());
        totalResult = jsonDecode(response.body['pagination']['totalUsers'].toString()) ?? 0;
        var data = List<DoctorAppointmentModelDoctorPart>.from(response.body['data']['attributes'].map((x) => DoctorAppointmentModelDoctorPart.fromJson(x)));
        appointmentsList.addAll(data);
        appointmentLoading(false);
      }
    } else if (response.statusCode == 404) {
      appointmentLoading(false);
    }
  }

  RxBool doctorStatus = false.obs;
  Rx<DoctorStatus> status = DoctorStatus().obs;

  getDoctorStatus() async {
    var response = await ApiClient.getData(ApiConstants.doctorStatus);

    if (response.statusCode == 200) {
      var responseData = response.body;
      status.value = DoctorStatus.fromJson(responseData['data']['attributes']);
      print(
          '==========> ${response.body['data']['attributes']['totalAppointments']}');
      update();
    }
  }
}

class DoctorStatus {
  final int? totalAppointments;
  final int? activeAppointments;
  final int? completedAppointments;

  DoctorStatus({
    this.totalAppointments,
    this.activeAppointments,
    this.completedAppointments,
  });

  factory DoctorStatus.fromJson(Map<String, dynamic> json) => DoctorStatus(
        totalAppointments: json["totalAppointments"],
        activeAppointments: json["activeAppointments"],
        completedAppointments: json["completedAppointments"],
      );

  Map<String, dynamic> toJson() => {
        "totalAppointments": totalAppointments,
        "activeAppointments": activeAppointments,
        "completedAppointments": completedAppointments,
      };
}
