import 'dart:convert';
import 'dart:io';

import 'package:fenix/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../screens/auth_screens/sign_in.dart';

class ApiServices {
  static makePostRequest({apiUrl, data, token}) async {
    final uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);
    var headers;
    if (token == null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        'accept': 'application/json',
        'token': '$token',
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }
    return await http.post(uri, body: jsonString, headers: headers);
  }

  static makePatchRequest({apiUrl, data, token}) async {
    final uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);
    var headers;

    headers = {
      'accept': 'application/json',
      'token': '$token',
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    return await http.patch(uri, body: jsonString, headers: headers);
  }

  static makeGetRequest({apiUrl, token}) async {
    var uri = Uri.parse(apiUrl);
    var headers;
    if (token == null) {
      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
      };
    } else {
      headers = {
        'accept': 'application/json',
        'token': 'Bearer $token',
        HttpHeaders.authorizationHeader: 'Bearer $token',
        'Content-Type': 'application/json'
      };
    }

    return await http.get(uri, headers: headers);
  }

  static makeDeleteRequest({apiUrl, data, token}) async {
    var uri = Uri.parse(apiUrl);
    final jsonString = json.encode(data);

    var headers = {
      'accept': 'application/json',
      'token': 'Bearer $token',
      HttpHeaders.authorizationHeader: 'Bearer $token',
      'Content-Type': 'application/json'
    };

    return await http.delete(uri, body: jsonString, headers: headers);
  }

  static initialisePostRequest(
      {required data, required String url, token}) async {
    try {
      print(token);
      print(data);
      print(url);

      http.Response response = await ApiServices.makePostRequest(
          apiUrl: url, data: data, token: token);
      var body = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (ApiServices.isRequestSuccessful(response.statusCode)) {
        print('Success');
        return body;
      } else {
        print('i am here now ERROR');
        return ApiServices.handleError(response);
      }
    } catch (e) {
      print('Errororor - $e');
      if (e.toString().contains('Expired')) {
        UserController userController = Get.find();
        userController.setPersistToken(null);
        Get.offAll(
              () => SignIn(),
        );
      }
      if (e.toString().contains('HandshakeException')) {
        return 'Check your internet connection';
      } else {
        return e.toString();
      }
    }
  }

  static initialisePatchRequest(
      {required Map<String, dynamic> data, required String url, token}) async {
    // if (await InternetServices.checkConnectivity()) {
    try {
      var response = await ApiServices.makePatchRequest(
          apiUrl: url, data: data, token: token);
      var body = jsonDecode(response.body);

      if (ApiServices.isRequestSuccessful(response.statusCode)) {
        return body;
      } else {
        return ApiServices.handleError(response);
      }
    } catch (e) {
      print(e.toString());
      if (e.toString().contains('Expired')) {
        UserController userController = Get.find();
        userController.setPersistToken(null);
        Get.offAll(
              () => SignIn(),
        );
      }
      return e.toString();
    }
    // } else {
    //   return 'Check your internet connection';
    // }
  }

  static initialiseGetRequest({required String url, token}) async {
    // if (await InternetServices.checkConnectivity()) {
    try {
      http.Response response =
          await ApiServices.makeGetRequest(apiUrl: url, token: token);

      var body = jsonDecode(response.body);
      print('Res  $url ---- $body');
      if (ApiServices.isRequestSuccessful(response.statusCode)) {
        return body;
      } else {
        return ApiServices.handleError(response);
      }
    } catch (e) {
      print('Erroror - - - - - $e');
      if (e.toString().contains('Expired')) {
        UserController userController = Get.find();
        userController.setPersistToken(null);
        Get.offAll(
          () => SignIn(),
        );
      }
      return e.toString();
    }
  }

  static handleError(http.Response response) {
    var errorMessage = jsonDecode(response.body)['errors'] != null
        ? jsonDecode(response.body)['errors'].toString()
        : jsonDecode(response.body)['message'] != null
            ? jsonDecode(response.body)['message'].toString()
            : (jsonDecode(response.body)['data'] != null &&
                    jsonDecode(response.body)['data']['detail'] != null)
                ? jsonDecode(response.body)['data']['detail'].toString()
                : (jsonDecode(response.body)['data'] != null &&
                        jsonDecode(response.body)['data']['errors'] != null)
                    ? jsonDecode(response.body)['data']['errors'].toString()
                    : jsonDecode(response.body)['result']['errors'] != null
                        ? jsonDecode(response.body)['result']['errors']
                            .toString()
                        : jsonDecode(response.body)['result']['detail'] != null
                            ? jsonDecode(response.body)['result']['detail']
                                .toString()
                            : 'Failed response';

    print(errorMessage);
    switch (response.statusCode) {
      case 400:
        throw (errorMessage);

      case 401:
        throw 'Unauthorized request - $errorMessage';

      case 403:
        throw 'Forbidden Error - $errorMessage';
      case 404:
        throw 'Not Found - $errorMessage';

      case 422:
        throw 'Unable to process - $errorMessage';

      case 500:
        throw 'Server error - $errorMessage';
      default:
        throw 'Error occurred with code : $response';
    }
  }

  static isRequestSuccessful(int? statusCode) {
    return statusCode! >= 200 && statusCode < 300;
  }
}
