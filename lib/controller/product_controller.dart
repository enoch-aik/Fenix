import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';
import '../helpers/categories.dart';
import '../helpers/widgets/snack_bar.dart';
import '../models/services/product_services.dart';
import '../models/services/store_services.dart';

class ProductController extends GetxController {
  var apartmentList = [].obs;
  var houseList = [].obs;
  var dachaList = [].obs;
  var productList = [].obs;
  var vehicleList = [].obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingApartments = true.obs;
  var isFetchingDacha = true.obs;
  var isFetchingHouse = true.obs;

  @override
  void onInit() {
    boot();
    super.onInit();
  }

  String getUserToken() {
    UserController userController = Get.find();
    var token = userController.getToken();
    return token;
  }

  boot() {
    getApartments();
    getDacha();
    getHouse();
    getProducts();
    getProducts();
  }

  getDacha() {
    // isFetchingApartments(true);
    ProductServices.getApartmentsByType((status, response) {
      // apartmentList.clear();
      isFetchingDacha(false);
      if (status) {
        dachaList.value = response['data'];
      } else {
        dachaList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[0].toString().toLowerCase());
  }

  getHouse() {
    // isFetchingApartments(true);
    ProductServices.getApartmentsByType((status, response) {
      // apartmentList.clear();
      isFetchingHouse(false);
      if (status) {
        houseList.value = response['data'];
      } else {
        houseList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[1].toString().toLowerCase());
  }

  getApartments() {
    // isFetchingApartments(true);
    ProductServices.getApartmentsByType((status, response) {
      // apartmentList.clear();
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[2].toString().toLowerCase());
  }

  clearSearch(category) {
    if (category == 'car') {
      isFetchingVehicles(true);

      getVehicle();
    } else if (category == 'electronics') {
      isFetchingProducts(true);

      getProducts();
    } else if (category == 'dacha') {
      isFetchingDacha(true);

      getDacha();
    } else if (category == 'house') {
      isFetchingHouse(true);

      getHouse();
    } else {
      isFetchingApartments(true);

      getApartments();
    }
  }

  searchStore(category, searchWord) {
    if (category == 'car') {
      searchVehicle(searchWord);
    } else if (category == 'electronics') {
      searchProduct(searchWord);
    } else {
      searchApartments(searchWord);
    }
  }

  searchApartments(searchWord) {
    isFetchingApartments(true);
    ProductServices.getApartmentsByTitle((status, response) {
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  searchVehicle(searchWord) {
    // isFetchingProducts(true);
    ProductServices.getVehiclesByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  searchProduct(searchWord) {
    isFetchingProducts(true);
    ProductServices.getProductsByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  getProducts() {
    // isFetchingProducts(true);
    ProductServices.getProductsByCategory((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[4]);
  }

  getVehicle() {
    // isFetchingProducts(true);
    ProductServices.getProductsByCategory((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[3]);
  }
}
