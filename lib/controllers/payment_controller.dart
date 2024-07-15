import 'package:get/get.dart';

class PaymentController extends GetxController{

  payment({String? data, timeSlot, patientDetailsId, patientId, doctorId, packageName, packagePrice}){


    var  body = {
      "date":"2024-07-10",
      "timeSlot":"11:00 AM",
      "patientDetailsId":"668d35eb2d9448aa2ce27d52",
      "patientId":"668a7ed80837f84d97a20368",
      "doctorId":"668ba95383496128f614fb9a",
      "paymentData":{

      },
      "package":{
        "packageName":"clinicPrice",
        "packagePrice":"60"
      },
      "transactionId":"010101333"
    };
  }
}