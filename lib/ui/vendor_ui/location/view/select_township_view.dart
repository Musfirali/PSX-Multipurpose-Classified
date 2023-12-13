import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/vendor/provider/item_location_township/item_location_township_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/item_location_township_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/location/component/select_township/select_township_list_data.dart';
import '../../../custom_ui/location/component/select_township/township_search_widget.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_ui_widget.dart';

class ItemLocationTownshipView extends StatelessWidget {
  const ItemLocationTownshipView({
    Key? key,
    required this.cityId,
    required this.selectedTownship,
  }) : super(key: key);

  final String cityId;
  final String selectedTownship;

  @override
  Widget build(BuildContext context) {
    // data = EasyLocalizationProvider.of(context).data;
    final ItemLocationTownshipRepository? repo1 =
        Provider.of<ItemLocationTownshipRepository>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    final TextEditingController? searchController = TextEditingController();
    final AppLocalization? langProvider = Provider.of<AppLocalization>(context);

    print(
        '............................Build Item Location Township UI Again ............................');

    return PsWidgetWithAppBar<ItemLocationTownshipProvider>(
        appBarTitle: 'select_township',
        initProvider: () {
          return ItemLocationTownshipProvider(
              repo: repo1, psValueHolder: valueHolder);
        },
        onProviderReady: (ItemLocationTownshipProvider provider) {
          provider.latestLocationParameterHolder.cityId = cityId;
          provider.loadDataList(
              requestBodyHolder: provider.latestLocationParameterHolder,
              requestPathHolder: RequestPathHolder(
                  loginUserId: Utils.checkUserLoginId(provider.psValueHolder!),
                  cityId: cityId,languageCode: langProvider!.currentLocale.languageCode));
        },
        builder: (BuildContext context, ItemLocationTownshipProvider provider,
            Widget? child) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PSProgressIndicator(provider.currentStatus,
                  message: provider.itemLocationTownshipList.message),
              CustomTownshipSearchWidget(searchController: searchController!),
              Expanded(
                child: RefreshIndicator(
                  child: CustomSelectTownshipListData(
                      selectedTownship: selectedTownship),
                  onRefresh: () {
                    return provider.loadDataList(reset: true);
                  },
                ),
              )
            ],
          );
        });
  }
}
