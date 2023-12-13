import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/chat_history_parameter_holder.dart';
import '../../../../../../custom_ui/chat/component/list/widgets/buyer/chat_buyer_list_item.dart';

class ChatBuyerListData extends StatefulWidget {
  const ChatBuyerListData({
    Key? key,
    required this.animationController,
  }) : super(key: key);
  final AnimationController animationController;
  @override
  State<StatefulWidget> createState() => _ChatBuyerListDataState();
}

class _ChatBuyerListDataState extends State<ChatBuyerListData> {
  final ScrollController _scrollController = ScrollController();
  late PsValueHolder psValueHolder;
  late BuyerChatHistoryListProvider _provider;
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
    _provider = Provider.of<BuyerChatHistoryListProvider>(context);
    holder = ChatHistoryParameterHolder().getBuyerHistoryList();
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    holder!.getBuyerHistoryList().userId = psValueHolder.loginUserId;
    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: false,
      physics: const AlwaysScrollableScrollPhysics(), 
      itemCount: _provider.dataLength,
      itemBuilder: (BuildContext context, int index) {
        final int count = _provider.dataLength;
        return CustomChatBuyerListItem(
          animationController: widget.animationController,
          animation: curveAnimation(widget.animationController,
              index: index, count: count),
          chatHistory: _provider.getListIndexOf(index),
        );
      },
    );
  }
}
