import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/location/component/select_city/select_city_list_item.dart';

class SelectCityListData extends StatefulWidget {
  const SelectCityListData({
    Key? key,
    required this.selectedCity,
  }) : super(key: key);
  final String selectedCity;

  @override
  State<StatefulWidget> createState() => _SelectCityListDataState();
}

class _SelectCityListDataState extends State<SelectCityListData>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  AnimationController? animationController;
  late ItemLocationProvider _itemLocationProvider;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _itemLocationProvider.loadNextDataList();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemLocationProvider = Provider.of<ItemLocationProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading =
        _itemLocationProvider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : _itemLocationProvider.dataLength + 1;
    bool? isChecked;
    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          if (index != 0) {
            if (_itemLocationProvider.getListIndexOf(index - 1).name ==
                widget.selectedCity) {
              isChecked = true;
            } else {
              isChecked = false;
            }
          } else {
            if ('product_list__category_all'.tr == widget.selectedCity) {
              isChecked = true;
            } else {
              isChecked = false;
            }
          }

          return CustomSelectCityListItem(
            isLoading: isLoading,
            animationController: animationController,
            animation: curveAnimation(animationController!,
                count: count, index: index),
            isChecked: isChecked!,
            itemLocation: isLoading
                ? ''
                : index == 0
                    ? 'product_list__category_all'.tr
                    : _itemLocationProvider.getListIndexOf(index - 1).name,
            onTap: () async {
              if (!isLoading) {
                if (index == 0) {
                  onAllSelected();
                } else {
                  onCitySelected(index);
                }
              }
            },
          );
        });
  }

  Future<void> onAllSelected() async {
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
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
  }

  Future<void> onCitySelected(int index) async {
    await _itemLocationProvider.replaceItemLocationData(
        _itemLocationProvider.getListIndexOf(index - 1).id,
        _itemLocationProvider.getListIndexOf(index - 1).name!,
        _itemLocationProvider.getListIndexOf(index - 1).lat!,
        _itemLocationProvider.getListIndexOf(index - 1).lng!);
    Navigator.pop(context, _itemLocationProvider.getListIndexOf(index - 1));
  }
}
