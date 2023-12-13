import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/product/item_entry_provider.dart';
import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../ps_textfield_widget.dart';

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({Key? key, required this.customField}) : super(key: key);
  final CustomField customField;
  @override
  Widget build(BuildContext context) {
    final ItemEntryFieldProvider itemEntryFieldProvider =
        Provider.of<ItemEntryFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = itemEntryFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return PsTextFieldWidget(
      height: 100,
      titleText: customField.name!.tr,
      textAboutMe: false,
      hintText: customField.placeHolder!.tr,
      textEditingController: element.value.valueTextController,
      isStar: customField.isMandatory,
    );
  }
}
