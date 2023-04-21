import 'package:get/get.dart';

import '../helpers/widgets/snackBar.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class StoreController extends GetxController {
  var storeList = [].obs;
  var productList = [].obs;
  var isFetchingStore = true.obs;
  var isFetchingProducts = true.obs;

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

  getProducts(token,storeId) {
    isFetchingProducts(true);
    StoreServices.getProducts((status, response) {
      isFetchingProducts(false);

      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, token,storeId);
  }

  createNewStore(token, {name, description, location}) async {
    Get.to(() => const Loading());

    StoreServices.createStore((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();
        getStores(token);
        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {"name": name, "description": description, "location": location});
  }

  createNewProduct(token,
      {storeId,
      color,
      price,
      title,
      category,
      condition,
      brand,
      size,
      material,
      coordinate,
      features,
      description,
      quantity,
        address}) async {
    Get.to(() => const Loading());

    StoreServices.createProduct((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();
        getProducts(token,storeId);
        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId, {
      "title": title,
      "category": category,
      "condition": condition,
      "material": material,
      "brand": brand,
      "color": color,
      "size": 42,
      "price": 150,
      "quantity": 10,
      "location": address,
      "coordinate": coordinate,
      "features":features,
      "description":features

    });
  }
}
