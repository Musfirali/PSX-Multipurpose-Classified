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

class DiscountProductProvider extends PsProvider<Product> {
  DiscountProductProvider({
    required ProductRepository repo,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  final ProductParameterHolder productDiscountParameterHolder =
      ProductParameterHolder().getDiscountParameterHolder();

  PsResource<List<Product>> get productList => super.dataList;
}

SingleChildWidget initDiscountProductProvider(
    BuildContext context, Function function,
    {Widget? widget}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  // final AppLocalization langProvider = Provider.of<AppLocalization>(context);
  
    return psInitProvider<DiscountProductProvider>(
        widget: widget,
        initProvider: () {
          return DiscountProductProvider(
            repo: repo,
            limit: valueHolder.discountItemLoadingLimit!,
          );
        },
        onProviderReady: (DiscountProductProvider provider) {
          provider.productDiscountParameterHolder.mile = valueHolder.mile;
          provider.productDiscountParameterHolder.itemLocationId =
              valueHolder.locationId;
          provider.productDiscountParameterHolder.itemLocationName =
              valueHolder.locactionName;
          if (valueHolder.isSubLocation == PsConst.ONE) {
            provider.productDiscountParameterHolder.itemLocationTownshipId =
                valueHolder.locationTownshipId;
            provider.productDiscountParameterHolder.itemLocationTownshipName =
                valueHolder.locationTownshipName;
          }
          if (valueHolder.isShowDiscount!)
          provider.loadDataList(
            requestPathHolder: RequestPathHolder(
                loginUserId: Utils.checkUserLoginId(valueHolder),
                languageCode: valueHolder.languageCode),
            requestBodyHolder: provider.productDiscountParameterHolder,
          );
          function(provider);
        });
  // ignore: always_specify_types
  // return ChangeNotifierProvider(
  //   create: (BuildContext context) {},
  // );
}
