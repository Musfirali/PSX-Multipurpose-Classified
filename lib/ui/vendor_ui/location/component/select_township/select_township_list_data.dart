import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_config.dart';
import 'package:psxmpc/core/vendor/provider/language/app_localization_provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../config/route/route_paths.dart';
import '../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../core/vendor/provider/item_location_township/item_location_township_provider.dart';
import '../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../custom_ui/location/component/select_township/select_township_list_item.dart';

class SelectTownshipListData extends StatefulWidget {
  const SelectTownshipListData({
    Key? key,
    required this.selectedTownship,
  }) : super(key: key);
  final String selectedTownship;

  @override
  State<StatefulWidget> createState() => _SelectTownshipListDataState();
}

class _SelectTownshipListDataState extends State<SelectTownshipListData>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  AnimationController? animationController;
  late ItemLocationTownshipProvider provider;

  @override
  void initState() {
    animationController =
        AnimationController(duration: PsConfig.animation_duration, vsync: this);
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
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength + 1;
    bool? isChecked;

    return ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          if (index != 0) {
            if (provider.getListIndexOf(index - 1).townshipName ==
                widget.selectedTownship) {
              isChecked = true;
            } else {
              isChecked = false;
            }
          } else {
            if ('product_list__category_all'.tr == widget.selectedTownship) {
              isChecked = true;
            } else {
              isChecked = false;
            }
          }

          return CustomSelectTownshipListItem(
            isLoading: isLoading,
            animationController: animationController,
            animation: curveAnimation(animationController!,
                count: count, index: index),
            isChecked: isChecked!,
            itemLocationTownship: isLoading
                ? ''
                : index == 0
                    ? 'product_list__category_all'.tr
                    : provider.getListIndexOf(index - 1).townshipName,
            onTap: () async {
              if (!isLoading) {
                if (index == 0) {
                  await onAllSelected(index);
                } else {
                  await onTownshipSelected(index);
                }
                Navigator.pushReplacementNamed(context, RoutePaths.home);
              }
            },
          );
        });
  }

  Future<void> onAllSelected(int index) async {
    await provider.replaceItemLocationTownshipData(
      '',
      provider.getListIndexOf(index).cityId!,
      'product_list__category_all'.tr,
      provider.getListIndexOf(index).lat!,
      provider.getListIndexOf(index).lng!,
    );
  }

  Future<void> onTownshipSelected(int index) async {
    print('Township:::: ${provider.getListIndexOf(index - 1).townshipName!}');
    await provider.replaceItemLocationTownshipData(
        provider.getListIndexOf(index - 1).id!,
        provider.getListIndexOf(index - 1).cityId!,
        provider.getListIndexOf(index - 1).townshipName!,
        provider.getListIndexOf(index - 1).lat!,
        provider.getListIndexOf(index - 1).lng!);
  }
}
