import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/widgets/snack_bar.dart';
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

  Rx<Position>?  userCurrentPosition;
  var isFetchingUserLocation = true.obs;

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
          CustomSnackBar.failedSnackBar('Welcome!', 'Update your profile to continue');
          Get.off(() =>  Views());
        } else {
          CustomSnackBar.failedSnackBar('Failed', '$response');
        }
      }
    }, token);
  }

  updateProfile(token, {phoneNumber, gender, address, city, country, username}) {
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
    }, {"phoneNumber":phoneNumber, "gender": gender, "address": address, "city": city, "country": country, "username": username }, token);
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

  getCurrentLocation() async{
    isFetchingUserLocation(true);
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) async{
          print("++++====${position}");
        _currentPosition = position;
        userCurrentPosition = position.obs;
        isFetchingUserLocation(false);
        print("++++++${_currentPosition!.latitude}");
        print("=======${userCurrentPosition!.value.latitude.obs}");

    }).catchError((e) {
      print(e);
    });
  }

  setPersistToken(token,refreshToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refreshToken', refreshToken);
  }


}
