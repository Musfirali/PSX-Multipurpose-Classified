import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/choose_category_widget.dart';

class CustomChooseCategoryDropDownWidget extends StatelessWidget {
  const CustomChooseCategoryDropDownWidget(
      {required this.categoryController,
      required this.subCategoryController,
      required this.isMandatory,
      required this.isShowDropDown
      });
  final TextEditingController categoryController;
  final TextEditingController subCategoryController;
  final bool isMandatory;
  final bool isShowDropDown;

  @override
  Widget build(BuildContext context) {
    return ChooseCategoryDropDownWidget(
      categoryController: categoryController,
      subCategoryController: subCategoryController,
      isMandatory: isMandatory,
      isShowDropDown: isShowDropDown,
    );
  }
}
