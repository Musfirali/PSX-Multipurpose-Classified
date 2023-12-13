import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/product_parameter_holder.dart';

import '../../../../../vendor_ui/item/list_with_filter/components/search_history/item_search_box_widget.dart';

class CustomItemSearchTextBoxWidget extends StatefulWidget {
  const CustomItemSearchTextBoxWidget({
      required this.productParameterHolder});
  final ProductParameterHolder productParameterHolder;

  @override
  State<StatefulWidget> createState() => _ItemSearchTextBoxWidgetState();
}

class _ItemSearchTextBoxWidgetState extends State<CustomItemSearchTextBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return ItemSearchTextBoxWidget(
      productParameterHolder: widget.productParameterHolder);
  }
}
