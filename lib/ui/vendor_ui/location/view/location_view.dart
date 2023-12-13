import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../config/route/route_paths.dart';
import '../../../../core/vendor/constant/ps_constants.dart';
import '../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/item_location_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/location/component/location/explore_widget.dart';
import '../../../custom_ui/location/component/location/header_photo.dart';
import '../../../custom_ui/location/component/location/select_city_widget.dart';
import '../../../custom_ui/location/component/location/select_township_widget.dart';
import '../../../custom_ui/location/component/location/title.dart';
import '../../common/base/ps_widget_with_appbar_no_app_bar_title.dart';

class ItemLocationView extends StatefulWidget {
  @override
  _ItemLocationViewState createState() => _ItemLocationViewState();
}

class _ItemLocationViewState extends State<ItemLocationView> {
  late ItemLocationProvider _itemLocationProvider;
  PsValueHolder? valueHolder;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchCityNameController =
      TextEditingController();
  final TextEditingController searchTownshipNameController =
      TextEditingController();

  int i = 0;
  @override
  void dispose() {
    // animation = null;
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _itemLocationProvider.loadNextDataList();
      }
    });

    super.initState();
  }

  ItemLocationRepository? repo1;
  dynamic data;
  bool isFirstTime = true;
  late AppLocalization langProvider;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    repo1 = Provider.of<ItemLocationRepository>(context);
    valueHolder = Provider.of<PsValueHolder?>(context);
    print(
        '............................Build Item Location UI Again ............................');

    return PsWidgetWithAppBarNoAppBarTitle<ItemLocationProvider>(initProvider:
        () {
      return ItemLocationProvider(repo: repo1, psValueHolder: valueHolder);
    }, onProviderReady: (ItemLocationProvider provider) {
      provider.latestLocationParameterHolder.keyword =
          searchCityNameController.text;
      provider.latestLocationParameterHolder.keyword =
          searchTownshipNameController.text;
      provider.loadDataList(
          requestBodyHolder: provider.latestLocationParameterHolder,
          requestPathHolder: RequestPathHolder(
              loginUserId: Utils.checkUserLoginId(provider.psValueHolder!),
              languageCode: langProvider.currentLocale.languageCode));
      _itemLocationProvider = provider;
    }, builder:
        (BuildContext context, ItemLocationProvider _provider, Widget? child) {
      final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
      final ItemLocationProvider _provider =
          Provider.of(context, listen: false);
      if (valueHolder.locationId != null && valueHolder.locationId != '') {
        searchCityNameController.text = valueHolder.locactionName ?? '';
        _provider.itemLocationId = valueHolder.locationId;
        _provider.itemLocationName = valueHolder.locactionName;
        _provider.itemLocationLat = valueHolder.locationLat;
        _provider.itemLocationLng = valueHolder.locationLng;

        if (isFirstTime && valueHolder.locationTownshipId != '') {
          searchTownshipNameController.text = valueHolder.locationTownshipName;
          _provider.itemLocationTownshipId = valueHolder.locationTownshipId;
          _provider.itemLocationTownshipName = valueHolder.locationTownshipName;
          _provider.itemLocationLat = valueHolder.locationTownshipLat;
          _provider.itemLocationLng = valueHolder.locationTownshipLng;
          isFirstTime = false;
        }
      }

      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: PsDimens.space32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Utils.isLightMode(context) ? PsColors.text800: PsColors.text50,
                    ),
                    onPressed: onClose,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: PsDimens.space104,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CustomHeaderPhotoWidget(),
                CustomLocationTitle(),
                CustomSelectCityWidget(
                    searchCityNameController: searchCityNameController,
                    searchTownshipNameController: searchTownshipNameController),
                if (valueHolder.isSubLocation == PsConst.ONE)
                  CustomSelectTownshipWidget(
                      searchTownshipNameController:
                          searchTownshipNameController),
                CustomExploreWidget(),
              ],
            ),
          ],
        ),
      );
    });
  }

  Future<void> onClose() async {
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    if (_itemLocationProvider.itemLocationId == '') {
      await _itemLocationProvider.replaceItemLocationData(
          '',
          'product_list__category_all'.tr,
          valueHolder.defaultlocationLat!,
         valueHolder.defaultlocationLng!);

      await _itemLocationProvider.replaceItemLocationTownshipData(
        '',
        '',
        'product_list__category_all'.tr,
        valueHolder.defaultlocationLat!,
         valueHolder.defaultlocationLng!
      );
      Navigator.pushReplacementNamed(context, RoutePaths.home);
    } else {
      await _itemLocationProvider.replaceItemLocationData(
        _itemLocationProvider.itemLocationId!,
        _itemLocationProvider.itemLocationName!,
        _itemLocationProvider.itemLocationLat!,
        _itemLocationProvider.itemLocationLng!,
      );
      await _itemLocationProvider.replaceItemLocationTownshipData(
          _itemLocationProvider.itemLocationTownshipId!,
          _itemLocationProvider.itemLocationId!,
          _itemLocationProvider.itemLocationTownshipName!,
          _itemLocationProvider.itemLocationTownshipLat!,
          _itemLocationProvider.itemLocationTownshipLng!);
      Navigator.pushReplacementNamed(context, RoutePaths.home);
    }
  }
}
