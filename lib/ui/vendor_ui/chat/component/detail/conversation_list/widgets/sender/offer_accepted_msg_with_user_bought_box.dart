import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/make_is_user_bought_parameter_holde.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../../custom_ui/chat/component/detail/conversation_list/widgets/sender/sender_accept_or_rejected_msg.dart';

class OfferAcceptedMsgWithUserBought extends StatelessWidget {
  const OfferAcceptedMsgWithUserBought(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase,
      required this.loginUserId,
      required this.isUserOnline});
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final String? loginUserId;

  final String? isUserOnline;

  @override
  Widget build(BuildContext context) {
    final GetChatHistoryProvider chatHistoryProvider =
        Provider.of<GetChatHistoryProvider>(context);
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context);  
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomSenderAcceptedOrRejectedMessage(
          messageObj: messageObj,
        ),
        if (messageObj.type == PsConst.CHAT_TYPE_ACCEPT)
          InkWell(
            onTap: () async {
              await updateDataToFireBase(
                  messageObj.addedDateTimeStamp,
                  messageObj.id,
                  false,
                  true,
                  messageObj.itemId,
                  messageObj.message,
                  PsConst.CHAT_STATUS_ACCEPT,
                  loginUserId,
                  messageObj.sessionId,
                  PsConst.CHAT_TYPE_TEXT);
              await insertDataToFireBase(
                  '',
                  false,
                  true,
                  false,
                  messageObj.itemId,
                  messageObj.message,
                  PsConst.CHAT_STATUS_IS_USER_BOUGHT,
                  loginUserId,
                  messageObj.sessionId,
                  PsConst.CHAT_TYPE_BOUGHT);
              final MakeIsUserBoughtParameterHolder
                  makeIsUserBoughtParameterHolder =
                  MakeIsUserBoughtParameterHolder(
                itemId: messageObj.itemId,
                buyerUserId: chatHistoryProvider.buyerId,
                sellerUserId: chatHistoryProvider.sellerId,
                isUserOnline: isUserOnline,
              );
              chatHistoryProvider.makeUserBoughtItem(
                  makeIsUserBoughtParameterHolder.toMap(), loginUserId, psValueHolder.headerToken!,langProvider!.currentLocale.languageCode);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: PsDimens.space16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(PsDimens.space4),
                      border: Border.all(
                        color: PsColors.achromatic300
                      ),
                      color: PsColors.text50),
                  padding: const EdgeInsets.all(PsDimens.space12),
                  child: Ink(
                    child: Text(
                      psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT ? 'chat_view__is_user_booked'.tr : 'chat_view__is_user_bought'.tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
          )
        else
          const SizedBox()
      ],
    );
  }
}
