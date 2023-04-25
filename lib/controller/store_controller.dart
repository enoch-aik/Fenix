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
        CustomSnackBar.successSnackBar('Great!', 'Product created successfully');
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

  createNewApartment(
    token, {
    storeId,
    bool? smoke,
    bool? pet,
    title,
    description,
    location,
    propertyType,
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
  }) async {
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
      "title": title,
      "description": description,
      "location": location,
      "propertyType": propertyType,
      "rentPrice": {
        "night": double.parse(nightAmount),
        "week": double.parse(weekAmount),
        "month": double.parse(monthAmount)
      },
      "rentAvailability": {"startDate": startDate, "endDate": endDate},
      "specifics": {
        "bedroom": double.parse(bedroom),
        "bathroom": double.parse(bathroom),
        "shower": double.parse(shower),
        "toilet": double.parse(toilet),
        "floor": double.parse(floor),
        "squareMetre": double.parse(sqMeter),
        "amenities": ["wifi", "tv", "air_conditioning", "kitchen"]
      },
      "rules": {
        "occupant": double.parse(occupantsNumber),
        "pet": pet,
        "smoke": smoke
      }
    });
  }
}
