import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/viewobject/holder/category_parameter_holder.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class SearchTextBoxWidget extends StatefulWidget {
  const SearchTextBoxWidget({
      required this.categoryParameterHolder});

  final CategoryParameterHolder categoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SearchTextBoxWidgetState();
}

class _SearchTextBoxWidgetState extends State<SearchTextBoxWidget> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchTextEditingController,
        clickSearchButton: () {
          widget.categoryParameterHolder.keyword = searchTextEditingController.text;
          Navigator.pop(context, widget.categoryParameterHolder);
          searchTextEditingController.clear();
        },
        clickEnterFunction: () {
          widget.categoryParameterHolder.keyword = searchTextEditingController.text;
          Navigator.pop(context, widget.categoryParameterHolder);
          searchTextEditingController.clear();
        });
  }
}
