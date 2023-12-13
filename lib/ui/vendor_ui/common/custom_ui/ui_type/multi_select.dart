import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/holder/intent_holder/selected_custom_value_intent_holder.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../item/custom_field_selection/view/multi_data_selection_container.dart';
import '../../ps_dropdown_base_with_controller_widget.dart';

class MultiSelectionWidget extends StatelessWidget {
  const MultiSelectionWidget({Key? key, required this.customField})
      : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return PsDropdownBaseWithControllerWidget(
        title: customField.name!.tr,
        textEditingController: element.value.valueTextController,
        isStar: customField.isMandatory,
        hintText: customField.placeHolder!.tr,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          final dynamic result = await Navigator.of(context).push<dynamic>(
              MaterialPageRoute<dynamic>(builder: (BuildContext context) {
            return MultiDataSelectionContainer(
              appBartitle: customField.name!,
              coreKeyId: customField.coreKeyId!,
              selectedIds: element.value.idTextController.text != ''
                  ? element.value.idTextController.text.split(',')
                  : <String>[],
              selectedValues: element.value.valueTextController.text != ''
                  ? element.value.valueTextController.text.split(',')
                  : <String>[],
            );
          }));
          if (result != null && result is SelectedCustomValuesIntentHolder) {
            element.value.valueTextController.text = result.nameList.toString();
            element.value.idTextController.text = result.idList.toString();
            print(result.idList.toString());
          }
        });
  }
}
