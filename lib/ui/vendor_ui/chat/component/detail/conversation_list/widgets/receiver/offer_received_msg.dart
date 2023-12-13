import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/ui/custom_ui/chat/component/detail/conversation_list/widgets/common/chat_price_widget.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class OfferReceivedMsg extends StatelessWidget {
  const OfferReceivedMsg({
    required this.messageObj,
  });
  final Message messageObj;
  @override
  Widget build(BuildContext context) {
    final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);

    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16, bottom: PsDimens.space16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
        ],
      ),
    );
  }
}
