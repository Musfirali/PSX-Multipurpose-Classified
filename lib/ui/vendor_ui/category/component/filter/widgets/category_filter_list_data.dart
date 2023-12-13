import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/core/vendor/viewobject/common/ps_value_holder.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../custom_ui/category/component/filter/widgets/category_filter_list_item.dart';

class CategoryFilterListData extends StatefulWidget {
  const CategoryFilterListData(
      {required this.animationController, required this.selectedName});
  final AnimationController animationController;
  final String selectedName;
  @override
  _CategoryFilterListDataState createState() => _CategoryFilterListDataState();
}

class _CategoryFilterListDataState extends State<CategoryFilterListData>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late CategoryProvider provider;
  Animation<double>? animation;

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
    provider = Provider.of<CategoryProvider>(context);
    final PsValueHolder valueHolder =
        Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count =
        isLoading ? valueHolder.loadingShimmerItemCount! : provider.dataLength;
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        shrinkWrap: false,
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return CustomCategoryFilterListItem(
            isLoading: isLoading,
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            category: isLoading ? Category() : provider.getListIndexOf(index),
            isSelected: !isLoading &&
                provider.getListIndexOf(index).catName == widget.selectedName,
          );
        });
  }
}
