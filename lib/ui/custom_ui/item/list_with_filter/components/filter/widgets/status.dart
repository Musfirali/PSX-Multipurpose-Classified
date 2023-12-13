import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../vendor_ui/item/list_with_filter/components/filter/widgets/status.dart';

class CustomStatusRadioView extends StatefulWidget {
  const CustomStatusRadioView({Key? key, required this.searchProductProvider})
      : super(key: key);
  final SearchProductProvider searchProductProvider;

  @override
  State<CustomStatusRadioView> createState() => _CustomStatusRadioViewState();
}

class _CustomStatusRadioViewState extends State<CustomStatusRadioView> {
  @override
  Widget build(BuildContext context) {
    return StatusRadioView(searchProductProvider: widget.searchProductProvider);
  }
}
