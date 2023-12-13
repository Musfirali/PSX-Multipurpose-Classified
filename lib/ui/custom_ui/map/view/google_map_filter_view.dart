
import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../vendor_ui/map/view/google_map_filter_view.dart';

class CustomGoogleMapFilterView extends StatefulWidget {
  const CustomGoogleMapFilterView({required this.productParameterHolder});

  final ProductParameterHolder productParameterHolder;

  @override
  _GoogleMapFilterViewState createState() => _GoogleMapFilterViewState();
}

class _GoogleMapFilterViewState extends State<CustomGoogleMapFilterView> {
  @override
  Widget build(BuildContext context) {
    return GoogleMapFilterView(
        productParameterHolder: widget.productParameterHolder);
  }
}
