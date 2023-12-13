import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/component/entry_data/widgets/entry_price_range_widget.dart';

import '../../../../../../../core/vendor/viewobject/core_field.dart';

class CustomEntryPriceRangeWidget extends StatelessWidget {
  const CustomEntryPriceRangeWidget(
      {Key? key,
      required this.currencySymbolController,
      required this.userInputPriceController,
      required this.currencyCoreField,
      required this.priceCoreField})
      : super(key: key);

  final TextEditingController? currencySymbolController;
  final TextEditingController? userInputPriceController;
  final CoreField currencyCoreField;
  final CoreField priceCoreField;

  @override
  Widget build(BuildContext context) {
    return EntryPriceRangeWidget(
        currencySymbolController: currencySymbolController,
        userInputPriceController: userInputPriceController,
        currencyCoreField: currencyCoreField,
        priceCoreField: priceCoreField);
  }
}
