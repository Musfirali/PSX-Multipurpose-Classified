import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/mark_sold_out_item_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/mark_sold_out_item_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../../common/ps_button_widget.dart';

class MarkAsSoldWidget extends StatefulWidget {
  @override
  MarkAsSoldWidgetState<MarkAsSoldWidget> createState() =>
      MarkAsSoldWidgetState<MarkAsSoldWidget>();
}

class MarkAsSoldWidgetState<T extends MarkAsSoldWidget>
    extends State<MarkAsSoldWidget> {
  late ItemDetailProvider provider;
  late MarkSoldOutItemProvider? _markSoldOutItemProvider;
  late PsValueHolder psValueHolder;
  late MarkSoldOutItemParameterHolder markSoldOutItemHolder;
  late Product product;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemDetailProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    product = provider.product;
    markSoldOutItemHolder =
        MarkSoldOutItemParameterHolder().markSoldOutItemHolder();
    markSoldOutItemHolder.itemId = product.id;
    return Consumer<MarkSoldOutItemProvider>(builder: (BuildContext context,
        MarkSoldOutItemProvider markSoldOutItemProvider, Widget? child) {
      _markSoldOutItemProvider = markSoldOutItemProvider;
      if (_markSoldOutItemProvider != null) {
        return Expanded(
          child: Container(
            margin: Directionality.of(context) == TextDirection.rtl ? const EdgeInsets.only(left: PsDimens.space16) : const EdgeInsets.only(right: PsDimens.space16),
            child: PSButtonWithIconWidget(
              hasShadow: false,
              width: MediaQuery.of(context).size.width,
              colorData: Theme.of(context).primaryColor,
              titleText: 'item_detail__mark_sold'.tr,
              textColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
              onPressed: () {
                onMarkAsSoldItem();
              },
            ),
          ),
        );
      } else
        return const SizedBox();
    });
  }

  Future<void> onMarkAsSoldItem() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogView(
              title: 'Confirmation'.tr,
              description: 'item_detail__sold_out_item'.tr,
              leftButtonText: 'item_detail__sold_out_dialog_cancel_button'.tr,
              rightButtonText: 'logout_dialog__confirm'.tr,
              onAgreeTap: () async {
                await PsProgressDialog.showDialog(context);
                await _markSoldOutItemProvider!.loadmarkSoldOutItem(
                    loginUserId: psValueHolder.loginUserId,
                    headerToken: psValueHolder.headerToken,
                    languageCode: langProvider.currentLocale.languageCode,
                    holder: markSoldOutItemHolder);
                PsProgressDialog.dismissDialog();
                if (_markSoldOutItemProvider!.markSoldOutItem.data != null) {
                  provider.product.isSoldOut =
                      _markSoldOutItemProvider!.markSoldOutItem.data!.isSoldOut;
                }
                await provider.loadData(
                    requestPathHolder: RequestPathHolder(
                        itemId: product.id,
                        loginUserId: Utils.checkUserLoginId(psValueHolder)));
                Navigator.of(context).pop();
              });
        });
  }
}
