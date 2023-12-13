import 'package:flutter/material.dart';

import '../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../vendor_ui/chat/component/list/chat_list_view.dart';


class CustomChatListView extends StatefulWidget {
  const CustomChatListView(
      {Key? key,
      required this.buyerListProvider,
      required this.sellerListProvider,
      required this.scaffoldKey})
      : super(key: key);

  final BuyerChatHistoryListProvider? buyerListProvider;
  final SellerChatHistoryListProvider? sellerListProvider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _ChatListViewState createState() => _ChatListViewState();
}

class _ChatListViewState extends State<CustomChatListView> {

  @override
  Widget build(BuildContext context) {
    return ChatListView(
      buyerListProvider: widget.buyerListProvider,
      sellerListProvider: widget.sellerListProvider,
      scaffoldKey: widget.scaffoldKey
    );
  }
}
