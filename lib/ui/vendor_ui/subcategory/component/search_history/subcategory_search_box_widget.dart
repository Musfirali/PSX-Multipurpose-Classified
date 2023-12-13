import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/viewobject/holder/sub_category_parameter_holder.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class SubCategorySearchTextBoxWidget extends StatefulWidget {
  const SubCategorySearchTextBoxWidget({
      required this.subCategoryParameterHolder});

  final SubCategoryParameterHolder subCategoryParameterHolder;

  @override
  State<StatefulWidget> createState() => _SubCategorySearchTextBoxWidgetState();
}

class _SubCategorySearchTextBoxWidgetState extends State<SubCategorySearchTextBoxWidget> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchTextEditingController,
        clickSearchButton: () {
          widget.subCategoryParameterHolder.keyword = searchTextEditingController.text;
          Navigator.pop(context, widget.subCategoryParameterHolder);
          searchTextEditingController.clear();
        },
        clickEnterFunction: () {
          widget.subCategoryParameterHolder.keyword = searchTextEditingController.text;
          Navigator.pop(context, widget.subCategoryParameterHolder);
          searchTextEditingController.clear();
        });
  }
}
