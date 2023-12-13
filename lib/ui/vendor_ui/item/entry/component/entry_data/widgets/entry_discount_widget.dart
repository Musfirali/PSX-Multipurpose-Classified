import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../common/ps_textfield_widget.dart';

class EntryDiscountWidget extends StatelessWidget {
  const EntryDiscountWidget(
      {required this.userInputDiscount, required this.isMandatory});
  final TextEditingController userInputDiscount;
  final bool isMandatory;
  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidget(
      //  height: 46,
      isStar: isMandatory,
      titleText: 'item_entry__discount_title'.tr,
      textAboutMe: false,
      hintText: 'item_entry__discount_info'.tr,
      textEditingController: userInputDiscount,
      keyboardType: TextInputType.number,
    );
  }
}
