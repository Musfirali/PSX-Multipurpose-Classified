import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/paid_ad_item_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/paid_ad_item.dart';
import '../common/ps_provider.dart';

class PaidAdItemProvider extends PsProvider<PaidAdItem> {
  PaidAdItemProvider({
    required PaidAdItemRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;

  PsResource<List<PaidAdItem>> get paidAdItemList => super.dataList;
}

SingleChildWidget initPaidAdItemProvider(
  BuildContext context, {
  String? userId,
  Widget? widget,
}) {
  final PaidAdItemRepository repo = Provider.of<PaidAdItemRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<PaidAdItemProvider>(
      initProvider: () => PaidAdItemProvider(
          repo: repo,
          psValueHolder: valueHolder,
          limit: valueHolder.defaultLoadingLimit!),
      onProviderReady: (PaidAdItemProvider paidAdItemProvider) {
        if (paidAdItemProvider.psValueHolder!.loginUserId == null ||
            paidAdItemProvider.psValueHolder!.loginUserId == '') {
          paidAdItemProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  loginUserId: userId,
                  headerToken: valueHolder.headerToken,
                  languageCode: valueHolder.languageCode));
        } else {
          paidAdItemProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  loginUserId: paidAdItemProvider.psValueHolder!.loginUserId,
                  headerToken: valueHolder.headerToken,
                  languageCode: valueHolder.languageCode));
        }
        return paidAdItemProvider;
      });
}
