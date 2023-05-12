import 'package:fenix/controller/user_controller.dart';
import 'package:fenix/models/services/chat_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chats = [].obs;
  var isLoadingChats = true.obs;
  String token = '';
  String userId = '';

  @override
  void onInit() {
    // TODO: implement onInit
    UserController userController = Get.find();
    token = userController.getToken();
    userId = userController.getUser()!.id!;
    getStores();
    super.onInit();
  }

  getStores() {
    isLoadingChats(true);
    ChatServices.getUserChats((status, response) {
      isLoadingChats(false);
      if (status) {
        chats.value = response['data'];
      } else {
        chats.value = [];
        print('Chat Error - $response');
      }
    }, token, userId);
  }
}
