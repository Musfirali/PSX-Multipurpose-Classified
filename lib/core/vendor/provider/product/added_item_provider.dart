import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';

import '../../api/common/ps_resource.dart';
import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../../viewobject/holder/product_parameter_holder.dart';
import '../../viewobject/product.dart';
import '../common/ps_provider.dart';

class AddedItemProvider extends PsProvider<Product> {
  AddedItemProvider({
    required ProductRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);
  PsValueHolder? psValueHolder;
  ProductParameterHolder addedUserParameterHolder =
      ProductParameterHolder().getLatestParameterHolder();
  PsResource<List<Product>> get itemList => super.dataList;
}

SingleChildWidget initAddedItemProvider(
  BuildContext context, {
  String? userId,
  Widget? widget,
}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<AddedItemProvider>(
      initProvider: () => AddedItemProvider(
          repo: repo,
          psValueHolder: valueHolder,
          limit: valueHolder.defaultLoadingLimit!),
      onProviderReady: (AddedItemProvider productProvider) {
        productProvider.addedUserParameterHolder.mile = valueHolder.mile;
        if (productProvider.psValueHolder!.loginUserId == null ||
            productProvider.psValueHolder!.loginUserId == '') {
          productProvider.addedUserParameterHolder.addedUserId = userId;
          productProvider.addedUserParameterHolder.status = '1';
          productProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  languageCode: valueHolder.languageCode,
                  loginUserId: Utils.checkUserLoginId(valueHolder)),
              requestBodyHolder: productProvider.addedUserParameterHolder);
        } else {
          productProvider.addedUserParameterHolder.addedUserId =
              productProvider.psValueHolder!.loginUserId;
          productProvider.addedUserParameterHolder.status = '1';
          productProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  languageCode: valueHolder.languageCode,
                  loginUserId: Utils.checkUserLoginId(valueHolder)),
              requestBodyHolder: productProvider.addedUserParameterHolder);
        }
        return productProvider;
      });
}
