import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../common/ps_textfield_widget.dart';

class EntryDescription extends StatelessWidget {
  const EntryDescription(
      {required this.userInputDescription, required this.isMandatory});
  final TextEditingController userInputDescription;
  final bool isMandatory;
  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidget(
      titleText: 'item_entry__description'.tr,
      height: PsDimens.space120,
      hintText: 'item_entry__description'.tr,
      textAboutMe: true,
      keyboardType: TextInputType.multiline,
      textEditingController: userInputDescription,
      isStar: isMandatory,
    );
  }
}
