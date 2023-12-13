import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class CitySearchWidget extends StatelessWidget {
  const CitySearchWidget({required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    final ItemLocationProvider _provider =
        Provider.of<ItemLocationProvider>(context);
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchController,
        clickSearchButton: () {
          _provider.latestLocationParameterHolder.keyword =
              searchController.text;
          _provider.loadDataList(
            reset: true,
            requestBodyHolder: _provider.latestLocationParameterHolder,
          );
        },
        clickEnterFunction: () {
          _provider.latestLocationParameterHolder.keyword =
              searchController.text;
          _provider.loadDataList(
            reset: true,
            requestBodyHolder: _provider.latestLocationParameterHolder,
          );
        });
  }
}
