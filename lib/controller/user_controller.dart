import 'package:fenix/screens/home/home.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/user_services.dart';
import '../models/user_model.dart';
import '../screens/auth_screens/create_profile.dart';
import '../screens/onboarding/loading.dart';
import '../screens/profile/edit_profile.dart';
import '../screens/views.dart';
import 'store_controller.dart';

class UserController extends GetxController {
  String _token = '';
  var gender = ''.obs;
  UserModel? user;


  Position? _currentPosition;

  Position? userCurrentPosition;

  String getToken() => _token;

  UserModel? getUser() => user;

  setToken(token) => _token = token;

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
    await Permission.location.request();
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) async{
        _currentPosition = position;
        userCurrentPosition = position;
        List<Placemark> placemarks = await placemarkFromCoordinates(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
        Placemark place = placemarks[0];
        print(place);

    }).catchError((e) {
      print(e);
    });
  }

  setPersistToken(token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }


}
