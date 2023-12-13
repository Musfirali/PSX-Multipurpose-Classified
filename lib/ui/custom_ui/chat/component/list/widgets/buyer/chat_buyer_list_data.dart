import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/list/widgets/buyer/chat_buyer_list_data.dart';

class CustomChatBuyerListData extends StatefulWidget {
  const CustomChatBuyerListData({
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _ChatBuyerListDataState();
}

class _ChatBuyerListDataState extends State<CustomChatBuyerListData> {
  
  @override
  Widget build(BuildContext context) {
    return ChatBuyerListData(animationController: widget.animationController);
  }
}
