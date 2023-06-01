import 'package:fenix/models/services/api_docs.dart';

import 'api_scheme.dart';

class ChatServices {
  static getVendorChats(Function callback, token, userId) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$getAllChatUrl/$userId', token: token);
    print('Chats ----> $response');
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }


  static getUserChats(Function callback, token) async {
    var response = await ApiServices.initialiseGetRequest(
        url: getAllChatUrl, token: token);
    print('All Chats ----> $response');
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static String getChatUrl(roomId) => '$chatUrl$roomId';
}
