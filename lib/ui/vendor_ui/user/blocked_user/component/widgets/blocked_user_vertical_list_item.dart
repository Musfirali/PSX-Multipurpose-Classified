import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../core/vendor/provider/user/blocked_user_provider.dart';
import '../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../core/vendor/utils/ps_progress_dialog.dart';
import '../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../core/vendor/viewobject/blocked_user.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/user_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../core/vendor/viewobject/holder/unblock_user_holder.dart';
import '../../../../common/bluemark_icon.dart';
import '../../../../common/dialog/confirm_dialog_view.dart';
import '../../../../common/ps_ui_widget.dart';
import '../../../../common/smooth_star_rating_widget.dart';

class BlockedUserVerticalListItem extends StatelessWidget {
  const BlockedUserVerticalListItem(
      {Key? key,
      required this.blockedUser,
      this.animationController,
      this.animation})
      : super(key: key);

  final BlockedUser blockedUser;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    final AppLocalization langProvider = Provider.of<AppLocalization>(context);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final BlockedUserProvider blockedUserProvider =
        Provider.of<BlockedUserProvider>(context, listen: false);
    return AnimatedBuilder(
        animation: animationController!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(
              bottom: PsDimens.space16,
              left: PsDimens.space16,
              right: PsDimens.space16),
          child: InkWell(
            onTap: () {
              onTap(context);
            },
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Utils.isLightMode(context)
                    ? PsColors.achromatic50
                    : PsColors.achromatic400,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: PsColors.achromatic500.withOpacity(0.3),
                    spreadRadius: 0.05,
                    blurRadius: 0.05,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
                borderRadius:
                    const BorderRadius.all(Radius.circular(PsDimens.space8)),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: PsDimens.space16, vertical: PsDimens.space8),
              child: Row(
                children: <Widget>[
                  Container(
                    width: PsDimens.space48,
                    height: PsDimens.space48,
                    child: PsNetworkCircleImageForUser(
                      photoKey: '',
                      imagePath: blockedUser.userCoverPhoto ?? '',
                      boxfit: BoxFit.cover,
                      onTap: () {
                        onTap(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: PsDimens.space16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: blockedUser.userAddress == ''
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                  blockedUser.userName == ''
                                      ? 'default__user_name'.tr
                                      : blockedUser.userName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          fontSize: 14,
                                          color: Utils.isLightMode(context)
                                              ? PsColors.text800 : PsColors.text50,
                                          fontWeight: FontWeight.w600)),
                            ),
                            if (blockedUser.isVefifiedBlueMarkUser)
                              const BluemarkIcon()
                          ],
                        ),
                        if (blockedUser.userAddress != '')
                          Text(blockedUser.userAddress ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontSize: 12,
                                      color: Utils.isLightMode(context)
                                          ? PsColors.text800 : PsColors.text50,
                                      fontWeight: FontWeight.w400))
                        else
                          const SizedBox(height: PsDimens.space2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(blockedUser.overallRating ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 14)),
                            if (blockedUser.overallRating != '')
                              SmoothStarRating(
                                  key: Key(blockedUser.overallRating!),
                                  rating: double.parse(
                                      blockedUser.overallRating ?? ''),
                                  allowHalfRating: false,
                                  isReadOnly: true,
                                  starCount: 1,
                                  size: PsDimens.space20,
                                  color: PsColors.warning500,
                                  borderColor: PsColors.warning500,
                                  onRated: (double? v) async {},
                                  spacing: 0.0),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: PsDimens.space16,
                  ),
                  SizedBox(
                    width: 88,
                    child: MaterialButton(
                        color: Theme.of(context).primaryColor,
                        height: PsDimens.space40,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(PsDimens.space8)),
                        ),
                        child: Text(
                          'chat_view__unblock'.tr,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: PsColors.text50),
                        ),
                        onPressed: () {
                          showDialog<dynamic>(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialogView(
                                    description:
                                        'blocked_user__unblock_confirm'.tr,
                                    leftButtonText: 'dialog__cancel'.tr,
                                    rightButtonText: 'dialog__ok'.tr,
                                    onAgreeTap: () async {
                                      Navigator.of(context).pop();

                                      onUnblockTap(context, userProvider,
                                          blockedUserProvider, langProvider);
                                    });
                              });
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 100 * (1.0 - animation!.value), 0.0),
                  child: child));
        });
  }

  void onTap(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final BlockedUserProvider provider =
        Provider.of<BlockedUserProvider>(context, listen: false);

    Navigator.pushNamed(context, RoutePaths.userDetail,
            arguments: UserIntentHolder(
                userId: blockedUser.userId, userName: blockedUser.userName))
        .then((Object? value) {
      provider.loadDataList(
          requestPathHolder:
              RequestPathHolder(loginUserId: psValueHolder.loginUserId));
    });
  }

  Future<void> onUnblockTap(
      BuildContext context,
      UserProvider userProvider,
      BlockedUserProvider blockedUserProvider,
      AppLocalization langProvider) async {
    await PsProgressDialog.showDialog(context);

    final UnblockUserHolder userBlockItemParameterHolder = UnblockUserHolder(
        fromBlockUserId: userProvider.psValueHolder!.loginUserId,
        toBlockUserId: blockedUser.userId);

    final PsResource<ApiStatus> _apiStatus = await userProvider.postUnBlockUser(
        userBlockItemParameterHolder.toMap(),
        userProvider.psValueHolder!.loginUserId!,
        langProvider.currentLocale.languageCode);

    PsProgressDialog.dismissDialog();
    if (_apiStatus.status == PsStatus.SUCCESS) {
      blockedUserProvider.deleteUserFromDB(blockedUser.userId);
    }
  }
}
