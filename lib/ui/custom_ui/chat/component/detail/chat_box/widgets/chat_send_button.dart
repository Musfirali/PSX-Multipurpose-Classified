import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/detail/chat_box/widgets/chat_send_button.dart';

class CustomChatSendButton extends StatelessWidget {
  const CustomChatSendButton(
      {required this.messageController,
      required this.chatFlag,
      required this.insertDataToFireBase,
      required this.isUserOnline,
      required this.sessionId});

  final TextEditingController messageController;
  final String chatFlag;
  final Function insertDataToFireBase;
  final String isUserOnline;
  final String sessionId;

  @override
  Widget build(BuildContext context) {
    return ChatSendButton(
      chatFlag: chatFlag,
      messageController: messageController,
      insertDataToFireBase: insertDataToFireBase,
      isUserOnline: isUserOnline,
      sessionId: sessionId,
    );
  }
}
