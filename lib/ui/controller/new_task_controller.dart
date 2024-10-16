import 'package:get/get.dart';

import '../../api/apiClient.dart';

class NewTaskController extends GetxController{


  RxList taskItems = [].obs;
  RxBool isLoading = true.obs;



  callData() async {

    var data = await taskListRequest("New");

      isLoading.value = false;
      taskItems.value = data;
      update();

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callData();
  }


}