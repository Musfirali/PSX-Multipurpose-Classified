import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../core/vendor/provider/item_location_township/item_location_township_provider.dart';
import '../../../common/ps_textfield_widget_with_icon.dart';

class TownshipSearchWidget extends StatelessWidget {
  const TownshipSearchWidget({required this.searchController});
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    final ItemLocationTownshipProvider provider =
        Provider.of<ItemLocationTownshipProvider>(context);
    return PsTextFieldWidgetWithIcon(
        hintText: 'Search'.tr,
        textEditingController: searchController,
        clickSearchButton: () {
          provider.latestLocationParameterHolder.keyword =
              searchController.text;
          provider.loadDataList(
            reset: true,
            requestBodyHolder: provider.latestLocationParameterHolder,
          );
        },
        clickEnterFunction: () {
          provider.latestLocationParameterHolder.keyword =
              searchController.text;
          provider.loadDataList(
            reset: true,
            requestBodyHolder: provider.latestLocationParameterHolder,
          );
        });
  }
}
