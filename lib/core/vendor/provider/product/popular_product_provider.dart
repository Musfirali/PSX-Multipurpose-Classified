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

class PopularProductProvider extends PsProvider<Product> {
  PopularProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productPopularParameterHolder =
      ProductParameterHolder().getPopularParameterHolder();
  PsResource<List<Product>> get productList => super.dataList;
}

SingleChildWidget initPopularProductProvider(
    BuildContext context, Function function,
    {Widget? widget}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  return psInitProvider<PopularProductProvider>(
      widget: widget,
      initProvider: () {
        return PopularProductProvider(
          repo: repo,
          limit: valueHolder.populartItemLoadingLimit!,
        );
      },
      onProviderReady: (PopularProductProvider provider) {
        provider.productPopularParameterHolder.mile = valueHolder.mile;
        provider.productPopularParameterHolder.itemLocationId =
            valueHolder.locationId;
        provider.productPopularParameterHolder.itemLocationName =
            valueHolder.locactionName;
        if (valueHolder.isSubLocation == PsConst.ONE) {
          provider.productPopularParameterHolder.itemLocationTownshipId =
              valueHolder.locationTownshipId;
          provider.productPopularParameterHolder.itemLocationTownshipName =
              valueHolder.locationTownshipName;
        }
        final String? loginUserId = Utils.checkUserLoginId(valueHolder);
        provider.loadDataList(
          requestPathHolder: RequestPathHolder(
              loginUserId: loginUserId, languageCode: valueHolder.languageCode),
          requestBodyHolder: provider.productPopularParameterHolder,
        );
        function(provider);
      });
}
