import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/entry_description.dart';

class CustomEntryDescription extends StatelessWidget {
  const CustomEntryDescription(
      {required this.userInputDescription, required this.isMandatory});
  final TextEditingController userInputDescription;
  final bool isMandatory;
  
  @override
  Widget build(BuildContext context) {
    return EntryDescription(
        userInputDescription: userInputDescription, isMandatory: isMandatory);
  }
}
