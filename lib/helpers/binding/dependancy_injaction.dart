import 'package:doctor_appointment/controllers/profile_controler.dart';
import 'package:doctor_appointment/controllers/user/home_controller.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';

class DependencyInjection implements Bindings {

  DependencyInjection();

  @override
  void dependencies() {
    Get.lazyPut(() => ProfileControler(), fenix: true);
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}