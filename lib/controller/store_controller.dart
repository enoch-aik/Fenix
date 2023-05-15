import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/store_services.dart';
import '../screens/onboarding/loading.dart';

class StoreController extends GetxController {
  var storeList = [].obs;
  var productList = [].obs;
  var vehicleList = [].obs;
  var apartmentList = [].obs;
  var isFetchingStore = true.obs;
  var isFetchingProducts = true.obs;
  var isFetchingVehicles = true.obs;
  var isFetchingApartments = true.obs;
  String _id = '';

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
      } else {
        storeList.value = [];
        print('Error - $response');
      }
    }, token);
  }

  String getDefaultStoreId() => _id;

  setDefaultStoreId(id) => _id = id;

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

  createNewProduct(token,
      {storeId,
      color,
      price,
      title,
      category,
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
        Get.back();
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
        Get.back();
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

  createNewApartment(token,
      {storeId,
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
      media}) async {
    var data = {
      "title": title,
      "description": description,
      "location": {
        "longitude": longitude,
        "latitude": latitude,
      },
      "propertyType": propertyType,
      "apartmentType": apartmentType.toString().toLowerCase(),
      "rentPrice": {
        "night": double.parse(nightAmount),
        "week": double.parse(weekAmount),
        "month": double.parse(monthAmount)
      },
      "rentAvailability": {"startDate": startDate, "endDate": endDate},
      "specifics": {
        "bedroom": double.parse(bedroom ?? '1'),
        "bathroom": double.parse(bathroom ?? '1'),
        "shower": double.parse(shower ?? '1'),
        "toilet": double.parse(toilet ?? '1'),
        "floor": double.parse(floor ?? '1'),
        "squareMetre": double.parse(sqMeter ?? '0'),
        "amenities": amenities,
      },
      "rules": {
        "occupant": double.parse(occupantsNumber ?? '1'),
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
        Get.back();
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
        if(category=='products') {
          getProducts(token, storeId);
        }
        if(category=='vehicles') {
          getVehicles(token, storeId);
        }
        if(category=='apartments') {
          getApartments(token, storeId);
        }

        Get.back();
        CustomSnackBar.successSnackBar(
            'Great!', 'New $category created successfully');
      } else {
        print('Errororor   ==> $response');
      }
    },
        token: token,
        storeId: storeId,
        productId: itemId,
        category: category,
        images: media);
  }
}
