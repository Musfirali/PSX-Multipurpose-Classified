import 'package:flutter/material.dart';

import '../../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../../vendor_ui/item/list_with_filter/components/item/product_list_with_filter_view.dart';

class CustomProductListWithFilterView extends StatefulWidget {
  const CustomProductListWithFilterView({
    Key? key,
    required this.productParameterHolder,
    required this.animationController,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);

  final ProductParameterHolder productParameterHolder;
  final AnimationController animationController;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;


  @override
  State<CustomProductListWithFilterView> createState() =>
      _CustomProductListWithFilterViewState();
}

class _CustomProductListWithFilterViewState
    extends State<CustomProductListWithFilterView> {
  @override
  Widget build(BuildContext context) {
    return ProductListWithFilterView(
      productParameterHolder: widget.productParameterHolder,
      animationController: widget.animationController,
      scaffoldKey: widget.scaffoldKey,
      title: widget.title,
    );
  }
}
