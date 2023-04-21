import 'package:get/get.dart';

import '../helpers/widgets/snackBar.dart';
import '../models/services/user_services.dart';
import '../models/user_model.dart';
import '../screens/auth_screens/create_profile.dart';
import '../screens/onboarding/loading.dart';
import '../screens/profile/edit_profile.dart';
import '../screens/views.dart';

class UserController extends GetxController {
  String _token = '';
  var gender = ''.obs;
  UserModel? user;

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
          Get.off(() =>  CreateProfile());
        } else {
          CustomSnackBar.failedSnackBar('Failed', '$response');
        }
      }
    }, token);
  }

  updateProfile(token, {address, city, country}) {
    UserServices.updateUser((status, response) {
      if (status) {
        fetchUser(token);
        CustomSnackBar.successSnackBar(
            'Success', 'Profile updated successfully');
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, {"address": address, "city": city, "country": country}, token);
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
  }
}
