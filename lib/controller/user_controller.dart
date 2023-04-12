import 'package:get/get.dart';

import '../helpers/widgets/snackBar.dart';
import '../models/services/user_services.dart';
import '../models/user_model.dart';
import '../screens/views.dart';

class UserController extends GetxController {
  String _token = '';
  UserModel? user;

  String getToken() => _token;

  setToken(token) => _token = token;

  fetchUser(token) {
    UserServices.getUser((status, response) {
      print(response);
      if (status) {
        setUser(response);
      } else {
        if (response.toString().contains('profile yet')) {
          Get.to(() => const Views());
        } else {
          CustomSnackBar.failedSnackBar('Failed', '$response');
        }
      }
    }, token);
  }

  updateProfile(token, {address, city, country}) {
    UserServices.updateUser((status, response) {
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'Profile updated successfully');
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {"address": address, "city": city, "country": country}, token);
  }

  createProfile(token,
      {phoneNumber, gender, address, city, country, username}) {
    UserServices.createUser((status, response) {
      print(response);
      if (status) {
        CustomSnackBar.successSnackBar(
            'Success', 'Profile created successfully');
      } else {
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

    // Get.to(() => const Views());
  }
}
