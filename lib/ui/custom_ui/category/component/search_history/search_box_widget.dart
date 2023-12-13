import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/category_parameter_holder.dart';
import '../../../../vendor_ui/category/component/search_history/search_box_widget.dart';

class CustomSearchTextBoxWidget extends StatefulWidget {
  const CustomSearchTextBoxWidget({
      required this.categoryParameterHolder});
  final CategoryParameterHolder categoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchTextBoxWidgetState();
}

class _SearchTextBoxWidgetState extends State<CustomSearchTextBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return SearchTextBoxWidget(
      categoryParameterHolder: widget.categoryParameterHolder,
    );
  }
}
