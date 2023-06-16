


import 'api_docs.dart';
import 'api_scheme.dart';

class ProductServices {

  static getApartmentsByType(Function callback, token, type) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$apartmentUrl?type=$type', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getApartmentsByCategory(Function callback, token, category) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$apartmentUrl?category=$category', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getApartmentsByTitle(Function callback, token, title) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$apartmentUrl?title=$title', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static getProductsByCategory(Function callback, token, category) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$productUrl?category=$category', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getProductsByTitle(Function callback, token, title) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$productUrl?title=$title', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getVehiclesByTitle(Function callback, token, title) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$vehicleUrl?title=$title', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static getVehiclesByCategory(Function callback, token, category) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$vehicleUrl?category=$category', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }




}