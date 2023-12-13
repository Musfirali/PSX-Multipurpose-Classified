import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/item_location_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/location/component/select_city/city_search_widget.dart';
import '../../../custom_ui/location/component/select_city/select_city_list_data.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_ui_widget.dart';

class SelectCityView extends StatelessWidget {
  const SelectCityView({
    Key? key,
    required this.selectedCity,
  }) : super(key: key);
  final String selectedCity;

  @override
  Widget build(BuildContext context) {
    final ItemLocationRepository? repo1 =
        Provider.of<ItemLocationRepository>(context);
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);

    final TextEditingController? searchController = TextEditingController();

    print(
        '............................Build Item Location UI Again ............................');

    return PsWidgetWithAppBar<ItemLocationProvider>(
        appBarTitle: 'select_city'.tr,
        initProvider: () {
          return ItemLocationProvider(repo: repo1, psValueHolder: valueHolder);
        },
        onProviderReady: (ItemLocationProvider provider) {
          provider.latestLocationParameterHolder.keyword = '';
          provider.loadDataList(
              requestBodyHolder: provider.latestLocationParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId:
                      Utils.checkUserLoginId(provider.psValueHolder!),languageCode: langProvider!.currentLocale.languageCode));
        },
        builder: (BuildContext context, ItemLocationProvider _provider,
            Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              PSProgressIndicator(_provider.currentStatus,
                  message: _provider.itemLocationList.message),
              CustomCitySearchWidget(searchController: searchController!),
              Expanded(
                child: RefreshIndicator(
                  child: CustomSelectCityListData(
                    selectedCity: selectedCity,
                  ),
                  onRefresh: () {
                    return _provider.loadDataList(
                      reset: true,
                    );
                  },
                ),
              )
            ],
          );
        });
  }
}
