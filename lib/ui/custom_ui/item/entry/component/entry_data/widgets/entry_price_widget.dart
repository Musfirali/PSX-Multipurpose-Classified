import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/core_field.dart';
import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/entry_price_widget.dart';

class CustomEntryPriceWidget extends StatelessWidget {
  const CustomEntryPriceWidget(
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
    return EntryPriceWidget(
        currencySymbolController: currencySymbolController,
        userInputPriceController: userInputPriceController,
        currencyCoreField: currencyCoreField,
        priceCoreField: priceCoreField);
  }
}
