import 'package:flutter/material.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../common/ps_textfield_widget.dart';

class ListingTitle extends StatelessWidget {
  const ListingTitle(
      {required this.textEditingController, required this.isMandatory});
  final TextEditingController? textEditingController;
  final bool isMandatory;
  @override
  Widget build(BuildContext context) {
    return PsTextFieldWidget(
      titleText: 'item_entry__listing_title'.tr,
      textAboutMe: false,
      hintText: 'item_entry__entry_title'.tr,
      textEditingController: textEditingController,
      isStar: isMandatory,
    );
  }
}
