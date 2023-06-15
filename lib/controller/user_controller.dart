import 'dart:async';

import 'package:fenix/controller/account_controller.dart';
import 'package:fenix/controller/product_controller.dart';
import 'package:fenix/models/services/api_docs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/store_services.dart';
import '../models/services/user_services.dart';
import '../models/user_model.dart';
import '../screens/onboarding/loading.dart';
import '../screens/views.dart';
import 'store_controller.dart';

class UserController extends GetxController {
  String _token = '';
  String _refreshToken = '';
  var gender = ''.obs;
  UserModel? user;
  Position? _currentPosition;
  Rx<Position>? userCurrentPosition;
  var isFetchingUserLocation = true.obs;
  var isFetchingWishes = true.obs;
  var isLoadingLikes = false.obs;
  var selectedId = ''.obs;
  var wishList = [].obs;

  @override
  void onInit() {
    super.onInit();
    autoRefreshToken();
  }

  autoRefreshToken() {
    AccountController accountController = Get.find();
    Timer.periodic(const Duration(minutes: 10), (timer) {
      accountController.refreshToken(getRefreshToken());
    });
  }

  String getToken() => _token;

  String getRefreshToken() => _refreshToken;

  UserModel? getUser() => user;

  setToken(token) => _token = token;

  setRefresh(refreshToken) => _refreshToken = refreshToken;

  fetchUser(token) {
    UserServices.getUser((status, response) {
      print(response);
      if (status) {
        setUser(response);
      } else {
        if (response.toString().contains('profile yet')) {
          CustomSnackBar.failedSnackBar(
              'Welcome!', 'Update your profile to continue');
          Get.off(() => const Views());
        } else {
          CustomSnackBar.failedSnackBar('Failed', '$response');
        }
      }
    }, token);
  }

  updateProfile(token,
      {phoneNumber, gender, address, city, country, username}) {
    Get.to(() => const Loading());
    UserServices.updateUser((status, response) {
      if (status) {
        fetchUser(token);
        CustomSnackBar.successSnackBar(
            'Success', 'Profile updated successfully');
      } else {
        Get.back();

        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
      "phoneNumber": phoneNumber,
      "gender": gender,
      "address": address,
      "city": city,
      "country": country,
      "username": username
    }, token);
  }

  uploadMedia({token, media}) async {
    StoreServices.uploadFile((status, response) {
      print('==> $response');
      if (status) {
        Get.back();
        CustomSnackBar.successSnackBar(
            'Great!', 'Profile Picture uploaded successfully');
      } else {
        print('Errororor   ==> $response');
      }
    }, profilePixUrl, token: token,title: 'picture', images: media);
  }

  updateLocation(token, lat, lon) {
    print("+++<<<>>${lat},.....$lon");
    UserServices.updateUserLocation((status, response) {
      if (status) {
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {"latitude": 37.785834, "longitude": -122.406417}, token);
  }

  createProfile(token,
      {phoneNumber, gender, address, city, country, username}) {
    Get.to(() => const Loading());
    UserServices.createUser((status, response) {
      print(response);
      if (status) {
        fetchUser(token);
        CustomSnackBar.successSnackBar(
            'Success', 'Profile created successfully');
      } else {
        Get.back();

        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {
      "phoneNumber": phoneNumber,
      "gender": gender,
      "address": address,
      "city": city,
      "country": country,
      "username": username
    }, token);
  }

  setUser(response) {
    UserModel user = UserModel.fromJson(response['data']);
    this.user = user;
    Get.to(() => const Views());
    Get.put(StoreController());
    getCurrentLocation();
  }

  getCurrentLocation() async {
    isFetchingUserLocation(true);
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) async {
      print("++++====${position}");
      _currentPosition = position;
      userCurrentPosition = position.obs;
      updateLocation(_token, userCurrentPosition!.value.latitude,
          userCurrentPosition!.value.longitude);
      isFetchingUserLocation(false);
    }).catchError((e) {
      print(e);
    });
  }

  addItemToWishList(token, productId, String category) async {
    isLoadingLikes(true);
    selectedId(productId);
    var categoryId = (category.toLowerCase() == 'electronics' ||
            category.toLowerCase() == 'cars')
        ? 'productId'
        : 'apartmentId';
    UserServices.createWishList((status, response) {
      isLoadingLikes(false);
      selectedId('');

      if (status) {
        ProductController productController = Get.find();
        productController.onInit();

        CustomSnackBar.successSnackBar('Cool', 'Product added to wishlist');
        getWishList(token);
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {categoryId: productId});
  }

  deleteItemFromWishList(token, productId, category) async {
    isLoadingLikes(true);
    selectedId(productId);
    print(category);
    var categoryId = (category == "car")
        ? 'vehicleId'
        : (category == "apartment" ||
                category == "dacha" ||
                category == "house")
            ? "apartmentId"
            : "productId";

    UserServices.deleteFromWishList((status, response) {
      isLoadingLikes(false);
      selectedId('');

      if (status) {
        ProductController productController = Get.find();
        productController.onInit();

        CustomSnackBar.successSnackBar('Cool', 'Product deleted from wishlist');
        getWishList(token);
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {categoryId: productId});
  }

  getWishList(token) async {
    isFetchingWishes(true);
    UserServices.getWishList((status, response) {
      print('==> $response');
      isFetchingWishes(false);
      if (status) {
        wishList.value = response['data'];
      } else {
        wishList.value = [];
        print('Error - $response');
      }
    }, token);
  }

  setPersistToken(token, refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refreshToken', refreshToken);
  }
}
