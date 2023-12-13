import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/constant/ps_constants.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';
import 'package:psxmpc/core/vendor/viewobject/product.dart';
import 'package:psxmpc/core/vendor/viewobject/user_relation.dart';
import 'package:psxmpc/ui/custom_ui/item/detail/component/sticky_bottom/other_user_action/widgets/whatsapp_widget.dart';

import '../../../../../../../core/vendor/provider/product/product_provider.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/other_user_action/widgets/call_widget.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/other_user_action/widgets/chat_widget.dart';
import '../../../../../../custom_ui/item/detail/component/sticky_bottom/other_user_action/widgets/sms_widget.dart';

class OtherUserActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final PsValueHolder psValueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final ItemDetailProvider provider =
        Provider.of<ItemDetailProvider>(context);
         final Product product = provider.product;
              const String userWhatsapp = 'ps-usr00012';
          final int index = product.user!.userRelation!.indexWhere(
              (UserRelation element) =>
                  element.coreKeyId == userWhatsapp);
          final bool showUserWhatsapp = index >= 0 &&
              product.user!.userRelation
                      ?.elementAt(index)
                      .selectedValues?[0]
                      .value !=
                  '';
    return Container(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (provider.productOwner != null && provider.productOwner!.showPhone && (provider.productOwner!.hasPhone || provider.product.phoneNumList != ''))
            CustomPhoneCallWidget(),
          if (provider.productOwner != null && provider.productOwner!.showPhone && (provider.productOwner!.hasPhone || provider.product.phoneNumList != ''))
            CustomSMSWidget(),
          if(showUserWhatsapp)
            CustomWhatsAppWidget(),
          if(psValueHolder.selectChatType != PsConst.NO_CHAT)
          CustomChatWidget()
        ],
      ),
    );
  }
}
