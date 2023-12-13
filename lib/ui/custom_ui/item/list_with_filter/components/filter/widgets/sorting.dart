import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../vendor_ui/item/list_with_filter/components/filter/widgets/sorting.dart';

class CustomSortingRadioView extends StatefulWidget {
  const CustomSortingRadioView({
    Key? key, 
    required this.searchProductProvider})
      : super(key: key);
  final SearchProductProvider searchProductProvider;

  @override
  State<CustomSortingRadioView> createState() => _CustomSortingRadioViewState();
}

class _CustomSortingRadioViewState extends State<CustomSortingRadioView> {
  @override
  Widget build(BuildContext context) {
    return SortingRadioView(
        searchProductProvider: widget.searchProductProvider);
  }
}
