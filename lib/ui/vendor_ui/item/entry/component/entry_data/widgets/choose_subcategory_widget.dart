import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/sub_category_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_dropdown_base_with_controller_widget.dart';

class ChooseSubCategoryDropDownWidget extends StatelessWidget {
  const ChooseSubCategoryDropDownWidget(
    {required this.subCategoryController, 
    required this.isMandatory});
  final TextEditingController subCategoryController;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return PsDropdownBaseWithControllerWidget(
        title: 'item_entry__subCategory'.tr,
        hintText: 'item_entry__choose_sub_category'.tr,
        textEditingController: subCategoryController,
        isStar: isMandatory,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final ItemEntryProvider provider =
              Provider.of<ItemEntryProvider>(context, listen: false);
          if (provider.categoryId != '' && provider.categoryId != null) {
            final dynamic subCategoryResult = await Navigator.pushNamed(
                context, RoutePaths.searchSubCategory,
                arguments: SubCategoryIntentHolder(
                    categoryId: provider.categoryId!,
                    selectedSubCatName: subCategoryController.text));
            if (subCategoryResult != null && subCategoryResult is SubCategory) {
              provider.subCategoryId = subCategoryResult.id;
              subCategoryController.text = subCategoryResult.name!;
              provider.subCategoryName = subCategoryResult.name!;
            }
          } else {
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'home_search__choose_category_first'.tr,
                  );
                });
          }
        });
  }
}
