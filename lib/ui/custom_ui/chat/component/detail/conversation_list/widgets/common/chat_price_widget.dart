import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/viewobject/message.dart';
import 'package:psxmpc/ui/vendor_ui/chat/component/detail/conversation_list/widgets/common/chat_price_widget.dart';

class CustomChatPriceWidget extends StatelessWidget {
  const CustomChatPriceWidget({
    Key? key,
    required this.messageObj,
  }) : super(key: key);

  final Message messageObj;

  @override
  Widget build(BuildContext context) {

    return ChatPriceWidget(messageObj: messageObj,);
  }
}
