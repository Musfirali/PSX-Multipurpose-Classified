import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';

import '../../../../core/vendor/api/common/ps_status.dart';
import '../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../core/vendor/provider/language/app_localization_provider.dart';
import '../../../../core/vendor/repository/item_location_repository.dart';
import '../../../../core/vendor/utils/utils.dart';
import '../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../core/vendor/viewobject/holder/request_path_holder.dart';
import '../../../custom_ui/location/component/entry_city/entry_city_list_data.dart';
import '../../common/base/ps_widget_with_appbar.dart';
import '../../common/ps_ui_widget.dart';

class ItemEntryFilterCityView extends StatefulWidget {
  const ItemEntryFilterCityView({required this.selectedCityName});
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _ItemEntryLocationViewState();
}

class _ItemEntryLocationViewState extends State<ItemEntryFilterCityView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;
  PsValueHolder? valueHolder;
  late AppLocalization langProvider;

  @override
  void dispose() {
    animationController!.dispose();
    animation = null;
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(animationController!);
    super.initState();
  }

  ItemLocationRepository? repo1;

  @override
  Widget build(BuildContext context) {
    langProvider = Provider.of<AppLocalization>(context);
    valueHolder = Provider.of<PsValueHolder>(context);
    Future<bool> _requestPop() {
      animationController!.reverse().then<dynamic>(
        (void data) {
          if (!mounted) {
            return Future<bool>.value(false);
          }
          Navigator.pop(context, true);
          return Future<bool>.value(true);
        },
      );
      return Future<bool>.value(false);
    }

    repo1 = Provider.of<ItemLocationRepository>(context);

    print(
        '............................Build UI Again ............................');

    return WillPopScope(
      onWillPop: _requestPop,
      child: PsWidgetWithAppBar<ItemLocationProvider>(
          appBarTitle: 'item_entry__location'.tr,
          initProvider: () {
            return ItemLocationProvider(
                repo: repo1, psValueHolder: valueHolder);
          },
          onProviderReady: (ItemLocationProvider provider) {
            provider.loadDataList(
                requestBodyHolder: provider.latestLocationParameterHolder,
                requestPathHolder: RequestPathHolder(
                    loginUserId:
                        Utils.checkUserLoginId(provider.psValueHolder!),
                    languageCode: langProvider.currentLocale.languageCode));
          },
          builder: (BuildContext context, ItemLocationProvider provider,
              Widget? child) {
            return Stack(children: <Widget>[
              RefreshIndicator(
                child: (provider.currentStatus == PsStatus.BLOCK_LOADING ||
                        provider.hasData)
                    ? CustomEntryCityListData(
                        animationController: animationController!,
                        selectedCityName: widget.selectedCityName)
                    : const SizedBox(),
                onRefresh: () {
                  return provider.loadDataList(
                    reset: true,
                  );
                },
              ),
              PSProgressIndicator(provider.currentStatus)
            ]);
          }),
    );
  }
}
