import 'package:fenix/controller/product_controller.dart';
import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/api_docs.dart';
import '../models/services/product_services.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class StoreController extends GetxController {
  var storeList = [].obs;
  var wishList = [].obs;
  var productList = [].obs;
  var vehicleList = [].obs;
  var apartmentList = [].obs;
  var isFetchingStore = true.obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingWishes = true.obs;
  var isFetchingApartments = true.obs;

  RxBool isReviewLoading = false.obs;
  RxBool isReviewDone = false.obs;

  final ProductController _productController = Get.put(ProductController());

  String _id = '';

  var store;

  @override
  void onInit() {
    UserController userController = Get.find();
    getStores(userController.getToken());
    super.onInit();
  }

  getStores(token) {
    isFetchingStore(true);
    StoreServices.getUserStores((status, response) {
      isFetchingStore(false);
      if (status) {
        storeList.value = response['data'];
        setDefaultStoreId(response['data'][0]['id']);
        getApartments(token, response['data'][0]['id']);
        getProducts(token, response['data'][0]['id']);
        getVehicles(token, response['data'][0]['id']);
      } else {
        storeList.value = [];
        print('Error - $response');
      }
    }, token);
  }

  getStoreById(token, storeId) {
    isFetchingStore(true);
    StoreServices.getUserStoresById((status, response) {
      isFetchingStore(false);
      if (status) {
        store = response['data'];
      } else {

        print('Error - $response');
      }
    }, token, storeId);
  }

  String getDefaultStoreId() => _id;

  setDefaultStoreId(id) {
    print("yyyyy $id");
    return _id = id;
  }

  Future<dynamic> getMyProductsByCategory(token, category) async {
    var data;
    await ProductServices.getProductsByCategory((status, response) {
      if (status) {
        data = response['data'];
      } else {
        data = [];
      }
    }, token, category);
    return data;
  }

  Future<dynamic> getMyProductsByBrand(token, brand) async {
    var data;
    await ProductServices.getProductsByBrand((status, response) {
      if (status) {
        data = response['data'];
      } else {
        data = [];
      }
    }, token, brand);
    return data;
  }

  Future<dynamic> getMyVehicleByCategory(token, category) async {
    var data;
    await ProductServices.getVehiclesByCategory((status, response) {
      if (status) {
        data = response['data'];
      } else {
        data = [];
      }
    }, token, category);
    return data;
  }


  Future<dynamic> getMyApartmentByCategory(token, category) async {
    var data;
    await ProductServices.getApartmentsByCategory((status, response) {
      if (status) {
        data = response['data'];
      } else {
        data = [];
      }
    }, token, category);
    return data;
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

  getApartments(token, storeId) {
    isFetchingApartments(true);
    StoreServices.getApartment((status, response) {
      isFetchingApartments(false);
      if (status) {
        apartmentList.value = response['data'];
      } else {
        apartmentList.value = [];
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

  writeFeedback(token, {int? rate, message, userId}) async {
    isReviewLoading.value = true;
    StoreServices.writeReview((status, response) {
      print('==> $response');
      if (status) {
       isReviewLoading.value = false;
       isReviewDone.value = true;
        CustomSnackBar.successSnackBar(
            'Great!', 'Review submitted successfully');
       _productController.getVendorDetails(userId);
      } else {
        isReviewLoading.value = false;
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {"userId": userId, "message": message, "rating": rate});
  }

  createNewProduct(token,
      {storeId,
      color,
      price,
      title,
      category,model,
      plan,
      condition,
      capacity,
      brand,
      discount,
      size,
      material,
      coordinate,
      features,
      shippingCost,
      subCategory,
      description,
      deliveryAddress,
      deliveryCity,
      quantity,
      media}) async {
    Get.to(() => const Loading());
    StoreServices.createProduct((status, response) {
      print('==> $response');
      getProducts(token, storeId);
      if (status) {
        // Get.back();
        // Get.back();
        uploadMedia(
            token: token,
            storeId: storeId,
            itemId: response['data']['id'],
            media: media,
            category: 'products');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId, {

      "title": title,
      "description": description,
      "category": category,
      "plan": plan,
      "specifics": {
        "condition": condition,
        "quantity": quantity,
        "material": material,
        "brand": brand,
        "size": size,
        "model": model,
        "features": features,
        "category": {'name': category, 'subCategory': subCategory},
        "color": color,
        "storageCapacity": capacity,
      },
      "price": {
        "amount": double.parse(price),
        "discount": double.parse(discount == '' ? '0' : discount),
      },
      "shipping": {
        "shipping": true,
        "price": double.parse(shippingCost == '' ? '0' : shippingCost),
        "details": deliveryAddress,
        "location": deliveryCity
      }
    });
  }

  createNewVehicle(
    token, {
    storeId,
    color,
    price,
    title,
    previousAccident,
    firstOwner,
    mileage,
    brand,
    shippingPrice,
    year,
    model,
    seats,
    key,
    description,
    deliveryAddress,
    detail,
    category,
    plan,
    amenities,
    media,
  }) async {
    Get.to(() => const Loading());
    StoreServices.createVehicle((status, response) {
      getVehicles(token, storeId);
      if (status) {
        // Get.back();
        // Get.back();
        uploadMedia(
            token: token,
            storeId: storeId,
            itemId: response['data']['id'],
            media: media,
            category: 'vehicles');

        // CustomSnackBar.successSnackBar(
        //     'Great!', 'Product created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId, {
      "title": title,
      "description": description,
      "category": category,
      "plan": plan,
      "price": price,
      "specifics": {
        "brand": brand,
        "model": model,
        "year": year,
        "color": color,
        "mileage": mileage,
        "seats": double.parse(seats),
        "keys": double.parse(key),
        "previousAccident": previousAccident ?? false,
        "firstOwner": firstOwner ?? true,
        "amenities": amenities,
      },

      "shipping": {
        "shipping": true,
        "price": shippingPrice,
        "details": detail,
        "location": deliveryAddress,
      },
      // "media":media,
    });
  }

  createNewApartment(
    token, {
    storeId,
    bool? smoke,
    bool? pet,
    title,
    description,
    longitude,
    latitude,
    propertyType,
    apartmentType,
    nightAmount,
    weekAmount,
    monthAmount,
    startDate,
    endDate,
    bedroom,
    shower,
    bathroom,
    sqMeter,
    toilet,
    occupantsNumber,
    floor,
    amenities,
    media,
    salePrice,
  }) async {
    print('sale==> $salePrice');
    print('night==> $nightAmount');
    print('week==> $weekAmount');
    print('month==> $monthAmount');
    var data = {
      "title": title,
      "description": description,
      "location": {
        "longitude": longitude,
        "latitude": latitude,
      },
      "propertyType": propertyType,
      "apartmentType": apartmentType.toString().toLowerCase(),
      "salePrice": double.parse(salePrice == '' ? "0" : salePrice),
      "rentPrice": {
        "night": double.parse(nightAmount == '' ? "0" : nightAmount),
        "week": double.parse(weekAmount == '' ? "0" : weekAmount),
        "month": double.parse(monthAmount == '' ? "0" : monthAmount)
      },
      "rentAvailability": {"startDate": startDate, "endDate": endDate},
      "specifics": {
        "bedroom": double.parse(bedroom == '' ? '1' : bedroom),
        "bathroom": double.parse(bathroom == '' ? '1' : bathroom),
        "shower": double.parse(shower == '' ? '1' : shower),
        "toilet": double.parse(toilet == '' ? '1' : toilet),
        "floor": double.parse(floor == '' ? '1' : floor),
        "squareMetre": double.parse(sqMeter == '' ? '0' : sqMeter),
        "amenities": amenities,
      },
      "rules": {
        "occupant": double.parse(occupantsNumber == '' ? '1' : occupantsNumber),
        "pet": pet,
        "smoke": smoke
      }
    };
    print(data);
    Get.to(() => const Loading());

    StoreServices.createApartment((status, response) {
      print('==> $response');
      getApartments(token, storeId);
      if (status) {
        uploadMedia(
            token: token,
            storeId: storeId,
            itemId: response['data']['id'],
            media: media,
            category: 'apartments');
        // Get.back();
        // getApartments(token, storeId);
        // CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId, data);
  }

  uploadMedia({token, storeId, itemId, category, media}) async {
    StoreServices.uploadFile((status, response) {
      print('==> $response');
      if (status) {
        print('Successs   ==> $response');
        if (category == 'products') {
          getProducts(token, storeId);
        }
        if (category == 'vehicles') {
          getVehicles(token, storeId);
        }
        if (category == 'apartments') {
          getApartments(token, storeId);
        }

        Get.back();
        Get.back();

        CustomSnackBar.successSnackBar(
            'Great!', 'New $category created successfully');
      } else {
        print('Errororor   ==> $response');
      }
    }, '$storesUrl/$storeId/$category/$itemId/media',
        token: token, title: 'media', images: media);
  }
}
