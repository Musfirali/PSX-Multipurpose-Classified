import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/provider/product/search_product_provider.dart';
import '../../../../../common/ps_dropdown_base_widget.dart';

class LocationDropDownButton extends StatelessWidget {
  const LocationDropDownButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SearchProductProvider provider =
        Provider.of<SearchProductProvider>(context);
    return PsDropdownBaseWidget(
        title: 'item_entry__location'.tr,
        selectedText: provider.selectedLocationName,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          final dynamic locationResult = await Navigator.pushNamed(
              context, RoutePaths.searchLocationList,
              arguments: provider.selectedLocationName ?? '');
          provider.onCityDataChoose(locationResult);
        });
  }
}
