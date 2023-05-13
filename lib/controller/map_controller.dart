
import 'package:fenix/screens/home/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

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
  var apartmentListClicked = [].obs;
  var apartmentFilterList = [].obs;

  String googleApikey = "AIzaSyDAEYCfRxJfUNR_ng1PSOJojIZ_P7SXEXE";

  late GoogleMapController googleMapController;

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
