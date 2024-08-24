import 'package:get/get.dart';

import '../../models/user/doctor_data_models.dart';
import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class SearchDoctorController extends GetxController{


  RxInt page = 1.obs;
  var totalPage = (-1);
  var currectPage = (-1);
  var totalResult = (-1);


  void loadMore() {
    if (totalPage > page.value) {
      page.value += 1;
      update();
      getDoctorBySearch();
    }
  }




  ///===========Get doctor by cetegory==============>
  RxList <DoctorDataModel> doctorLists =<DoctorDataModel> [].obs;
  RxBool doctorLoading = false.obs;
  getDoctorBySearch({String searchText = ''})async{
    doctorLoading(true);
    var response = await ApiClient.getData('${ApiConstants.getSearchDoctor(searchText)}');
    if(response.statusCode == 200){
      var responseData = response.body;
      doctorLists.value = List<DoctorDataModel>.from(responseData['data']['attributes'].map((x)=> DoctorDataModel.fromJson(x)));
      print("get succussful");
      doctorLoading(false);
    }else if(response.statusCode == 404){
      doctorLoading(false);
    }
  }

}
