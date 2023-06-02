import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = [].obs;
  var allChats = [].obs;
  var isLoadingChats = true.obs;
  var isLoadingAllChats = true.obs;
  var chatId = ''.obs;
  var vendorName = ''.obs;

  @override
  void onInit() {
    getAllChats();
    super.onInit();
  }

  String getToken() {
    UserController userController = Get.find();
    var token = userController.getToken();
    return token;
  }


  getVendorChats(vendorId) {
    isLoadingChats(true);
    ChatServices.getVendorChats((status, response) {
      isLoadingChats(false);
      if (status) {
        chats.value = response['data']['messages'];
        chatId.value = response['data']['chatId'];
        vendorName.value = response['data']['recipient'];
      } else {
        chats.value = [];
        print('Chat Error - $response');
      }
    }, getToken(), vendorId);
  }

  getChatsById(id) {
    isLoadingChats(true);
    ChatServices.getChatsById((status, response) {
      isLoadingChats(false);
      if (status) {
        chats.value = response['data']['messages'];
        chatId.value = response['data']['chatId'];
      } else {
        chats.value = [];
        print('Chat Error - $response');
      }
    }, getToken(), id);
  }

  getAllChats() {
    isLoadingAllChats(true);
    ChatServices.getUserChats((status, response) {
      isLoadingAllChats(false);
      if (status) {
        allChats.value = response['data'];
      } else {
        allChats.value = [];
        print('All Chat Error - $response');
      }
    }, getToken());
  }
}
