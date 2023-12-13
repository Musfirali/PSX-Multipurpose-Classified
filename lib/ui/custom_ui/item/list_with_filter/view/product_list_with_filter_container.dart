import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../vendor_ui/item/list_with_filter/view/product_list_with_filter_container.dart';

class CustomProductListWithFilterContainerView extends StatefulWidget {
  const CustomProductListWithFilterContainerView(
      {Key? key,
      required this.productParameterHolder,
      required this.appBarTitle})
      : super(key: key);

  final ProductParameterHolder productParameterHolder;
  final String? appBarTitle;

  @override
  State<CustomProductListWithFilterContainerView> createState() =>
      _CustomFilterTabBarContainerState();
}

class _CustomFilterTabBarContainerState
    extends State<CustomProductListWithFilterContainerView> {
  @override
  Widget build(BuildContext context) {
    return ProductListWithFilterContainerView(
        productParameterHolder: widget.productParameterHolder,
        appBarTitle: widget.appBarTitle);
  }
}
