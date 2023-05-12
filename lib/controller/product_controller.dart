import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/product_services.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class ProductController extends GetxController {
  var apartmentList = [].obs;
  var productList = [].obs;
  var vehicleList = [].obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingApartments = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  getApartments(token, type) {
    isFetchingApartments(true);
    ProductServices.getApartmentsByType((status, response) {
      isFetchingApartments(false);

      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    }, token, type);
  }

  getProducts(token, storeId) {
    isFetchingProducts(true);
    StoreServices.getProducts((status, response) {
      isFetchingProducts(false);

      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, token, storeId);
  }


  getVehicles(token, storeId) {
    isFetchingVehicles(true);
    StoreServices.getVehicles((status, response) {
      isFetchingVehicles(false);

      if (status) {
        vehicleList.value = response['data'];
      } else {
        vehicleList.value = [];
        print('Error - $response');
      }
    }, token, storeId);
  }

}
