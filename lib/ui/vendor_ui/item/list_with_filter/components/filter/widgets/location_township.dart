import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../../../core/vendor/viewobject/holder/intent_holder/township_intent_holder.dart';
import '../../../../../../../core/vendor/viewobject/item_location_township.dart';
import '../../../../../common/dialog/error_dialog.dart';
import '../../../../../common/ps_dropdown_base_widget.dart';

class LocationTownshipDropDownButton extends StatelessWidget {
  const LocationTownshipDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider provider =
        Provider.of<SearchProductProvider>(context);
    return PsDropdownBaseWidget(
        title: 'item_entry__location_township'.tr,
        selectedText: provider.selectedLocationTownshipName,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());

          if (provider.locationId != '' && provider.locationId != null) {
            final dynamic townshipResult = await Navigator.pushNamed(
                context, RoutePaths.searchLocationTownshipList,
                arguments: TownshipIntentHolder(
                    selectedTownshipName:
                        provider.selectedLocationTownshipName ?? '',
                    cityId: provider.locationId!));
            if (townshipResult != null &&
                townshipResult is ItemLocationTownship) {
              provider.locationTownshipId = townshipResult.id;
              // setState(() {
              provider.selectedLocationTownshipName =
                  townshipResult.townshipName;
              // });
            } else if (townshipResult) {
              provider.locationTownshipId = '';
              provider.selectedLocationTownshipName =
                  'product_list__category_all'.tr;
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
