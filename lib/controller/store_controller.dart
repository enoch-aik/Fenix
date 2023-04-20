import 'package:get/get.dart';

import '../helpers/widgets/snackBar.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class StoreController extends GetxController {
  var storeList = [].obs;
  var isFetchingStore = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  getStores(token) {
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

  getProducts(token) {
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

  createNewStore(token, {name, description, location}) async {
    Get.to(() => const Loading());

    StoreServices.createStore((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();

        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {"name": name, "description": description, "location": location});
  }

  createNewProduct(token, {storeId, name, description, location}) async {
    Get.to(() => const Loading());

    StoreServices.createProduct((status, response) {
      print('==> $response');
      if (status) {
        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId,
        {"name": name, "description": description, "location": location});
  }
}
