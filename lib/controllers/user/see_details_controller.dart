import 'package:get/get.dart';

import '../../models/user/user_see_details_model.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class SeeDetailsController extends GetxController{
  RxBool doctorSeeDetailsLoading = false.obs;
  Rx<UserSeeDetailsModel> seeDetails = UserSeeDetailsModel().obs;
  getSeeDetails({String id = ''})async{
    doctorSeeDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.seeDetailsUserPart(id));
    if(response.statusCode == 200){
      var responseData = response.body;
      seeDetails.value = UserSeeDetailsModel.fromJson(responseData['data']['attributes']);
      print("get succussful");
      doctorSeeDetailsLoading(false);
    }else if(response.statusCode == 404){
      doctorSeeDetailsLoading(false);
    }
  }
}