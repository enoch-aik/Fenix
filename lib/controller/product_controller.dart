import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';
import '../helpers/categories.dart';
import '../helpers/widgets/snack_bar.dart';
import '../models/services/product_services.dart';
import '../models/services/store_services.dart';

class ProductController extends GetxController {
  var apartmentList = [].obs;
  var productList = [].obs;
  var vehicleList = [].obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingApartments = true.obs;
  String token = '';

  @override
  void onInit() {
    // TODO: implement onInit
    UserController userController = Get.find();
    token = userController.getToken();
    boot();
    super.onInit();
  }

  boot() {
    getApartments(token, Category().property[0]);
    getProducts(token, Category().homeCategories[3]);
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

  getProducts(token, category) {
    isFetchingProducts(true);
    ProductServices.getProductsByCategory((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, token, category);
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

  addProductToWishlist(token,
      {productId}) {
    ProductServices.addToWishlist((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'Profile created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
    "productId": productId,
    }, token);
  }


}
