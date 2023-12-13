import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/product_parameter_holder.dart';
import '../../../../vendor_ui/map/component/filter/apply_button.dart';

class CustomApplyButton extends StatelessWidget {
  const CustomApplyButton(
      {required this.kmValue,
      required this.productParameterHolder,
      required this.lat,
      required this.lng});
  final String kmValue;
  final ProductParameterHolder productParameterHolder;
  final String lat;
  final String lng;

  @override
  Widget build(BuildContext context) {
    return ApplyButton(
        kmValue: kmValue,
        productParameterHolder: productParameterHolder,
        lat: lat,
        lng: lng);
  }
}
