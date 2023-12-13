import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../vendor_ui/map/view/map_filter_view.dart';

class CustomMapFilterView extends StatefulWidget {
  const CustomMapFilterView({required this.productParameterHolder});

  final ProductParameterHolder productParameterHolder;

  @override
  _MapFilterViewState createState() => _MapFilterViewState();
}

class _MapFilterViewState extends State<CustomMapFilterView> {
  @override
  Widget build(BuildContext context) {
    return MapFilterView(productParameterHolder: widget.productParameterHolder);
  }
}
