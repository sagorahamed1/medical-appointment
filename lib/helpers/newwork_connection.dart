import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var connectivityResult = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    } catch (e) {
      result = ConnectivityResult.none;
    }
    _updateConnectionStatus([result]);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    ConnectivityResult result = results.last;
    connectivityResult.value = result;

    // Show toast message only when disconnected
    if (result == ConnectivityResult.none) {
      Get.snackbar(
        'Connection Status',
        'No internet connection',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool get isConnected {
    return connectivityResult.value == ConnectivityResult.mobile ||
        connectivityResult.value == ConnectivityResult.wifi;
  }
}
