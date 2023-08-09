import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/screens/home/search.dart';
import 'package:fenix/screens/products/vendor_details.dart';
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
  var searchList = [].obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingApartments = true.obs;
  var isFetchingDacha = true.obs;
  var isFetchingHouse = true.obs;
  var isSendingReport = false.obs;
  var isReportSent = false.obs;
  var vendor;
  RxList feedbacks = [].obs;

  RxBool isSearchEnabled = false.obs;

  String tab = '';

  RxBool isSearching = false.obs;

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
    }, getUserToken(), Category().homeCategories[2].toString().toLowerCase());
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
    }, getUserToken(), Category().homeCategories[1].toString().toLowerCase());
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

  searchStore( searchWord) {
    isSearching.value = true;
    Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value, searchText: searchWord,));
    searchVehicle(searchWord);
    searchProduct(searchWord);
    searchApartments(searchWord);

    // Future.delayed(Duration(seconds: 2), () {
    //   if(apartmentList.isEmpty && vehicleList.isEmpty && productList.isEmpty){
    //     Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value,));
    //   }
    // });


    // if (category == 'car') {
    //   searchVehicle(searchWord);

    // } else if (category == 'electronics') {
    //   searchProduct(searchWord);
    // } else if (category == 'product') {
    //   searchProduct(searchWord);
    // } else {
    //   searchApartments(searchWord);
    // }
  }

  searchApartments(searchWord) {
    isFetchingApartments(true);
    Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value, searchText: searchWord,));
    ProductServices.getApartmentsByTitle((status, response) {
      if (status) {
        apartmentList.value = response['data'];
        if(apartmentList.isNotEmpty){
          searchList.add(response['data']);
            }
        isSearching.value = false;
        if(apartmentList.isNotEmpty) {
          tab = 'Apartments';
        }
        if(vehicleList.isNotEmpty){
          tab = 'Cars';
        }
        if(productList.isNotEmpty){
          tab = 'Products';
        }
      } else {
        apartmentList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  searchVehicle(searchWord) {
    // isFetchingProducts(true);
    isFetchingVehicles(true);
    Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value, searchText: searchWord,));


    ProductServices.getVehiclesByTitle((status, response) {
      if (status) {
        vehicleList.value = response['data'];
        if(vehicleList.isNotEmpty){
          searchList.add(response['data']);
        }
        isSearching.value = false;
        if(apartmentList.isNotEmpty) {
          tab = 'Apartments';
        }
        if(vehicleList.isNotEmpty){
          tab = 'Cars';
        }
        if(productList.isNotEmpty){
          tab = 'Products';
        }
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  searchProduct(searchWord) {
    isFetchingProducts(true);
    Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value, searchText: searchWord,));

    ProductServices.getProductsByTitle((status, response) {
      if (status) {
        productList.value = response['data'];
        if(productList.isNotEmpty){
          searchList.add(response['data']);
          // Get.to(() => SearchScreen(apartmentResult: apartmentList.value,carResult: vehicleList.value, productResult: productList.value,));
        }
        isSearching.value = false;
        if(apartmentList.isNotEmpty) {
          tab = 'Apartments';
        }
        if(vehicleList.isNotEmpty){
          tab = 'Cars';
        }
        if(productList.isNotEmpty){
          tab = 'Products';
        }
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), searchWord);
  }

  getProducts() {
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
    ProductServices.getVehiclesByCategory((status, response) {
      isFetchingVehicles(false);
      if (status) {
        productList.value = response['data'];
      } else {
        productList.value = [];
        print('Error - $response');
      }
    }, getUserToken(), Category().homeCategories[3]);
  }


  getVendorDetails(vendorId) {
    ProductServices.getVendorById((status, response) {
      if (status) {
        vendor = response['data'];
        feedbacks.value = vendor['feedbacks'];
      } else {

        print('Error - $response');
      }
    }, getUserToken(), vendorId);
  }

  reportSeller(
      {vendorId, subject, description}) {
    isSendingReport.value = true;
    ProductServices.reportVendor((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'Report sent');
        isSendingReport.value = false;
        isReportSent.value = true;
      } else {
        // Get.back();
        isSendingReport.value = false;
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, getUserToken(), {
      "userId": "clh8zszwm0000uz0uebr5vt16",
      "subject": "report user",
      "description": "hiiiiii"
    }, );
  }

}
