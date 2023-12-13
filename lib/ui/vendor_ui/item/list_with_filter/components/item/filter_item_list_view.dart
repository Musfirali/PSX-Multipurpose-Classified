import 'package:flutter/material.dart';

import '../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_item_list.dart';
import '../../../../../custom_ui/item/list_with_filter/components/item/widgets/filter_nav_items.dart';
import '../../../../common/ps_admob_banner_widget.dart';

class FilterItemListView extends StatelessWidget {
  const FilterItemListView(
      {Key? key, required this.animationController, required this.isGrid})
      : super(key: key);

  final AnimationController animationController;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CustomFilterNavItems(),
        CustomItemListView(
          animationController: animationController,
          isGrid: isGrid,
        ),
        const PsAdMobBannerWidget(),
      ],
    );
  }
}
