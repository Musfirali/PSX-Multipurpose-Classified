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

class RejectedProductProvider extends PsProvider<Product> {
  RejectedProductProvider({
    required ProductRepository? repo,
    this.psValueHolder,
    int limit = 0,
  }) : super(repo, limit, subscriptionType: PsConst.LIST_OBJECT_SUBSCRIPTION);

  PsValueHolder? psValueHolder;
  ProductParameterHolder addedUserParameterHolder =
      ProductParameterHolder().getRejectedItemParameterHolder();

  PsResource<List<Product>> get itemList => super.dataList;
}

SingleChildWidget initRejectedProductProvider(
  BuildContext context, {
  String? userId,
  Widget? widget,
}) {
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  return psInitProvider<RejectedProductProvider>(
      initProvider: () => RejectedProductProvider(
          repo: repo,
          psValueHolder: valueHolder,
          limit: valueHolder.defaultLoadingLimit!),
      onProviderReady: (RejectedProductProvider rejectedProductProvider) {
        rejectedProductProvider.addedUserParameterHolder.mile =
            valueHolder.mile;
        if (rejectedProductProvider.psValueHolder!.loginUserId == null ||
            rejectedProductProvider.psValueHolder!.loginUserId == '') {
          rejectedProductProvider.addedUserParameterHolder.addedUserId = userId;
          rejectedProductProvider.addedUserParameterHolder.status = '3';
          rejectedProductProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  languageCode: valueHolder.languageCode,
                  loginUserId: Utils.checkUserLoginId(valueHolder)),
              requestBodyHolder:
                  rejectedProductProvider.addedUserParameterHolder);
        } else {
          rejectedProductProvider.addedUserParameterHolder.addedUserId =
              rejectedProductProvider.psValueHolder!.loginUserId;
          rejectedProductProvider.addedUserParameterHolder.status = '3';
          rejectedProductProvider.loadDataList(
              requestPathHolder: RequestPathHolder(
                  languageCode: valueHolder.languageCode,
                  loginUserId: Utils.checkUserLoginId(valueHolder)),
              requestBodyHolder:
                  rejectedProductProvider.addedUserParameterHolder);
        }

        return rejectedProductProvider;
      });
}
