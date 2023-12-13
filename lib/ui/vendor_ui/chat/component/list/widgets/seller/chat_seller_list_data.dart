import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/chat_history_parameter_holder.dart';
import '../../../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_item.dart';

class ChatSellerListData extends StatefulWidget {
  const ChatSellerListData({required this.animationController});
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _ChatSellerListDataState();
}

class _ChatSellerListDataState extends State<ChatSellerListData> {
  final ScrollController _scrollController = ScrollController();
  late SellerChatHistoryListProvider _provider;
  late PsValueHolder psValueHolder;
  ChatHistoryParameterHolder? holder;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleOnScroll);
  }

  void _handleOnScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      holder!.getBuyerHistoryList().userId = psValueHolder.loginUserId;
      _provider.resetShowProgress(show: true);
      _provider.loadNextDataList();
    }
  }

  @override
  Widget build(BuildContext context) {
    psValueHolder = Provider.of<PsValueHolder>(context);
    _provider = Provider.of<SellerChatHistoryListProvider>(context);
    holder = ChatHistoryParameterHolder().getSellerHistoryList();
    holder!.getSellerHistoryList().userId = psValueHolder.loginUserId;

    return ListView.builder(
      shrinkWrap: false,
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(), 
      itemCount: _provider.dataLength,
      itemBuilder: (BuildContext context, int index) {
        final int count = _provider.dataLength;
        return CustomChatSellerListItem(
          animationController: widget.animationController,
          animation: curveAnimation(widget.animationController,
              index: index, count: count),
          chatHistory: _provider.getListIndexOf(index),
        );
      },
    );
  }
}
