import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/category/category_provider.dart';
import '../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../custom_ui/item/list_with_filter/components/category/widgets/category_tile.dart';
import '../../../../../custom_ui/item/list_with_filter/components/category/widgets/category_tile_with_expansion.dart';


class CategoryFilterList extends StatelessWidget {
  const CategoryFilterList({
    Key? key,
    required this.onCategoryClick,
    required this.onSubCategoryClick,
    required this.selectedData,
  }) : super(key: key);

  final dynamic selectedData;
  final Function onSubCategoryClick;
  final Function onCategoryClick;

  @override
  Widget build(BuildContext context) {
    final CategoryProvider provider = Provider.of<CategoryProvider>(context);
    final PsValueHolder valueHolder = Provider.of<PsValueHolder>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.dataLength,
        itemBuilder: (BuildContext context, int index) {
          if (provider.hasData) {
            return valueHolder.isShowSubcategory!
                ? CustomCategoryTileWithExpansion(
                    selectedData: selectedData,
                    category: provider.categoryList.data![index],
                    onSubCategoryClick: onSubCategoryClick)
                : CustomCategoryTile(
                    selectedData: selectedData,
                    category: provider.categoryList.data![index],
                    onCategoryClick: onCategoryClick);
          } else {
            return const SizedBox();
          }
        });
  }
}
