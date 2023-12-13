import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../vendor_ui/item/list_with_filter/view/search_item_history_view_container.dart';

class CustomSearchItemHistoryViewContainer extends StatefulWidget {
  const CustomSearchItemHistoryViewContainer({
    required this.productParameterHolder,
  });
  final ProductParameterHolder productParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchItemHistoryViewContainerContainerState();
}

class _SearchItemHistoryViewContainerContainerState extends State<CustomSearchItemHistoryViewContainer> {

  @override
  Widget build(BuildContext context) {
    return SearchItemHistoryViewContainer(
      productParameterHolder: widget.productParameterHolder,
    );
  }
}
