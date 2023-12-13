import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class ReceiverAcceptedOrRejectedMsg extends StatelessWidget {
  const ReceiverAcceptedOrRejectedMsg({
    required this.messageObj,
  });
  final Message messageObj;

  @override
  Widget build(BuildContext context) {
        final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(
        left: PsDimens.space16,
        right: PsDimens.space16,
        bottom: PsDimens.space16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PsDimens.space16),
                color: messageObj.offerStatus == PsConst.CHAT_STATUS_ACCEPT
                    ? PsColors.success500
                    : PsColors.error500),
            padding: const EdgeInsets.all(PsDimens.space12),
            child: Text(
              messageObj.offerStatus == PsConst.CHAT_STATUS_ACCEPT
                  ? psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT ? 'chat_view__accept_book_message'.tr :'chat_view__accept_offer_message'.tr
                  :  psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT ? 'chat_view__reject_book_message'.tr : 'chat_view__reject_offer_message'.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: PsColors.achromatic50),
            ),
          ),
          const SizedBox(
            width: PsDimens.space8,
          ),
          Text(
            Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
