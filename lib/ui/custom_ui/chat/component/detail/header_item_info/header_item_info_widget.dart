import 'package:flutter/material.dart';

import '../../../../../vendor_ui/chat/component/detail/header_item_info/header_item_info_widget.dart';

class CustomHeaderItemInfoWidget extends StatelessWidget {
  const CustomHeaderItemInfoWidget({
    Key? key,
    required this.insertDataToFireBase,
    required this.sessionId,
    required this.chatFlag,
    required this.isUserOnline,
    required this.tagKey,
    required this.buyerUserId,
    required this.sellerUserId,
  }) : super(key: key);

  final Function insertDataToFireBase;
  final String? sessionId;
  final String chatFlag;
  final String? isUserOnline;
  final String tagKey;
  final String? buyerUserId;
  final String? sellerUserId;

  @override
  Widget build(BuildContext context) {
    return HeaderItemInfoWidget(
      chatFlag: chatFlag,
      insertDataToFireBase: insertDataToFireBase,
      isUserOnline: isUserOnline,
      sessionId: sessionId,
      tagKey: tagKey,
      buyerUserId: buyerUserId,
      sellerUserId: sellerUserId,
    );
  }
}
