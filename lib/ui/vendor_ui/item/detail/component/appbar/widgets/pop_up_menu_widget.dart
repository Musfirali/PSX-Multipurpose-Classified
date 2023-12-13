import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/user_block_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/holder/user_report_item_parameter_holder.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../../common/dialog/error_dialog.dart';

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget();
  @override
  PopUpMenuWidgetState<PopUpMenuWidget> createState() =>
      PopUpMenuWidgetState<PopUpMenuWidget>();
}

class PopUpMenuWidgetState<T extends PopUpMenuWidget>
    extends State<PopUpMenuWidget> {
  late ItemDetailProvider itemDetailProvider;
  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  late String loginUserId;
  late Product currentProduct;
  late AppLocalization langProvider;
  Future<void> _onSelect(String value) async {
    switch (value) {
      case '1':
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
                description: 'item_detail__confirm_dialog_report_item'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  await PsProgressDialog.showDialog(context);

                  final UserReportItemParameterHolder
                      userReportItemParameterHolder =
                      UserReportItemParameterHolder(
                          itemId: currentProduct.id,
                          reportedUserId:
                              Utils.checkUserLoginId(psValueHolder));

                  final PsResource<ApiStatus> _apiStatus =
                      await userProvider.userReportItem(
                          userReportItemParameterHolder.toMap(),
                          Utils.checkUserLoginId(psValueHolder));

                  if (_apiStatus.status == PsStatus.SUCCESS) {
                    await itemDetailProvider.deleteLocalProductCacheById(
                        currentProduct.id,
                        Utils.checkUserLoginId(psValueHolder));
                    PsProgressDialog.dismissDialog();
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(RoutePaths.home));
                  } else {
                    Navigator.pop(context);
                    PsProgressDialog.dismissDialog();
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ErrorDialog(message: _apiStatus.message);
                        });
                  }
                });
          },
        );

        break;

      case '2':
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ConfirmDialogView(
                description: 'item_detail__confirm_dialog_block_user'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'dialog__ok'.tr,
                onAgreeTap: () async {
                  await PsProgressDialog.showDialog(context);

                  final UserBlockParameterHolder userBlockItemParameterHolder =
                      UserBlockParameterHolder(
                          loginUserId: loginUserId,
                          addedUserId: currentProduct.addedUserId);

                  final PsResource<ApiStatus> _apiStatus =
                      await userProvider.blockUser(
                          userBlockItemParameterHolder.toMap(),
                          loginUserId,
                          langProvider.currentLocale.languageCode);
                  if (_apiStatus.data != null &&
                      _apiStatus.data!.status != null) {
                    await itemDetailProvider.deleteLocalProductCacheByUserId(
                        loginUserId, currentProduct.addedUserId);
                  }

                  PsProgressDialog.dismissDialog();

                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(RoutePaths.home));
                });
          },
        );
        break;

      case '3':
        final Size size = MediaQuery.of(context).size;
        if (currentProduct.dynamicLink != null) {
          Share.share(
            'Go to App:\n' + currentProduct.dynamicLink!,
            sharePositionOrigin:
                Rect.fromLTWH(0, 0, size.width, size.height / 2),
          );
        }
        break;
      default:
        print('English');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    currentProduct = itemDetailProvider.product;
    loginUserId = Utils.checkUserLoginId(psValueHolder);

    /**UI Section is here */
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space12, right: PsDimens.space12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: PsColors.achromatic900.withAlpha(100),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
              iconTheme:
                  Theme.of(context).iconTheme.copyWith(color: PsColors.achromatic50)),
          child: PopupMenuButton<String>(
            onSelected: _onSelect,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                if (!Utils.isOwnerItem(psValueHolder, currentProduct))
                  PopupMenuItem<String>(
                    value: '1',
                    child: Text(
                      'item_detail__report_item'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                if (!Utils.isOwnerItem(psValueHolder, currentProduct))
                  PopupMenuItem<String>(
                    value: '2',
                    child: Text(
                      'item_detail__block_user'.tr,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                PopupMenuItem<String>(
                  value: '3',
                  child: Text('item_detail__share'.tr,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ];
            },
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ));
  }
}
