import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkController extends GetxController {
  RxBool isConnection = false.obs;
  StreamSubscription? interNetConnectionState;

  @override
  void onInit() {
    interNetConnectionState =
        InternetConnection().onStatusChange.listen((event) {
          print("----------------internet : ${event}");
      switch (event) {
        case InternetStatus.connected:
          isConnection(true);
          break;
        case InternetStatus.disconnected:
          isConnection(false);
          break;
        default:
          isConnection(false);
          break;
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    interNetConnectionState?.cancel();
    super.dispose();
  }
}
