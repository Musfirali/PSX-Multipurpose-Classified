import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:psxmpc/core/vendor/provider/common/ps_init_provider.dart';
import 'package:psxmpc/core/vendor/utils/utils.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/request_path_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/touch_count_parameter_holder.dart';

import '../../constant/ps_constants.dart';
import '../../repository/product_repository.dart';
import '../../viewobject/api_status.dart';
import '../../viewobject/common/ps_value_holder.dart';
import '../common/ps_provider.dart';

class TouchCountProvider extends PsProvider<ApiStatus> {
  TouchCountProvider(
      {required ProductRepository? repo,
      required this.psValueHolder,
      int limit = 0})
      : super(repo, limit, subscriptionType: PsConst.NO_SUBSCRIPTION);

  PsValueHolder? psValueHolder;
}

SingleChildWidget initTouchCountProvider(
  BuildContext context,
  Function function, {
  Widget? widget,
  required String productId,
}) {
  final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
  final ProductRepository repo = Provider.of<ProductRepository>(context);
  final String? loginUserId = Utils.checkUserLoginId(valueHolder);

  return psInitProvider<TouchCountProvider>(
      widget: widget,
      initProvider: () =>
          TouchCountProvider(repo: repo, psValueHolder: valueHolder),
      onProviderReady: (TouchCountProvider provider) {
        final TouchCountParameterHolder touchCountParameterHolder =
            TouchCountParameterHolder(typeId: productId, userId: loginUserId, typeName: PsConst.ITEM_TYPE_NAME);
        provider.postData(
            requestBodyHolder: touchCountParameterHolder,
            requestPathHolder: RequestPathHolder(
                loginUserId: loginUserId,
                languageCode: valueHolder.languageCode));
        function(provider);
      });
}
