import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/chat/buyer_chat_history_list_provider.dart';
import '../../../../../custom_ui/chat/component/list/widgets/buyer/chat_buyer_list_data.dart';
import '../../../../../custom_ui/chat/component/list/widgets/buyer/chat_buyer_list_empty_box.dart';
import '../../../../common/ps_ui_widget.dart';

class ChatBuyerListView extends StatefulWidget {
  const ChatBuyerListView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatBuyerListViewState();
}

class _ChatBuyerListViewState extends State<ChatBuyerListView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BuyerChatHistoryListProvider _provider =
        Provider.of<BuyerChatHistoryListProvider>(context);
    animationController.forward();
    // print('STATUS:::::::::::::::::::buyer' + _provider.currentStatus.name + _provider.statusSucessSecondTime.toString());
    // if (_provider.currentStatus == PsStatus.SUCCESS) {
    //   ++_provider.statusSucessSecondTime;
    // }
    return Stack(
      children: <Widget>[
        RefreshIndicator(
            child: (_provider.hasData)
                ? CustomChatBuyerListData(
                    animationController: animationController)
                : (_provider.chatHistoryList.data != null &&
                        _provider.chatHistoryList.data!.isEmpty &&
                        _provider.statusSucessSecondTime >= 2)
                    ? CustomChatBuyerListEmptyBox()
                    : const SizedBox(),
            onRefresh: () {
              _provider.resetShowProgress();
              _provider.statusSucessSecondTime = 0;
              return _provider.loadDataList(reset: true);
            }),
        if (_provider.showProgress && _provider.statusSucessSecondTime < 2)
          const PSProgressIndicator(PsStatus.PROGRESS_LOADING)
        else
          const PSProgressIndicator(PsStatus.NOACTION)
      ],
    );
  }
}
