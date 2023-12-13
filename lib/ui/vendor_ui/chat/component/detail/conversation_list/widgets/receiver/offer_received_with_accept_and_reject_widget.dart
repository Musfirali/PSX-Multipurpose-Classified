import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/ui/custom_ui/chat/component/detail/conversation_list/widgets/common/chat_price_widget.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/make_offer_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';
import '../../../../../../common/dialog/confirm_dialog_view.dart';

class OfferReceivedBoxWithAcceptAndRejectWidget extends StatelessWidget {
  const OfferReceivedBoxWithAcceptAndRejectWidget({
    required this.messageObj,
    required this.updateDataToFireBase,
    required this.insertDataToFireBase,
    required this.isUserOnline,
  });
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  final String? isUserOnline;

  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final GetChatHistoryProvider chatHistoryProvider =
        Provider.of<GetChatHistoryProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    MakeOfferParameterHolder makeOfferHolder;
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
              width: PsDimens.space140,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(PsDimens.space16),
                  color: PsColors.info500),
              padding: const EdgeInsets.all(PsDimens.space8),
              child: Column(
                children: <Widget>[
                  Text(
                    psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT ?  'chat_view__receive_book_message.tr' : 'chat_view__receive_offer_message'.tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: PsColors.achromatic50),
                  ),
                  const SizedBox(height: PsDimens.space4),
                   CustomChatPriceWidget(messageObj: messageObj,)
                ],
              ),
            ),
            const SizedBox(
              width: PsDimens.space8,
            ),
            Text(
              Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]),
          const SizedBox(
            height: PsDimens.space16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialogView(
                              description: 'chat_view__reject_description'.tr,
                              leftButtonText:
                                  'chat_view__reject_cancel_button'.tr,
                              rightButtonText: 'chat_view__reject_ok_button'.tr,
                              onAgreeTap: () async {
                                await updateDataToFireBase(
                                    messageObj.addedDateTimeStamp,
                                    messageObj.id,
                                    false,
                                    false,
                                    messageObj.itemId,
                                    messageObj.message,
                                    PsConst.CHAT_STATUS_OFFER,
                                    messageObj.sendByUserId,
                                    messageObj.sessionId,
                                    PsConst.CHAT_TYPE_REJECT);

                                await insertDataToFireBase(
                                    '',
                                    false,
                                    false,
                                    false,
                                    messageObj.itemId,
                                    messageObj.message,
                                    PsConst.CHAT_STATUS_REJECT,
                                    messageObj.sendByUserId,
                                    messageObj.sessionId,
                                    PsConst.CHAT_TYPE_REJECT);
                                makeOfferHolder = MakeOfferParameterHolder(
                                    itemId: messageObj.itemId,
                                    buyerUserId: chatHistoryProvider.buyerId,
                                    sellerUserId: chatHistoryProvider.sellerId,
                                    negoPrice: PsConst.ZERO,
                                    isUserOnline: isUserOnline,
                                    type: PsConst.CHAT_TO_BUYER);
                                await chatHistoryProvider.makeOrRejectOffer(
                                    makeOfferHolder.toMap(),
                                    psValueHolder.loginUserId,
                                    psValueHolder.headerToken!,
                                    langProvider!.currentLocale.languageCode);
                                Navigator.of(context).pop();
                                chatHistoryProvider.loadData(
                                    requestPathHolder: RequestPathHolder(
                                        loginUserId: Utils.checkUserLoginId(
                                            psValueHolder),
                                        headerToken: psValueHolder.headerToken,
                                        languageCode: langProvider
                                            .currentLocale.languageCode),
                                    requestBodyHolder: chatHistoryProvider
                                        .getChatHistoryParameterHolder);
                              });
                        });
                  },
                  child: Container(
                   // height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        border: Border.all(color: PsColors.achromatic200),
                        color: PsColors.text50),
                    padding: const EdgeInsets.all(PsDimens.space12),
                    child: Ink(
                      color: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic800,
                      child: Text(
                        'chat_view__offer_reject_button'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: PsColors.error500),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: PsDimens.space16,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog<dynamic>(
                        context: context,
                        builder: (BuildContext context) {
                          return ConfirmDialogView(
                              description: 'chat_view__accept_description'.tr,
                              leftButtonText:
                                  'chat_view__accept_cancel_button'.tr,
                              rightButtonText: 'chat_view__accept_ok_button'.tr,
                              onAgreeTap: () async {
                                await updateDataToFireBase(
                                    messageObj.addedDateTimeStamp,
                                    messageObj.id,
                                    false,
                                    false,
                                    messageObj.itemId,
                                    messageObj.message,
                                    PsConst.CHAT_STATUS_OFFER,
                                    messageObj.sendByUserId,
                                    messageObj.sessionId,
                                    PsConst.CHAT_TYPE_ACCEPT);

                                await insertDataToFireBase(
                                    '',
                                    false,
                                    false,
                                    false,
                                    messageObj.itemId,
                                    messageObj.message,
                                    PsConst.CHAT_STATUS_ACCEPT,
                                    psValueHolder.loginUserId,
                                    messageObj.sessionId,
                                    PsConst.CHAT_TYPE_ACCEPT);

                                makeOfferHolder = MakeOfferParameterHolder(
                                    itemId: messageObj.itemId,
                                    buyerUserId: chatHistoryProvider.buyerId,
                                    sellerUserId: chatHistoryProvider.sellerId,
                                    isUserOnline: isUserOnline,
                                    negoPrice:
                                        Utils.splitMessage(messageObj.message!),
                                    type: PsConst.CHAT_TO_BUYER);
                                await chatHistoryProvider.acceptOffer(
                                    makeOfferHolder.toMap(),
                                    psValueHolder.loginUserId,
                                    psValueHolder.headerToken!,
                                    langProvider!.currentLocale.languageCode);
                                Navigator.of(context).pop();
                                chatHistoryProvider.loadData(
                                    requestPathHolder: RequestPathHolder(
                                        loginUserId: Utils.checkUserLoginId(
                                            psValueHolder),
                                        headerToken: psValueHolder.headerToken,
                                        languageCode: langProvider
                                            .currentLocale.languageCode),
                                    requestBodyHolder: chatHistoryProvider
                                        .getChatHistoryParameterHolder);
                              });
                        });
                  },
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(PsDimens.space4),
                        color: PsColors.phoneColor),
                    padding: const EdgeInsets.all(PsDimens.space12),
                    child: Ink(
                      color: Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
                      child: Text(
                        'chat_view__offer_accept_button'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: PsColors.achromatic50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
