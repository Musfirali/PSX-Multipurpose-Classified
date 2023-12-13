import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/entry_discount_widget.dart';

class CustomEntryDiscountWidget extends StatelessWidget {
  const CustomEntryDiscountWidget(
      {required this.userInputDiscount, required this.isMandatory});
  final TextEditingController userInputDiscount;
  final bool isMandatory;
  @override
  Widget build(BuildContext context) {
    return EntryDiscountWidget(
        userInputDiscount: userInputDiscount, isMandatory: isMandatory);
  }
}
