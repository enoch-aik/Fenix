import 'api_docs.dart';
import 'api_scheme.dart';

class PaymentServices {

  static createCard(
      Function callback, data, token) async {
    var response =
    await ApiServices.initialisePostRequest(url: cardUrl, data: data, token: token);
    print(response);
    if (response['error'] != null) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static initialisePayment(
      Function callback, data, token) async {
    var response =
    await ApiServices.initialisePostRequest(url: paymentUrl, data: data, token: token);
    print(response);
    if (response['error'] != null) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getCards(
      Function callback,token) async {
    var response =
    await ApiServices.initialiseGetRequest(url: cardUrl, token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static verifyOTP(
      Function callback, data, token) async {
    var response =
    await ApiServices.initialisePostRequest(url: verifyOtpUrl, data: data, token: token);
    print(response);
    if (response['error'] != null) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static resendOTP(
      Function callback, data, token) async {
    var response =
    await ApiServices.initialisePostRequest(url: resendOtpUrl, data: data, token: token);
    print(response);
    if (response['error'] != null) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static removeCard(
      Function callback, token, data) async {

    var response =
    await ApiServices.initialiseDeleteRequest(url: cardUrl, data:data, token: token);
    print(response);
    if (response is String) {

      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getPlans(
      Function callback,token, planType) async {
    var response =
    await ApiServices.initialiseGetRequest(url: "$planUrl?type=$planType", token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


}


