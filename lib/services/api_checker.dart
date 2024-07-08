import 'package:get/get.dart';
import '../helpers/prefs_helper.dart';
import '../routes/app_routes.dart';
import '../utils/app_constant.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false}) async {
    if (response.statusCode != 200) {
      if (response.statusCode == 401) {
        await PrefsHelper.remove(AppConstants.isLogged);
        await PrefsHelper.remove(AppConstants.bearerToken);
        Get.offAllNamed(AppRoutes.signInScreen);
      } else {
        // showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }
    }
  }
}