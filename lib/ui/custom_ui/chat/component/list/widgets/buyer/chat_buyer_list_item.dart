import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/chat_history.dart';
import '../../../../../../vendor_ui/chat/component/list/widgets/buyer/chat_buyer_list_item.dart';

class CustomChatBuyerListItem extends StatelessWidget {
  const CustomChatBuyerListItem({
    Key? key,
    required this.chatHistory,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final ChatHistory chatHistory;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return ChatBuyerListItem(
      chatHistory: chatHistory,
      animation: animation,
      animationController: animationController,
    );
  }
}
