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
  var isFetchingDacha = true.obs;
  var isFetchingHouse = true.obs;
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

  clearSearch(token, category) {
    if (category == 'car') {
      getProducts(token, category);
    } else if (category == 'electronics') {
      getProducts(token, category);
    } else {
      getApartments(token, category);
    }
  }

  searchStore(token, category, searchWord) {
    if (category == 'car') {
      searchVehicle(token, searchWord);
    } else if (category == 'electronics') {
      searchVehicle(token, searchWord);
    } else {
      searchApartments(token, searchWord);
    }
  }

  searchApartments(token, searchWord) {
    isFetchingApartments(true);
    ProductServices.getApartmentsByTitle((status, response) {
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    }, token, searchWord);
  }

  searchVehicle(token, searchWord) {
    isFetchingProducts(true);
    ProductServices.getVehiclesByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, token, searchWord);
  }

  searchProduct(token, searchWord) {
    isFetchingProducts(true);
    ProductServices.getProductsByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, token, searchWord);
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
}
