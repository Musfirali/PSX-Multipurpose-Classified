import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../../core/vendor/viewobject/item_location.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget(
      {required this.searchCityNameController,
      required this.searchTownshipNameController});
  final TextEditingController searchCityNameController;
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
          hintText: 'select_city'.tr,
          textEditingController: searchCityNameController,
          onTap: () async {
            final dynamic itemLocationResult = await Navigator.pushNamed(
                context, RoutePaths.itemLocationFirst,
                arguments: searchCityNameController.text);

            if (itemLocationResult != null &&
                itemLocationResult is ItemLocation) {
              _provider.itemLocationId = itemLocationResult.id;

              searchTownshipNameController.text = '';
              searchCityNameController.text = itemLocationResult.name!;
              _provider.itemLocationName = itemLocationResult.name;
              _provider.itemLocationLat = itemLocationResult.lat;
              _provider.itemLocationLng = itemLocationResult.lng;

              _provider.itemLocationTownshipId = '';
              _provider.itemLocationTownshipName = '';
              _provider.itemLocationTownshipLat = '';
              _provider.itemLocationTownshipLng = '';
            }
          },
        ));
  }
}
