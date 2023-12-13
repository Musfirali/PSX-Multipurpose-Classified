import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/choose_township_widget.dart';

class CustomChooseTownshipDropDownWidget extends StatelessWidget {
  const CustomChooseTownshipDropDownWidget(
      {required this.townshipController,
      required this.userInputAddressController,
      required this.updateMap,
      required this.isMandatory});
      
  final TextEditingController townshipController;
  final TextEditingController userInputAddressController;
  final Function updateMap;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return ChooseTownshipDropDownWidget(
        townshipController: townshipController,
        userInputAddressController: userInputAddressController,
        updateMap: updateMap,
        isMandatory: isMandatory);
  }
}
