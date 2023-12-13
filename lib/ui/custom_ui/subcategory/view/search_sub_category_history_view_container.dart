import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../../vendor_ui/subcategory/view/search_sub_category_history_view_container.dart';

class CustomSearchSubCategoryHistoryViewContainer extends StatefulWidget {
  const CustomSearchSubCategoryHistoryViewContainer({
    required this.subCategoryParameterHolder,
  });
  final SubCategoryParameterHolder subCategoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchSubCategoryHistoryViewContainerState();
}

class _SearchSubCategoryHistoryViewContainerState extends State<CustomSearchSubCategoryHistoryViewContainer> {

  @override
  Widget build(BuildContext context) {
    return SearchSubCategoryHistoryViewContainer(
      subCategoryParameterHolder: widget.subCategoryParameterHolder,
    );
  }
}
