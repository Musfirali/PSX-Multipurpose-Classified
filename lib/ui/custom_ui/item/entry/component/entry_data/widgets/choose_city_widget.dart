import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/choose_city_widget.dart';

class CustomChooseCityDropDownWidget extends StatelessWidget {
  const CustomChooseCityDropDownWidget(
      {required this.cityController,
      required this.townshipController,
       required this.userInputAddressController,
      required this.updateMap,
      required this.isMandatory});
      
  final TextEditingController cityController;
  final TextEditingController townshipController;
  final TextEditingController userInputAddressController;
  final Function updateMap;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return ChooseCityDropDownWidget(
        cityController: cityController,
        townshipController: townshipController,
        userInputAddressController: userInputAddressController,
        updateMap: updateMap,
        isMandatory: isMandatory,
       );
  }
}
