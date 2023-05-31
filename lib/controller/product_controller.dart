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

  @override
  void onInit() {

    boot();
    super.onInit();
  }

 String getUserToken(){
    UserController userController = Get.find();
  var  token = userController.getToken();
    return token;
  }

  boot() {
    getApartments(  Category().property[0]);
    getProducts(  Category().homeCategories[3]);
  }

  getApartments( type) {
    isFetchingApartments(true);
    ProductServices.getApartmentsByType((status, response) {
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    },  getUserToken(), type);
  }

  clearSearch( category) {
    if (category == 'car') {
      getProducts( category);
    } else if (category == 'electronics') {
      getProducts( category);
    } else {
      getApartments(  category);
    }
  }

  searchStore( category, searchWord) {
    if (category == 'car') {
      searchVehicle( searchWord);
    } else if (category == 'electronics') {
      searchVehicle( searchWord);
    } else {
      searchApartments( searchWord);
    }
  }

  searchApartments( searchWord) {
    isFetchingApartments(true);
    ProductServices.getApartmentsByTitle((status, response) {
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    },  getUserToken(), searchWord);
  }

  searchVehicle( searchWord) {
    isFetchingProducts(true);
    ProductServices.getVehiclesByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    },  getUserToken(), searchWord);
  }

  searchProduct( searchWord) {
    isFetchingProducts(true);
    ProductServices.getProductsByTitle((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    },  getUserToken(), searchWord);
  }

  getProducts( category) {
    isFetchingProducts(true);
    ProductServices.getProductsByCategory((status, response) {
      isFetchingProducts(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    },  getUserToken(), category);
  }
}
