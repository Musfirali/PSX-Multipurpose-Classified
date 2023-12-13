import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../vendor_ui/chat/component/detail/conversation_list/widgets/chat_make_offer_dialog.dart';

class CustomChatMakeOfferDialog extends StatefulWidget {
  const CustomChatMakeOfferDialog(
      {Key? key, 
      required this.itemDetail, 
      required this.onMakeOfferTap,
      required this.getChatHistoryProvider,})
      : super(key: key);

  final Product? itemDetail;
  final Function onMakeOfferTap;
  final GetChatHistoryProvider? getChatHistoryProvider;

  @override
  _ChatMakeOfferDialogState createState() => _ChatMakeOfferDialogState();
}

class _ChatMakeOfferDialogState extends State<CustomChatMakeOfferDialog> {
  @override
  Widget build(BuildContext context) {
    return ChatMakeOfferDialog(
        itemDetail: widget.itemDetail, 
        getChatHistoryProvider: widget.getChatHistoryProvider,
        onMakeOfferTap: 
        widget.onMakeOfferTap);
  }
}
