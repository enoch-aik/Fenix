import 'package:http/http.dart' as http;

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

  static getApartment(Function callback, token, storeId) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$storesUrl/$storeId/apartments', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static getVehicles(Function callback, token, storeId) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$storesUrl/$storeId/vehicles', token: token);
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

  static createVehicle(Function callback, token, storeId, data) async {
    var response = await ApiServices.initialisePostRequest(
        url: '$storesUrl/$storeId/vehicles', token: token, data: data);
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
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  uploadFile(token, storeId,data) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    print('Inspection...');
    var uri = Uri.parse('$storesUrl/$storeId/apartments');

    var request = http.MultipartRequest("POST", uri);


    request.files.add(await http.MultipartFile.fromPath('media', data['media'].path));


    request.headers.addAll(headers);

    request.fields['title'] = data['title'];

    var response = await request.send();
    print(response.statusCode);
    print(response.reasonPhrase);

    // if (response.statusCode.toString() == '200' ||
    //     response.statusCode.toString() == '201') {
    //   response.stream.transform(utf8.decoder).listen((value) {
    //     setState(() {
    //       var body = jsonDecode(value);
    //     });
    //   });
    // }
  }
}
