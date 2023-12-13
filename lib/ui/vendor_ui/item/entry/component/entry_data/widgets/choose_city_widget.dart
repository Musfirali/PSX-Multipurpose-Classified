import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/item_location.dart';
import '../../../../../common/ps_dropdown_base_with_controller_widget.dart';

class ChooseCityDropDownWidget extends StatelessWidget {
  const ChooseCityDropDownWidget(
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
    return PsDropdownBaseWithControllerWidget(
        title: 'item_entry__location'.tr,
        hintText: 'item_entry__select_location'.tr,
        textEditingController: cityController,
        isStar: isMandatory,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final ItemEntryProvider provider =
              Provider.of<ItemEntryProvider>(context, listen: false);

          final dynamic itemLocationResult = await Navigator.pushNamed(
              context, RoutePaths.itemLocation,
              arguments: cityController.text);

          if (itemLocationResult != null &&
              itemLocationResult is ItemLocation) {
            provider.itemLocationId = itemLocationResult.id;
            provider.itemLocationTownshipId = '';
            cityController.text = itemLocationResult.name!;
            townshipController.text = '';
            provider.changeTownshipName('');
            if (userInputAddressController.text == '')
            updateMap(double.parse(itemLocationResult.lat ?? '0'),
                double.parse(itemLocationResult.lng ?? '0'), '');
          }
        });
  }
}
