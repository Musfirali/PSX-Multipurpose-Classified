import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/choose_subcategory_widget.dart';

class CustomChooseSubCategoryDropDownWidget extends StatelessWidget {
  const CustomChooseSubCategoryDropDownWidget(
      {required this.subCategoryController, required this.isMandatory});
  final TextEditingController subCategoryController;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return ChooseSubCategoryDropDownWidget(
        subCategoryController: subCategoryController, 
        isMandatory: isMandatory);
  }
}
