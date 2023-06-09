import 'api_docs.dart';
import 'api_scheme.dart';

class UserServices {
  static getUser(
      Function callback,token) async {
    var response =
    await ApiServices.initialiseGetRequest(url: profileUrl, token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static createWishList(
      Function callback, token,data) async {
    var response =
    await ApiServices.initialisePostRequest(url: wishListUrl, data:data, token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static deleteFromWishList(
      Function callback, token, data) async {


    var response =
    await ApiServices.initialiseDeleteRequest(url: wishListUrl, data:data, token: token);
    print(response);
    if (response is String) {

      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getWishList(
      Function callback, token) async {
    var response =
    await ApiServices.initialiseGetRequest(url: wishListUrl,  token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static updateUser(
      Function callback,data,token) async {
    var response =
    await ApiServices.initialisePatchRequest(url: profileUrl, token: token,data: data);
    print(response);
    print("this");
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static updateUserLocation(
      Function callback,data,token) async {
    var response =
    await ApiServices.initialisePatchRequest(url: updateLocationUrl, token: token,data: data);

    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }



  static createUser(
      Function callback,data,token) async {
    var response =
    await ApiServices.initialisePostRequest(url: profileUrl, token: token,data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }




}


