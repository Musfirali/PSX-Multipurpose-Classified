import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/currency/view/item_currency_view.dart';

class CustomItemCurrencyView extends StatefulWidget {
  const CustomItemCurrencyView({required this.selectedCurrencySymobol});
  final String selectedCurrencySymobol;
  @override
  State<StatefulWidget> createState() {
    return ItemCurrencyViewState();
  }
}

class ItemCurrencyViewState extends State<CustomItemCurrencyView> {
  @override
  Widget build(BuildContext context) {
    return ItemCurrencyView(
      selectedCurrencySymobol: widget.selectedCurrencySymobol,
    );
  }
}