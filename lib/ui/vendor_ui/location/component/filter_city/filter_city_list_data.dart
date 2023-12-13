import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/location/component/filter_city/filter_city_list_item.dart';

class FilterCityListData extends StatefulWidget {
  const FilterCityListData(
      {required this.animationController, required this.selectedCityName});
  final AnimationController animationController;
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _FilterCityViewState();
}

class _FilterCityViewState extends State<FilterCityListData> {
  final ScrollController _scrollController = ScrollController();

  late ItemLocationProvider provider;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        provider.loadNextDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ItemLocationProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : provider.itemLocationList.data!.length + 1;
    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final String cityName = isLoading
              ? ''
              : index == 0
                  ? 'product_list__category_all'.tr
                  : provider.itemLocationList.data![index - 1].name!;
          return CustomFilterCityListItem(
            itemLocationTownship: cityName,
            onTap: () {
              onTap(index);
            },
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            isLoading: isLoading,
            isSelected: !isLoading && widget.selectedCityName == cityName,
          );
        });
  }

  void onTap(int index) {
    if (index == 0) {
      Navigator.pop(context, true);
    } else {
      Navigator.pop(context, provider.itemLocationList.data![index - 1]);
    }
  }
}
