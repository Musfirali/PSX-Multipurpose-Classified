import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location_township/item_location_township_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../core/vendor/viewobject/item_location_township.dart';
import '../../../../custom_ui/location/component/entry_township/entry_township_list_item.dart';

class EntryTownshipListData extends StatefulWidget {
  const EntryTownshipListData(
      {required this.animationController, required this.selectedTownshipName});
  final AnimationController animationController;
  final String selectedTownshipName;
  @override
  State<StatefulWidget> createState() => _EntryTownshipListDataState();
}

class _EntryTownshipListDataState extends State<EntryTownshipListData> {
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
        : provider.itemLocationTownshipList.data!.length;
    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return CustomEntryTownshipListItem(
            itemLocationTownship: isLoading
                ? ItemLocationTownship()
                : provider.itemLocationTownshipList.data![index],
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            isLoading: isLoading,
            isSelected: !isLoading &&
                provider.itemLocationTownshipList.data![index].townshipName ==
                    widget.selectedTownshipName,
          );
        });
  }
}
