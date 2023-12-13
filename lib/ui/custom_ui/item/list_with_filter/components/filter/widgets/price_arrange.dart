import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/list_with_filter/components/filter/widgets/price_arrange.dart';

class CustomPriceArrangementWidget extends StatelessWidget {
  const CustomPriceArrangementWidget(
      {Key? key,
      required this.minPriceTextController,
      required this.maxPriceTextController})
      : super(key: key);

  final TextEditingController? minPriceTextController;
  final TextEditingController? maxPriceTextController;
  @override
  Widget build(BuildContext context) {
    return PriceArragementWidget(
      maxPriceTextController: maxPriceTextController,
      minPriceTextController: minPriceTextController,
    );
  }
}
