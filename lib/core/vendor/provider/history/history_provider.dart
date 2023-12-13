import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/history_repsitory.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class HistoryProvider extends PsProvider<Product> {
  HistoryProvider({
    required HistoryRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsResource<List<Product>> get historyList => super.dataList;
}

SingleChildWidget initHistoryProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  return psInitProvider<HistoryProvider>(
      initProvider: () => HistoryProvider(
            repo: Provider.of<HistoryRepository>(context),
          ),
      onProviderReady: (HistoryProvider provider) {
        function(provider);
      },
      widget: widget);
}
