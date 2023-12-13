import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/item/price_range/view/choose_price_range_view.dart';

class CustomChoosePriceRangeView extends StatefulWidget {
  const CustomChoosePriceRangeView({required this.dollarCount});
  final int dollarCount;
  @override
  State<StatefulWidget> createState() {
    return ItemCurrencyViewState();
  }
}

class ItemCurrencyViewState extends State<CustomChoosePriceRangeView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChoosePriceRangeView(dollarCount: widget.dollarCount);
  }
}
