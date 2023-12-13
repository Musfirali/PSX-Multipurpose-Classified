import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/customize_ui_detail.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../../item/custom_field_selection/view/single_data_selection_view.dart';
import '../../ps_dropdown_base_with_controller_widget.dart';

class UserDropDownWidget extends StatelessWidget {
  const UserDropDownWidget({
    Key? key,
    required this.customField,
  }) : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = userFieldProvider
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
            return SingleDataSelectionContainer(
              appBartitle: customField.name!,
              textEditingController: element.value.valueTextController,
              coreKeyId: customField.coreKeyId!,
              selectedId: element.value.idTextController.text,
            );
          }));
          if (result != null && result is CustomizeUiDetail) {
            element.value.idTextController.text = result.id!;
            element.value.valueTextController.text = result.name!;
          }
        });
  }
}
