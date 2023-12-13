import 'package:flutter/widgets.dart';

import '../../../../../vendor_ui/item/list_with_filter/components/filter/filter_view.dart';

class CustomFilterView extends StatelessWidget {
  const CustomFilterView({
    Key? key,
    required this.minPriceTextController,
    required this.maxPriceTextController,
    required this.handleApply,
    required this.handleReset,
  }) : super(key: key);
  final TextEditingController minPriceTextController;
  final TextEditingController maxPriceTextController;
  final Function handleApply;
  final Function handleReset;

  @override
  Widget build(BuildContext context) {
    return FilterView(
        minPriceTextController: minPriceTextController,
        maxPriceTextController: maxPriceTextController,
        handleApply: handleApply,
        handleReset: handleReset);
  }
}
