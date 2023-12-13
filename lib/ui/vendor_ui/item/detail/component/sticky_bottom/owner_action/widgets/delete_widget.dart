import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../config/route/route_paths.dart';
import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/user_delete_item_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../../common/ps_button_widget.dart';

class DeleteItemWidget extends StatefulWidget {
  @override
  DeleteItemWidgetState<DeleteItemWidget> createState() =>
      DeleteItemWidgetState<DeleteItemWidget>();
}

class DeleteItemWidgetState<T extends DeleteItemWidget>
    extends State<DeleteItemWidget> {
  late ItemDetailProvider provider;
  late Product product;
  late PsValueHolder psValueHolder;
  late AppInfoProvider appInfoProvider;
  // bool showDeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemDetailProvider>(context);
    appInfoProvider = Provider.of<AppInfoProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    product = provider.product;
    // showDeleteIcon = product.isSoldOutItem ||
        // (product.isItemPromotable && !appInfoProvider.isAllPaymentDisable);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: PsDimens.space16),
      child: PSButtonWithIconWidget(
        width: PsDimens.space40,
        hasShadow: false,
        colorData: Theme.of(context).primaryColor,
        iconColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
        textColor: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800,
        icon: Icons.delete,
        onPressed: () {
          onDeleteItem();
        },
      ),
    );
  }

  Future<void> onDeleteItem() async {
    final AppLocalization langProvider =
        Provider.of<AppLocalization>(context, listen: false);
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogView(
              title: 'Confirmation'.tr,
              description: 'item_detail__delete_desc'.tr,
              leftButtonText: 'dialog__cancel'.tr,
              rightButtonText: 'logout_dialog__confirm'.tr,
              onAgreeTap: () async {
                final UserDeleteItemParameterHolder
                    userDeleteItemParameterHolder =
                    UserDeleteItemParameterHolder(
                  itemId: provider.product.id,
                );
                await PsProgressDialog.showDialog(context);
                final PsResource<ApiStatus> _apiStatus =
                    await provider.userDeleteItem(
                        userDeleteItemParameterHolder.toMap(),
                        psValueHolder.loginUserId!,
                        langProvider.currentLocale.languageCode,
                        provider.product.id!);
                PsProgressDialog.dismissDialog();
                if (_apiStatus.status == PsStatus.SUCCESS) {
                  await provider.deleteLocalProductCacheById(
                      provider.product.id, psValueHolder.loginUserId);
                  Fluttertoast.showToast(
                      msg: _apiStatus.data?.message ?? 'Item Deleted',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PsColors.accent300,
                      textColor: PsColors.achromatic700);
                  // Navigator.pop(context, true);
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.home,
                  );
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: _apiStatus.message != ''
                          ? _apiStatus.message
                          : 'Item is not Deleted',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: PsColors.accent300,
                      textColor: PsColors.achromatic700);
                }
              });
        });
  }
}
