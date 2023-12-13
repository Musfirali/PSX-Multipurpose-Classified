import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/api/common/ps_status.dart';
import '../../../../../../core/vendor/provider/subcategory/sub_category_provider.dart';
import '../../../../../../core/vendor/utils/ps_animation.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../../core/vendor/viewobject/sub_category.dart';
import '../../../../../custom_ui/subcategory/component/filter/widgets/sub_category_filter_list_item.dart';

class SubCategoryFilterData extends StatefulWidget {
  const SubCategoryFilterData(
      {required this.animationController, required this.selectedSubCatName});
  final AnimationController animationController;
  final String selectedSubCatName;
  @override
  _SubCategoryFilterData createState() => _SubCategoryFilterData();
}

class _SubCategoryFilterData extends State<SubCategoryFilterData> {
  final ScrollController _scrollController = ScrollController();
  late SubCategoryProvider provider;
  late PsValueHolder valueHolder;

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
    provider = Provider.of<SubCategoryProvider>(context);
    valueHolder = Provider.of<PsValueHolder>(context, listen: false);
    final bool isLoading = provider.currentStatus == PsStatus.BLOCK_LOADING;
    final int count = isLoading
        ? valueHolder.loadingShimmerItemCount!
        : provider.dataList.data!.length;
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return CustomSubCategorySearchListItem(
            animationController: widget.animationController,
            animation: curveAnimation(widget.animationController,
                count: count, index: index),
            subCategory:
                isLoading ? SubCategory() : provider.getListIndexOf(index),
            isLoading: isLoading,
            isSelected: !isLoading &&
                provider.getListIndexOf(index).name ==
                    widget.selectedSubCatName,
          );
        });
  }
}
