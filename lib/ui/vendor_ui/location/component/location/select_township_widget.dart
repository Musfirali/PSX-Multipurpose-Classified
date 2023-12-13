import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../../core/vendor/viewobject/holder/intent_holder/township_intent_holder.dart';
import '../../../common/dialog/error_dialog.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class SelectTownshipWidget extends StatelessWidget {
  const SelectTownshipWidget({required this.searchTownshipNameController});
  final TextEditingController searchTownshipNameController;
  @override
  Widget build(BuildContext context) {
    final ItemLocationProvider _provider = Provider.of(context, listen: false);
    return Container(
        margin: const EdgeInsets.only(
            left: PsDimens.space16,
            right: PsDimens.space16,
            top: PsDimens.space16),
        child: PsTextFieldWidgetWithIcon2(
          hintText: 'select_township'.tr,
          textEditingController: searchTownshipNameController,
          onTap: () async {
            if (_provider.itemLocationId != '') {
              final TownshipIntentHolder intentHolder = TownshipIntentHolder(
                  cityId: _provider.itemLocationId!,
                  selectedTownshipName: searchTownshipNameController.text);
              Navigator.pushNamed(context, RoutePaths.itemLocationTownshipFirst,
                  arguments: intentHolder);
            } else {
              showDialog<dynamic>(
                  context: context,
                  builder: (BuildContext context) {
                    return ErrorDialog(
                      message: 'home_search__choose_city_first'.tr,
                    );
                  });
              const ErrorDialog(message: 'Choose City first');
            }
          },
        ));
  }
}
