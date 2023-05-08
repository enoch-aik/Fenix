import 'package:fenix/screens/home/home.dart';
import 'package:get/get.dart';

import '../helpers/widgets/snack_bar.dart';
import '../models/services/map_services.dart';
import '../models/services/user_services.dart';
import '../models/user_model.dart';
import '../screens/auth_screens/create_profile.dart';
import '../screens/onboarding/loading.dart';
import '../screens/profile/edit_profile.dart';
import '../screens/views.dart';

class MapController extends GetxController {

  var isSearchingApartments = true.obs;
  var apartmentList = [].obs;

  getApartments(token, {longitude, latitude}) {
    isSearchingApartments(true);
    MapServices.getApartmentsAround((status, response) {
      isSearchingApartments(false);
      print(response);
      if (status) {
        apartmentList.value = response['data'];
        CustomSnackBar.successSnackBar(
            'Success', 'Locations Retrieved');
      } else {
        CustomSnackBar.failedSnackBar('Failed', '$response');
      }
    }, token, {
      "longitude": longitude,
      "latitude": latitude,
    },);
  }

}
