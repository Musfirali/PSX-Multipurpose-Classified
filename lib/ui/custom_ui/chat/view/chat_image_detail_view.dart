import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/message.dart';
import '../../../vendor_ui/chat/view/chat_image_detail_view.dart';

class CustomChatImageDetailView extends StatelessWidget {
  const CustomChatImageDetailView({required this.messageObj});
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
    return ChatImageDetailView(messageObj: messageObj);
  }
}
