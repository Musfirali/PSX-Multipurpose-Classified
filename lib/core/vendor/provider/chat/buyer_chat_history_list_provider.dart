import 'package:flutter/material.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/chat_history_repository.dart';
import '../../viewobject/chat_history.dart';
import '../../viewobject/holder/chat_history_parameter_holder.dart';
import '../common/ps_provider.dart';

class BuyerChatHistoryListProvider extends PsProvider<ChatHistory> {
  BuyerChatHistoryListProvider({
    @required ChatHistoryRepository? repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ChatHistoryParameterHolder chatFromBuyerParameterHolder =
      ChatHistoryParameterHolder().getBuyerHistoryList();
  bool showProgress = true;
  int statusSucessSecondTime = 0;

  PsResource<List<ChatHistory>> get chatHistoryList => super.dataList;

  void resetShowProgress({bool show = true}) {
    showProgress = show;
  }

  void clearDataList() {
    super.dataList.data?.clear();
  }
}
