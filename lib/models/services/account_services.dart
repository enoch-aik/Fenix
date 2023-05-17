import 'api_docs.dart';
import 'api_scheme.dart';

class AccountServices {
  static loginUser(
    Function callback, {
    email,
    password,
  }) async {
    var data = {"email": email, "password": password};
    var response =
        await ApiServices.initialisePostRequest(url: loginUrl, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static refreshToken(
    Function callback,token) async {
    var response =
        await ApiServices.initialisePostRequest(url: refreshUrl, data: {},token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static registerUser(Function callback,
      {email, firstName, lastName, password}) async {
    var data = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
    var response =
        await ApiServices.initialisePostRequest(url: registerUrl, data: data);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static loginOutUser(
      Function callback, token) async {
    var data = {};
    var response =
    await ApiServices.initialisePostRequest(url: logoutUrl, data: data, token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }
}

