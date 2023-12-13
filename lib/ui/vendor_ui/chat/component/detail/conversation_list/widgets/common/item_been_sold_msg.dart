import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../../core/vendor/viewobject/message.dart';

class ItemHasBeenSoldMsg extends StatelessWidget {
  const ItemHasBeenSoldMsg({
    required this.messageObj,
  });
  final Message messageObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: PsDimens.space16,
          right: PsDimens.space16,
          bottom: PsDimens.space16),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                    color: Theme.of(context).primaryColor),
                padding: const EdgeInsets.all(PsDimens.space12),
                child: Text(
                  'chat_view__mark_as_sold_message'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: PsColors.achromatic50),
                ))
          ]),
    );
  }
}
