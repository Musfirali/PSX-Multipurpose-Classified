import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/provider/user/user_feild_provider.dart';

import '../../../../../core/vendor/viewobject/custom_field.dart';
import '../../../../../core/vendor/viewobject/selected_object.dart';
import '../../ps_textfield_widget.dart';

class UserNumberWidget extends StatelessWidget {
  const UserNumberWidget({Key? key, required this.customField}) : super(key: key);
  final CustomField customField;

  @override
  Widget build(BuildContext context) {
    final UserFieldProvider userFieldProvider =
        Provider.of<UserFieldProvider>(context);
    final MapEntry<CustomField, SelectedObject> element = userFieldProvider
        .textControllerMap.entries
        .firstWhere((MapEntry<CustomField, SelectedObject> element) =>
            element.key.coreKeyId == customField.coreKeyId);

    return PsTextFieldWidget(
      titleText: customField.name!.tr,
      keyboardType: TextInputType.number,
      textAboutMe: false,
      hintText: customField.placeHolder!.tr,
      textEditingController: element.value.valueTextController,
      isStar: customField.isMandatory,
    );
  }
}
