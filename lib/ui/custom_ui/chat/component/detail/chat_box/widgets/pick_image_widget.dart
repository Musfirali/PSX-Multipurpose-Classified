import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/detail/chat_box/widgets/pick_image_widget.dart';

class CustomPickImageWidget extends StatefulWidget {
  const CustomPickImageWidget({
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
  });
  final String chatFlag;
  final String sessionId;
  final String isUserOnline;
  final Function insertDataToFireBase;

  @override
  State<StatefulWidget> createState() => _CustomPickImageWidget();
}

class _CustomPickImageWidget extends State<CustomPickImageWidget> {
  @override
  Widget build(BuildContext context) {
    return PickImageWidget(
      chatFlag: widget.chatFlag,
      insertDataToFireBase: widget.insertDataToFireBase,
      isUserOnline: widget.isUserOnline,
      sessionId: widget.sessionId,
    );
  }
}
