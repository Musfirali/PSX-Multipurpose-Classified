import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/chat/view/chat_view.dart';

class CustomChatView extends StatefulWidget {
  const CustomChatView({
    Key? key,
    required this.itemId,
    required this.chatFlag,
    required this.buyerUserId,
    required this.sellerUserId,
    required this.userCoverPhoto,
    required this.userName,
    this.itemDetail,
  }) : super(key: key);

  final String? itemId;
  final String chatFlag;
  final String? buyerUserId;
  final String? sellerUserId;
  final String? userCoverPhoto;
  final String? userName;
  final Product? itemDetail;

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<CustomChatView> {
  @override
  Widget build(BuildContext context) {
    return ChatView(
        itemId: widget.itemId,
        chatFlag: widget.chatFlag,
        buyerUserId: widget.buyerUserId,
        sellerUserId: widget.sellerUserId,
        userCoverPhoto: widget.userCoverPhoto,
        userName: widget.userName,
        itemDetail: widget.itemDetail);
  }
}
