import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/user_block_parameter_holder.dart';
import '../../../../../../core/vendor/viewobject/user.dart';
import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/dialog/warning_dialog_view.dart';

class BlockUserPopUpWidget extends StatefulWidget {
  const BlockUserPopUpWidget();
  @override
  BlockUserPopUpWidgetState<BlockUserPopUpWidget> createState() =>
      BlockUserPopUpWidgetState<BlockUserPopUpWidget>();
}

class BlockUserPopUpWidgetState<T extends BlockUserPopUpWidget>
    extends State<BlockUserPopUpWidget> {
  late ItemDetailProvider itemDetailProvider;
  late PsValueHolder psValueHolder;
  late UserProvider userProvider;
  late String loginUserId;
  late String otherUserId;
  late User currentProduct;
  late AppLocalization langProvider;
  Future<void> _onSelect(String value) async {
    switch (value) {
      case '1':
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return WarningDialog(
              message: 'item_detail__confirm_dialog_block_user'.tr,
              titleText: 'user_detail__block_user'.tr,
              onPressed: () async {
                await PsProgressDialog.showDialog(context);

                final UserBlockParameterHolder userBlockItemParameterHolder =
                    UserBlockParameterHolder(
                        loginUserId: psValueHolder.loginUserId,
                        addedUserId: otherUserId);

                final PsResource<ApiStatus> _apiStatus =
                    await userProvider.blockUser(
                        userBlockItemParameterHolder.toMap(),
                        psValueHolder.loginUserId!,
                        langProvider.currentLocale.languageCode);
                PsProgressDialog.dismissDialog();
                if (_apiStatus.data != null &&
                    _apiStatus.data!.status != null) {
                  await itemDetailProvider.deleteLocalProductCacheByUserId(
                      psValueHolder.loginUserId, otherUserId);
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName(RoutePaths.home));
                } else {
                  Navigator.pop(context);
                  showDialog<dynamic>(
                      context: context,
                      builder: (BuildContext context) {
                        return ErrorDialog(
                          message: _apiStatus.message,
                        );
                      });
                }
              },
            );
          },
        );
        break;
      default:
        print('English');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    itemDetailProvider = Provider.of<ItemDetailProvider>(context);
    psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    langProvider = Provider.of<AppLocalization>(context);
    otherUserId = userProvider.user.data!.userId ?? '';
    loginUserId = Utils.checkUserLoginId(psValueHolder);

    /**UI Section is here */
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space12, right: PsDimens.space12),
        child: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context)
                  .iconTheme
                  .copyWith(color: Theme.of(context).primaryColor)),
          child: PopupMenuButton<String>(
            onSelected: _onSelect,
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: '1',
                  child: Text(
                    'item_detail__block_user'.tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ];
            },
            elevation: 4,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ));
  }
}
