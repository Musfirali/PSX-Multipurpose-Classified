import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/township_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/item_location_township.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_dropdown_base_with_controller_widget.dart';

class ChooseTownshipDropDownWidget extends StatelessWidget {
  const ChooseTownshipDropDownWidget(
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
    return PsDropdownBaseWithControllerWidget(
        title: 'item_entry__location_township'.tr,
        textEditingController: townshipController,
        hintText: 'item_entry__select_township'.tr,
        isStar: isMandatory,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final ItemEntryProvider provider =
              Provider.of<ItemEntryProvider>(context, listen: false);
          if (provider.itemLocationId != '' && provider.itemLocationId != null) {
            final dynamic itemLocationTownshipResult =
                await Navigator.pushNamed(
                    context, RoutePaths.itemLocationTownship,
                    arguments: TownshipIntentHolder(selectedTownshipName: townshipController.text, cityId: provider.itemLocationId!));

            if (itemLocationTownshipResult != null &&
                itemLocationTownshipResult is ItemLocationTownship) {
              provider.itemLocationTownshipId = itemLocationTownshipResult.id;
              townshipController.text =
                  itemLocationTownshipResult.townshipName!;
              if (userInputAddressController.text == '')    
              updateMap(double.parse(itemLocationTownshipResult.lat ?? '0'),
                  double.parse(itemLocationTownshipResult.lng ?? '0'), '');
            }
          } else {
            showDialog<dynamic>(
                context: context,
                builder: (BuildContext context) {
                  return ErrorDialog(
                    message: 'home_search__choose_city_first'.tr,
                  );
                });
          }
        });
  }
}