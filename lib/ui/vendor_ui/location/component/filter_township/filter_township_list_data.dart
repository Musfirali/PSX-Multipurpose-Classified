import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location_township/item_location_township_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/location/component/filter_township/filter_township_list_item.dart';

class FilterTownshipListData extends StatefulWidget {
  const FilterTownshipListData(
      {required this.animationController, required this.selectedTownshipName});
  final AnimationController animationController;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() => _FilterTownshipViewState();
}

class _FilterTownshipViewState extends State<FilterTownshipListData> {
  final ScrollController _scrollController = ScrollController();
  late ItemLocationTownshipProvider provider;

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
    provider = Provider.of<ItemLocationTownshipProvider>(context);
    final PsValueHolder valueHolder =Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : provider.itemLocationTownshipList.data!.length + 1;

    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          final String townshipName = isLoading
              ? ''
              : index == 0
                  ? 'product_list__category_all'.tr
                  : provider
                      .itemLocationTownshipList.data![index - 1].townshipName!;
          return CustomFilterTownshipListItem(
            itemLocationTownship: townshipName,
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            isLoading: isLoading,
            isSelected:
                !isLoading && townshipName == widget.selectedTownshipName,
            onTap: () {
              onTap(index);
            },
          );
        });
  }

  void onTap(int index) {
    if (index == 0) {
      Navigator.pop(context, true);
    } else {
      Navigator.pop(
          context, provider.itemLocationTownshipList.data![index - 1]);
    }
  }
}
