import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/holder/make_mark_as_sold_parameter_holder.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class MarkAsSoldButton extends StatelessWidget {
  const MarkAsSoldButton(
      {required this.messageObj,
      required this.updateDataToFireBase,
      required this.insertDataToFireBase});
  final Message messageObj;
  final Function updateDataToFireBase;
  final Function insertDataToFireBase;
  
  
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder = Provider.of<PsValueHolder>(context, listen: false);
    final GetChatHistoryProvider chatHistoryProvider = Provider.of<GetChatHistoryProvider>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    MakeMarkAsSoldParameterHolder makeMarkAsSoldHolder;
    return InkWell(
      onTap: () async {
        await updateDataToFireBase(
            messageObj.addedDateTimeStamp,
            messageObj.id,
            true,
            true,
            messageObj.itemId,
            messageObj.message,
            PsConst.CHAT_STATUS_ACCEPT,
            psValueHolder.loginUserId,
            messageObj.sessionId,
            PsConst.CHAT_TYPE_TEXT);

        await insertDataToFireBase(
            '',
            true,
            true,
            false,
            messageObj.itemId,
            messageObj.message,
            PsConst.CHAT_STATUS_SOLD,
            psValueHolder.loginUserId,
            messageObj.sessionId,
            PsConst.CHAT_TYPE_SOLD);

        makeMarkAsSoldHolder = MakeMarkAsSoldParameterHolder(
          itemId: messageObj.itemId,
          buyerUserId: chatHistoryProvider.buyerId,
          sellerUserId: chatHistoryProvider.sellerId,
        );
        chatHistoryProvider.makeMarkAsSoldItem(
            psValueHolder.loginUserId, psValueHolder.headerToken!, makeMarkAsSoldHolder,langProvider!.currentLocale.languageCode);
      },
      child: Container(
       height: 45,
        width: (MediaQuery.of(context).size.width - 48) / 2,
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            bottom: PsDimens.space16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PsDimens.space4),
            color: Theme.of(context).primaryColor),
        padding: const EdgeInsets.all(PsDimens.space12),
        child: Ink(
          child: Text(
            'Sold Out',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
          ),
        ),
      ),
    );
  }
}
