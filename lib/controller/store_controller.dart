import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';

import '../helpers/widgets/snackBar.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class StoreController extends GetxController {
  var storeList = [].obs;
  var isFetchingStore = true.obs;
  var token = '';

  @override
  void onInit() {
    // TODO: implement onInit
    UserController userController = Get.find();
    token = userController.getToken();
    super.onInit();
  }

  getStores() {
    isFetchingStore(true);
    StoreServices.getUserStores((status, response) {
      isFetchingStore(false);

      if (status) {
        storeList.value = response['data'];
      } else {
        storeList.value = [];
        print('Error - $response');
      }
    }, token);
  }

  createNewStore({name, description, location}) async {
    Get.to(() => const Loading());

    StoreServices.createStore((status, response) {
      print('==> $response');
      if (status) {
        CustomSnackBar.successSnackBar(
            'Great!', 'Store created successfully');

        // Get.to(() => const AcctCreationSuccess());
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
      "name": "MFStores",
      "description": "just testing",
      "location": "Ogun State, Nigeria"
    }, token);
  }
}
