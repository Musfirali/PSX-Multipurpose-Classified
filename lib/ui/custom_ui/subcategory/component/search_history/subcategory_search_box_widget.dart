import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../../../vendor_ui/subcategory/component/search_history/subcategory_search_box_widget.dart';

class CustomSubCategorySearchTextBoxWidget extends StatefulWidget {
  const CustomSubCategorySearchTextBoxWidget({
      required this.subCategoryParameterHolder});
  final SubCategoryParameterHolder subCategoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SubCategorySearchTextBoxWidgetState();
}

class _SubCategorySearchTextBoxWidgetState extends State<CustomSubCategorySearchTextBoxWidget> {

  @override
  Widget build(BuildContext context) {
    return SubCategorySearchTextBoxWidget(
      subCategoryParameterHolder: widget.subCategoryParameterHolder,
    );
  }
}
