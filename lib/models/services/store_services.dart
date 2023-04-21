import 'api_docs.dart';
import 'api_scheme.dart';

class StoreServices {
  static getUserStores(Function callback, token) async {
    var response =
        await ApiServices.initialiseGetRequest(url: storesUrl, token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getProducts(Function callback, token, storeId) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$storesUrl/$storeId/products', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static createStore(Function callback, token, data) async {
    var response = await ApiServices.initialisePostRequest(
        url: storesUrl, token: token, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static createProduct(Function callback, token, storeId, data) async {
    var response = await ApiServices.initialisePostRequest(
        url: '$storesUrl/$storeId/products', token: token, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static createApartment(Function callback, token, storeId, data) async {
    var response = await ApiServices.initialisePostRequest(
        url: '$storesUrl/$storeId/apartments', token: token, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }
}
