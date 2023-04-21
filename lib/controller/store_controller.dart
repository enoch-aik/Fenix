import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
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

  createNewProduct(
    token, {
    storeId,
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
    description,
    deliveryAddress,
    deliveryCity,
    quantity,
  }) async {
    Get.to(() => const Loading());

    StoreServices.createProduct((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();
        getProducts(token, storeId);
        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
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
        "category": category,
        "color": color,
        "storageCapacity": capacity,
      },
      "price": {
        "amount": double.parse(price),
        "discount": double.parse(discount),
      },
      "shipping": {
        "shipping": true,
        "price": double.parse(shippingCost),
        "details": deliveryAddress,
        "location": deliveryCity
      }
    });
  }

  createNewApartment(token,
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

    StoreServices.createApartment((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();
        getProducts(token, storeId);
        CustomSnackBar.successSnackBar('Great!', 'Store created successfully');
      } else {
        Get.back();
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, storeId, {
      "title": "Cozy Apartment",
      "description": "A cozy and comfortable apartment in the city center.",
      "location": "123 Main St, City Center, Example City",
      "propertyType": "apartment",
      "rentPrice": {"night": 120, "week": 800, "month": 3000},
      "rentAvailability": {
        "startDate": "2023-05-01T00:00:00.000Z",
        "endDate": "2023-08-31T00:00:00.000Z"
      },
      "specifics": {
        "bedroom": 2,
        "bathroom": 1,
        "shower": 1,
        "toilet": 1,
        "floor": 3,
        "squareMetre": 80,
        "amenities": ["wifi", "tv", "air_conditioning", "kitchen"]
      },
      "rules": {"occupant": 4, "pet": false, "smoke": false}
    });
  }
}
