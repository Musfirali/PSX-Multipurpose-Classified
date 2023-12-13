import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/chat/component/list/widgets/seller/chat_seller_list_data.dart';

class CustomChatSellerListData extends StatefulWidget {
  const CustomChatSellerListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _ChatSellerListDataState();
}

class _ChatSellerListDataState extends State<CustomChatSellerListData> {
  @override
  Widget build(BuildContext context) {
    return ChatSellerListData(animationController: widget.animationController);
  }
}
