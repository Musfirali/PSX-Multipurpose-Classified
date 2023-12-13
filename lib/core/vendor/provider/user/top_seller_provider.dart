import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/top_seller_repository.dart';
import '../../utils/utils.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/request_path_holder.dart';
import '../../viewobject/user.dart';
import '../common/ps_init_provider.dart';
import '../common/ps_provider.dart';

class TopSellerProvider extends PsProvider<User> {
  TopSellerProvider({
    required TopSellerRepository? repo,
    required this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION) {
    repo = repo;
  }

  TopSellerRepository? repo;
  PsValueHolder? psValueHolder;

  PsResource<List<User>> get topSellerList => super.dataList;
}

SingleChildWidget initTopSellerProvider(BuildContext context, Function function,
    {Widget? widget, String? keyword}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final TopSellerRepository repo1 = Provider.of<TopSellerRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<TopSellerProvider>(
      widget: widget,
      initProvider: () {
        return TopSellerProvider(
          repo: repo1,
          psValueHolder: valueHolder,
          limit: valueHolder.categoryLoadingLimit!,
        );
      },
      onProviderReady: (TopSellerProvider provider) {
        provider.loadDataList(
            requestPathHolder: RequestPathHolder(
              headerToken: valueHolder.headerToken,
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: valueHolder.languageCode));
        function(provider);
      });
}
