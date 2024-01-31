import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:work/Screens/ProfileScreen/Chat/model/chatModel.dart';
import 'package:work/utilities/api_manager/apis.dart';

import '../../../../utilities/api_manager/http_client.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ChatModel>? chatModel;
  RxList<Message> chatMessages = <Message>[].obs;

  getChatHistory() async {
    isLoading = true.obs;
    update();

    final res = await HTTPClient.getChatList(APIs.chatMessages);
    chatModel = res.obs;
    chatMessages = chatModel!.value.message.obs;
    isLoading = false.obs;
    update();
  }

  sendChat(dynamic map, BuildContext context) async {
    isLoading = true.obs;
    update();
    final res = await HTTPClient.postRequest(APIs.sendChat, map);
    isLoading = false.obs;
    update();
  }
}
