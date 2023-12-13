import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class RecentProductProvider extends PsProvider<Product> {
  RecentProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productRecentParameterHolder =
      ProductParameterHolder().getRecentParameterHolder();
  PsResource<List<Product>> get productList => super.dataList;
}

SingleChildWidget initRecentProductProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<RecentProductProvider>(
      widget: widget,
      initProvider: () {
        return RecentProductProvider(
          repo: repo,
          limit: valueHolder.categoryLoadingLimit!,
        );
      },
      onProviderReady: (RecentProductProvider provider) {
        provider.productRecentParameterHolder.mile = valueHolder.mile;
        provider.productRecentParameterHolder.itemLocationId =
            valueHolder.locationId;
        provider.productRecentParameterHolder.itemLocationName =
            valueHolder.locactionName;
        if (valueHolder.isSubLocation == PsConst.ONE) {
          provider.productRecentParameterHolder.itemLocationTownshipId =
              valueHolder.locationTownshipId;
          provider.productRecentParameterHolder.itemLocationTownshipName =
              valueHolder.locationTownshipName;
        }
        provider.loadDataList(
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(valueHolder),
              languageCode: valueHolder.languageCode),
          requestBodyHolder: provider.productRecentParameterHolder,
        );
        function(provider);
      });
}
