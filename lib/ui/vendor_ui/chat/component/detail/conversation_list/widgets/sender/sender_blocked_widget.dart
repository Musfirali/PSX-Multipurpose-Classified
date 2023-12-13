import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../../core/vendor/api/common/ps_resource.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/provider/user/blocked_user_provider.dart';
import '../../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../../core/vendor/viewobject/api_status.dart';
import '../../../../../../../../core/vendor/viewobject/holder/unblock_user_holder.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../common/ps_button_widget_with_round_corner.dart';

class SenderBlockedWidget extends StatelessWidget {
  const SenderBlockedWidget({
    required this.messageObj,
    required this.updateDataToFireBase,
    required this.otherUserId,
  });
  final Message messageObj;
  final Function updateDataToFireBase;
  final String otherUserId;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final BlockedUserProvider blockedUserProvider =
        Provider.of<BlockedUserProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
            width: double.infinity,
            height: PsDimens.space68,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.all(PsDimens.space12),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.lock,
                    color: PsColors.achromatic50,
                    size: 22,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: PsDimens.space4, right: PsDimens.space6),
                      child: Text(
                        'chat_view__sender_block_user'.tr,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: PsColors.achromatic50),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  PSButtonWidgetRoundCorner(
                      colorData: PsColors.achromatic50,
                      titleTextColor: PsColors.achromatic900,
                      hasShadow: false,
                      width: 100,
                      titleText: 'chat_view__unblock'.tr,
                      onPressed: () async {
                        final UnblockUserHolder userBlockItemParameterHolder =
                            UnblockUserHolder(
                                fromBlockUserId:
                                    userProvider.psValueHolder!.loginUserId,
                                toBlockUserId: otherUserId);

                        final PsResource<ApiStatus> _apiStatus =
                            await userProvider.postUnBlockUser(
                                userBlockItemParameterHolder.toMap(),
                                userProvider.psValueHolder!.loginUserId!,
                                langProvider!.currentLocale.languageCode);

                        if (_apiStatus.data != null) {
                          userProvider.userParameterHolder.loginUserId =
                              userProvider.psValueHolder!.loginUserId;
                          userProvider.userParameterHolder.id = otherUserId;

                          await userProvider.getOtherUserData(
                              userProvider.userParameterHolder.toMap(),
                              userProvider.userParameterHolder.id,
                              langProvider.currentLocale.languageCode);

                          await updateDataToFireBase(
                              messageObj.addedDateTimeStamp,
                              messageObj.id,
                              false,
                              false,
                              messageObj.itemId,
                              messageObj.message,
                              PsConst.CHAT_STATUS_IS_UNBLOCKED,
                              messageObj.sendByUserId,
                              messageObj.sessionId,
                              PsConst.CHAT_TYPE_IS_UNBLOCKED);

                          await blockedUserProvider.deleteUserFromDB(
                              userProvider.psValueHolder!.loginUserId);
                        }
                      }),
                ],
              ),
            )));
  }
}
