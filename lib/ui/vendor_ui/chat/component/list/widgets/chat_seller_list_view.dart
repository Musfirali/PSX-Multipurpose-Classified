import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/chat/seller_chat_history_list_provider.dart';
import '../../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_data.dart';
import '../../../../../custom_ui/chat/component/list/widgets/seller/chat_seller_list_empty_box.dart';
import '../../../../common/ps_ui_widget.dart';


class ChatSellerListView extends StatefulWidget {
  const ChatSellerListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatSellerListViewState();
}

class _ChatSellerListViewState extends State<ChatSellerListView>
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
    final SellerChatHistoryListProvider _provider =
        Provider.of<SellerChatHistoryListProvider>(context);
    animationController.forward();
    // print('STATUS:::::::::::::::::::' + _provider.currentStatus.name + _provider.statusSucessSecondTime.toString());
    // if (_provider.currentStatus == PsStatus.SUCCESS) {
    //   ++_provider.statusSucessSecondTime;
    // }
    return Stack(
      children: <Widget>[
        RefreshIndicator(
            child: (_provider.hasData)
                ? CustomChatSellerListData(
                    animationController: animationController,
                  )
                : (_provider.chatHistoryList.data != null &&
                        _provider.chatHistoryList.data!.isEmpty &&
                        _provider.statusSucessSecondTime >= 2)
                    ? CustomChatSellerListEmptyBox()
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
