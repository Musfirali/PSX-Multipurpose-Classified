import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/viewobject/holder/category_parameter_holder.dart';

import '../../../vendor_ui/category/view/search_category_history_view_container.dart';

class CustomSearchCategoryHistoryViewContainer extends StatefulWidget {
  const CustomSearchCategoryHistoryViewContainer({
    required this.categoryParameterHolder,
  });
  final CategoryParameterHolder categoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchCategoryHistoryViewContainerViewState();
}
class _SearchCategoryHistoryViewContainerViewState extends State<CustomSearchCategoryHistoryViewContainer> {

  @override
  Widget build(BuildContext context) {
    return SearchCategoryHistoryViewContainer(
      categoryParameterHolder: widget.categoryParameterHolder,
    );
  }
}
