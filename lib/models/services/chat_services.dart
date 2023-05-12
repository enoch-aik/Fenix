import 'package:fenix/models/services/api_docs.dart';

import 'api_scheme.dart';

class ChatServices{


  static getUserChats(Function callback, token,userId) async {
    var response =
    await ApiServices.initialiseGetRequest(url: '$chatUrl/$userId', token: token);
    print(response);
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }
}