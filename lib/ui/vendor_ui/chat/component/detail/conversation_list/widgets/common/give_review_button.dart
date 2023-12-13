import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../../config/ps_colors.dart';
import '../../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../../core/vendor/provider/chat/get_chat_history_provider.dart';
import '../../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../custom_ui/rating/component/dialog/rating_input_dialog.dart';

class GiveReviewButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GetChatHistoryProvider chatHistoryProvider =
        Provider.of<GetChatHistoryProvider>(context);
    return InkWell(
      onTap: () async {
        Utils.psPrint('Buyer user id : ' + chatHistoryProvider.buyerId);
        Utils.psPrint('Seller user id : ' + chatHistoryProvider.sellerId);
        await showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return CustomRatingInputDialog(
                buyerUserId: chatHistoryProvider.buyerId,
                sellerUserId: chatHistoryProvider.sellerId,
                isEdit: false, //TO change the Title of Dialog
              );
            });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: (MediaQuery.of(context).size.width - 48) / 2,
            height: 45,
            margin: const EdgeInsets.only(
              bottom: PsDimens.space16,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(PsDimens.space4),
                border: Border.all(color: PsColors.achromatic300),
                color: PsColors.text50),
            padding: const EdgeInsets.all(PsDimens.space12),
            child: Ink(
              child: Text(
                'chat_view__give_review_button'.tr,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Utils.isLightMode(context)
                        ? PsColors.text800
                        : Utils.isLightMode(context) ? PsColors.achromatic50 : PsColors.achromatic800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
