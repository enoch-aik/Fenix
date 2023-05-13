


import 'api_docs.dart';
import 'api_scheme.dart';

class ProductServices {

  static getApartmentsByType(Function callback, token, type) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$apartmentUrl=$type', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static getProductsByCategory(Function callback, token, category) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$productUrl=$category', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

}