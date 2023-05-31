import 'package:fenix/models/services/api_docs.dart';

import 'api_scheme.dart';

class ChatServices {
  static getUserChats(Function callback, token, userId) async {
    var response = await ApiServices.initialiseGetRequest(
        url: '$getVendorChatUrl/$userId', token: token);
    print('Chats ----> $response');
    if (response is String) {
      callback(false, response);
    } else {
      callback(true, response);
    }
  }

  static String getChatUrl(roomId) => '$chatUrl$roomId';
}
