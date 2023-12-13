import 'package:flutter/widgets.dart';

import '../../../../../custom_ui/item/list_with_filter/components/filter/widgets/filter_options_widget.dart';
import '../../../../../custom_ui/item/list_with_filter/components/filter/widgets/reset_and_apply_widget.dart';

class FilterView extends StatelessWidget {
  const FilterView({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomFilterOptionsWidget(
            minPriceTextController: minPriceTextController,
            maxPriceTextController: maxPriceTextController),
        CustomResetAndApplyWidget(
          handleApply: handleApply,
          handleReset: handleReset,
        ),
      ],
    );
  }
}
