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
        CustomSnackBar.successSnackBar(
            'Great!', 'Product created successfully');
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
    year,
    model,
    seats,
    key,
    description,
    deliveryAddress,
    detail,category,plan,
    amenities,media,
  }) async {
    Get.to(() => const Loading());

    StoreServices.createVehicle((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        Get.back();
        getProducts(token, storeId);
        CustomSnackBar.successSnackBar(
            'Great!', 'Product created successfully');
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
        "price": price,
        "details": detail,
        "location": deliveryAddress,
      },
      "media":media,

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
    amenities,media
  }) async {
    var data = {
      "title": title,
      "description": description,
      "location": {
        "longitude": longitude,
        "latitude": latitude,
      },
      "propertyType": propertyType,
      "apartmentType": apartmentType,
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
        "amenities": amenities,
      },
      "rules": {
        "occupant": double.parse(occupantsNumber),
        "pet": pet,
        "smoke": smoke
      },
      media:media,
    };
    print(data);
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
    }, token, storeId, data);
  }
}
