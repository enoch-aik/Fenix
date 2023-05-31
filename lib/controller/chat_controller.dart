import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = [].obs;
  var isLoadingChats = true.obs;
var chatId = ''.obs;
  String getToken() {
    UserController userController = Get.find();
    var token = userController.getToken();
    return token;
  }


  getChats(vendorId) {
    isLoadingChats(true);
    ChatServices.getUserChats((status, response) {
      isLoadingChats(false);
      if (status) {
        chats.value = response['data']['messages'];
        chatId.value = response['data']['chatId'];
      } else {
        chats.value = [];
        print('Chat Error - $response');
      }
    }, getToken(), vendorId);
  }
}
