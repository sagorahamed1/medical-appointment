import 'package:get/get.dart';
import '../services/api_client.dart';

class PrivacyPolicyAllController extends GetxController {
  RxBool isLoading = false.obs;
  RxString content = ''.obs;

//==============================> Get Privacy Policy Method <==========================
  getPrivacy({String url = ''}) async {
    isLoading.value = true;
    var response = await ApiClient.getData(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var attributes = data['data']['attributes']['content'];
      content.value = attributes;
      isLoading.value = false;
    }
  }
}
