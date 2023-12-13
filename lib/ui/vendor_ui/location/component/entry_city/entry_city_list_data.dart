import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location/item_location_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/item_location.dart';
import '../../../../custom_ui/location/component/entry_city/entry_city_list_item.dart';

class EntryCityListData extends StatefulWidget {
  const EntryCityListData(
      {required this.animationController, required this.selectedCityName});
  final AnimationController animationController;
  final String selectedCityName;
  @override
  State<StatefulWidget> createState() => _EntryCityListDataState();
}

class _EntryCityListDataState extends State<EntryCityListData> {
  final ScrollController _scrollController = ScrollController();

  late ItemLocationProvider _itemLocationProvider;
  Animation<double>? animation;

  @override
  void dispose() {
    animation = null;
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

  @override
  Widget build(BuildContext context) {
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    _itemLocationProvider = Provider.of<ItemLocationProvider>(context);
    final bool isLoading =
        _itemLocationProvider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : _itemLocationProvider.dataLength;
    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return CustomEntryCityListItem(
            itemLocation: isLoading
                ? ItemLocation()
                : _itemLocationProvider.getListIndexOf(index),
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            isLoading: isLoading,
            isSelected: !isLoading &&
                widget.selectedCityName ==
                    _itemLocationProvider.getListIndexOf(index).name,
          );
        });
  }
}
