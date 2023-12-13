import 'package:flutter/material.dart';

import '../../../../../vendor_ui/chat/component/detail/chat_box/chat_box.dart';

class CustomChatBoxWidget extends StatefulWidget {
  const CustomChatBoxWidget({
    Key? key,
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
  }) : super(key: key);

  final Function insertDataToFireBase;
  final String? sessionId;
  final String chatFlag;
  final String? isUserOnline;

  @override
  _EditTextAndButtonWidgetState createState() =>
      _EditTextAndButtonWidgetState();
}

class _EditTextAndButtonWidgetState extends State<CustomChatBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return ChatBoxWidget(
        chatFlag: widget.chatFlag,
        insertDataToFireBase: widget.insertDataToFireBase,
        isUserOnline: widget.isUserOnline,
        sessionId: widget.sessionId);
  }
}
