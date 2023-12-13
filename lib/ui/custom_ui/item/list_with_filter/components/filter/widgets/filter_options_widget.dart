import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/filter/widgets/filter_options_widget.dart';

class CustomFilterOptionsWidget extends StatelessWidget {
  const CustomFilterOptionsWidget({
    Key? key,
    required this.maxPriceTextController,
    required this.minPriceTextController,
  }) : super(key: key);
  final TextEditingController minPriceTextController;
  final TextEditingController maxPriceTextController;
  
  @override
  Widget build(BuildContext context) {
    return FilterOptionsWidget(
      minPriceTextController: minPriceTextController,
      maxPriceTextController: maxPriceTextController,
    );
  }
}
