import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class ItemHasBeenBoughtMsg extends StatelessWidget {
  const ItemHasBeenBoughtMsg({
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
          bottom: PsDimens.space16),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        Text(
          Utils.convertTimeStampToTime(messageObj.addedDateTimeStamp),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          width: PsDimens.space8,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PsDimens.space16),
              color: PsColors.info500),
          padding: const EdgeInsets.all(PsDimens.space12),
          child: Text(
           psValueHolder.selectChatType == PsConst.CHAT_AND_APPOINTMENT ? 'chat_view__user_booked_message'.tr : 'chat_view__user_bought_message'.tr,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: PsColors.achromatic50),
          ),
        )
      ]),
    );
  }
}
