import 'package:flutter/material.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/utils/utils.dart';
import '../../../../../../../core/vendor/viewobject/category.dart';
import '../../../../../../../core/vendor/viewobject/common/ps_value_holder.dart';
import '../../../../../common/shimmer_item.dart';

class CategoryTile extends StatefulWidget {
  const CategoryTile(
      {Key? key,
      this.selectedData,
      this.category,
      required this.onCategoryClick,
      this.isLoading = false})
      : super(key: key);
  final dynamic selectedData;
  final Category? category;
  final Function onCategoryClick;
  final bool isLoading;
  @override
  State<StatefulWidget> createState() => _CategoryViewItem();
}

class _CategoryViewItem extends State<CategoryTile> {
  late PsValueHolder valueHolder;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PsDimens.space52,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: widget.isLoading
          ? const ShimmerItem()
          : Material(
              color: Utils.isLightMode(context)
                  ? PsColors.text200
                  : Utils.isLightMode(context) ? PsColors.achromatic50
              : PsColors.achromatic900,
              child: InkWell(
                onTap: () {
                  final Map<String, String?> dataHolder = <String, String?>{};
                  dataHolder[PsConst.CATEGORY_ID] = widget.category!.catId;
                  dataHolder[PsConst.SUB_CATEGORY_ID] = '';
                  dataHolder[PsConst.CATEGORY_NAME] = widget.category!.catName;
                  widget.onCategoryClick(dataHolder);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.category!.catName!,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Container(
                            child: widget.category!.catId ==
                                    widget.selectedData[PsConst.CATEGORY_ID]
                                ? IconButton(
                                    icon: const Icon(Icons.check_circle),
                                    onPressed: () {})
                                : Container())
                      ]),
                ),
              ),
            ),
    );
  }
}
