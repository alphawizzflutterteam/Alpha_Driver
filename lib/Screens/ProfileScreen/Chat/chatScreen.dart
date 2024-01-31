import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work/Screens/ProfileScreen/Chat/controller/chatController.dart';
import 'package:work/helper/CustomWidgets/commonappbar.dart';
import 'package:work/utilities/color.dart';
import 'package:work/utilities/utils.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final scrollController = ScrollController();
  TextEditingController txtMessage = TextEditingController();

  @override
  void initState() {
    super.initState();
    callApi();
  }

  callApi() async {
    await controller.getChatHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: const CommanAppbar(
          appbarTitle: 'Alpha Chatbot',
          forHome: false,
        ),
        body: Column(
          children: [
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            itemCount: controller.chatMessages.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 10, bottom: 10),
                                child: Align(
                                  alignment: (controller.chatMessages[index]
                                              .sentByDeliveryMan ==
                                          "0"
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5)),
                                      color: (controller.chatMessages[index]
                                                  .sentByAdmin !=
                                              "1"
                                          ? colors.buttonColor
                                          : Colors.grey.shade600),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        Text(
                                          controller
                                              .chatMessages[index].message,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  fontSize: Platform.isAndroid
                                                      ? 12
                                                      : 14,
                                                  color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            controller.isLoading.value
                ? Container()
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Color.fromARGB(255, 229, 229, 229),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      // margin:
                      //     const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding: const EdgeInsets.only(
                          left: 20, bottom: 20, top: 10, right: 20),
                      height: 75,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // GestureDetector(
                          //   onTap: () {},
                          //   child: const SizedBox(
                          //     height: 30,
                          //     width: 30,
                          //     child: Icon(
                          //       Icons.camera_alt_outlined,
                          //       color: Colors.black,
                          //       size: 25,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Expanded(
                            child: TextField(
                              controller: txtMessage,
                              decoration: InputDecoration(
                                // fillColor:
                                //     Theme.of(context).brightness == Brightness.dark
                                //         ? Colors.white
                                //         : Colors.white,
                                hintText: "Type message",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black),
                                contentPadding: EdgeInsets.all(8.0),
                                border: InputBorder.none,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          controller.isLoading.value
                              ? Container()
                              : FloatingActionButton(
                                  onPressed: () async {
                                    if (txtMessage.text != "") {
                                      Map data = {
                                        'id': "1",
                                        'message': txtMessage.text
                                      };
                                      txtMessage.clear();
                                      await controller.sendChat(data, context);
                                      callApi();
                                    } else {
                                      Utils.showFlushBarWithMessage(
                                          "Please enter something.", context);
                                    }

                                    // setState(() {});
                                  },
                                  backgroundColor: colors.buttonColor,
                                  elevation: 0,
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
