import 'api_docs.dart';
import 'api_scheme.dart';

class MapServices {


  static getApartmentsAround(Function callback, token, data) async {
    var response = await ApiServices.initialisePostRequest(
        url: mapUrl, token: token, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }



}


