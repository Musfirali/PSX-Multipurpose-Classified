import 'package:flutter/material.dart';
import 'package:psxmpc/ui/vendor_ui/common/dialog/confirm_dialog_view.dart';

import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../common/ps_dropdown_base_with_controller_widget.dart';


class ChooseCategoryDropDownWidget extends StatelessWidget {
  const ChooseCategoryDropDownWidget(
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
    return PsDropdownBaseWithControllerWidget(
      title: 'item_entry__category'.tr,
      hintText: 'item_entry__choose_category'.tr,
      textEditingController: categoryController,
      isStar: isMandatory,
      isShowDropDown: isShowDropDown,
      onTap: () async {
        if(isShowDropDown)
         showDialog<dynamic>(
            context: context,
            builder: (BuildContext context) {
              return ConfirmDialogView(
                title: 'item_entry_category_confirm_dialog_title'.tr,
                description: 'item_entry_category_confirm_dialog_description'.tr,
                leftButtonText: 'dialog__cancel'.tr,
                rightButtonText: 'logout_dialog__confirm'.tr,
                onAgreeTap: () async {
                  Navigator.pop(context);
                  Navigator.pop(context, false);
                },
              );
            });
      },
    );
  }
}
