import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../vendor_ui/chat/component/detail/header_item_info/widgets/make_offer_button.dart';

class CustomMakeOfferButton extends StatefulWidget {
  const CustomMakeOfferButton(
      {required this.isUserOnline,
      required this.insertDataToFireBase,
      required this.sessionId,
      required this.buyerUserId,
      required this.sellerUserId,
      required this.itemDetail,
      required this.getChatHistoryProvider,
      });
  final String isUserOnline;
  final Function insertDataToFireBase;
  final String sessionId;
  final String? buyerUserId;
  final String? sellerUserId;
  final Product? itemDetail;
  final GetChatHistoryProvider? getChatHistoryProvider;
  
  @override
  State<StatefulWidget> createState() => _CustomMakeOfferButtonState();
}

class _CustomMakeOfferButtonState extends State<CustomMakeOfferButton> {
  @override
  Widget build(BuildContext context) {
    return MakeOfferButton(
      insertDataToFireBase: widget.insertDataToFireBase,
      isUserOnline: widget.isUserOnline,
      sessionId: widget.sessionId,
      buyerUserId: widget.buyerUserId,
      sellerUserId: widget.sellerUserId,
      itemDetail: widget.itemDetail,
      getChatHistoryProvider: widget.getChatHistoryProvider,
    );
  }
}
