import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/controllers/user/home_controller.dart';
import 'package:get/get.dart';

class InitialRequesterScreenBindings implements Bindings {

  InitialRequesterScreenBindings();

  @override
  void dependencies() {
    Get.put(() => ProfileControler());
    Get.put(() => HomeController());
  }
}