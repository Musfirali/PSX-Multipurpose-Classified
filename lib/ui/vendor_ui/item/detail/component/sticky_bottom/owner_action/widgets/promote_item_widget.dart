import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../common/dialog/choose_payment_type_dialog.dart';
import '../../../../../../common/ps_button_widget.dart';

class PromoteItemWidget extends StatefulWidget {
  @override
  PromoteItemWidgetState<PromoteItemWidget> createState() =>
      PromoteItemWidgetState<PromoteItemWidget>();
}

class PromoteItemWidgetState<T extends PromoteItemWidget>
    extends State<PromoteItemWidget> {
  late AppInfoProvider appInfoprovider;
  late ItemDetailProvider provider;
  late PsValueHolder psValueHolder;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemDetailProvider>(context);
    appInfoprovider = Provider.of<AppInfoProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    return Expanded(
      child: Container(
        margin: Directionality.of(context) == TextDirection.rtl
            ? const EdgeInsets.only(left: PsDimens.space16)
            : const EdgeInsets.only(right: PsDimens.space16),
        child: PSButtonWithIconWidget(
          hasShadow: false,
          textColor: Utils.isLightMode(context)
              ? PsColors.achromatic50
              : PsColors.achromatic800,
          width: MediaQuery.of(context).size.width,
          colorData: Theme.of(context).primaryColor,
          titleText: 'item_detail__promte'.tr,
          onPressed: () {
            onPromoteItem();
          },
        ),
      ),
    );
  }

  Future<void> onPromoteItem() async {
    //only iap is available
    if (appInfoprovider.isIAPEnable &&
        !appInfoprovider.isStripeEnabled &&
        !appInfoprovider.isPaypalEnabled &&
        !appInfoprovider.isPayStackEnabled &&
        !appInfoprovider.isRazorPaymentEnabled &&
        !appInfoprovider.isOfflinePaymentEnabled) {
      onInAppPurchaseTap();
    }
    //iap is not available and some of other payments available
    else if (!appInfoprovider.isIAPEnable &&
        (appInfoprovider.isStripeEnabled ||
            appInfoprovider.isPaypalEnabled ||
            appInfoprovider.isPayStackEnabled ||
            appInfoprovider.isRazorPaymentEnabled ||
            appInfoprovider.isOfflinePaymentEnabled)) {
      onOtherPaymentTap();
    } else {
      showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ChoosePaymentTypeDialog(
              onInAppPurchaseTap: onInAppPurchaseTap,
              onOtherPaymentTap: onOtherPaymentTap,
            );
          });
    }
  }

  Future<void> onInAppPurchaseTap() async {
    final dynamic returnData = await Navigator.pushNamed(
        context, RoutePaths.inAppPurchase, arguments: <String, dynamic>{
      'productId': provider.product.id,
      'appInfo': appInfoprovider.appInfo.data
    });
    if (returnData == true || returnData == null) {
      final String? loginUserId = Utils.checkUserLoginId(psValueHolder);
      provider.loadData(
          requestPathHolder: RequestPathHolder(
              itemId: provider.product.id, loginUserId: loginUserId));
    }
  }

  Future<void> onOtherPaymentTap() async {
    final dynamic returnData = await Navigator.pushNamed(
        context, RoutePaths.itemPromote,
        arguments: provider.product);
    if (returnData == true || returnData == null) {
      final String? loginUserId = Utils.checkUserLoginId(psValueHolder);
      provider.loadData(
          requestPathHolder: RequestPathHolder(
              itemId: provider.product.id, loginUserId: loginUserId));
    }
  }
}
