import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/route/route_paths.dart';
import '../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../core/vendor/provider/history/history_provider.dart';
import '../../../../../../core/vendor/viewobject/holder/intent_holder/product_detail_intent_holder.dart';
import '../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../custom_ui/history/component/list/widgets/history_list_item.dart';

class HistoryListData extends StatefulWidget {
  const HistoryListData(
      {required this.animationController,
      required this.isSelected,
      required this.onTap,
      required this.onLongPrass,
      required this.productSelection});
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final Function onLongPrass;
  final List<Selection> productSelection;
  @override
  State<HistoryListData> createState() => _HistoryListDataState();
}

class _HistoryListDataState extends State<HistoryListData> {
  @override
  Widget build(BuildContext context) {
    final HistoryProvider provider = Provider.of<HistoryProvider>(context);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Product product = provider.getListIndexOf(index);
          widget.productSelection.add(
            Selection(product: product),
          );
          return CustomHistoryListItem(
              animationController: widget.animationController,
              product: product,
              isSelected: widget.productSelection[index].isSelected,
              onTap: () {
                onTap(index, product, provider.hashCode.toString());
              },
              onLongPress: () {
                widget.onLongPrass();
                setState(() {
                  widget.productSelection[index].isSelected =
                      !widget.productSelection[index].isSelected;
                });
              });
        },
        childCount: provider.dataLength,
      ),
    );
  }

  void onTap(int index, Product product, String tagKey) {
    int selectedCount = 0;
    for (Selection e in widget.productSelection) {
      if (e.isSelected == true) {
        selectedCount += 1;
      }
    }
    if (widget.isSelected) {
      setState(() {
        if (widget.productSelection[index].isSelected == true &&
            selectedCount == 1) {
          widget.onTap();
        }
        widget.productSelection[index].isSelected =
            !widget.productSelection[index].isSelected;
      });
    } else {
      final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
          productId: product.id,
          heroTagImage: tagKey + product.id! + PsConst.HERO_TAG__IMAGE,
          heroTagTitle: tagKey + product.id! + PsConst.HERO_TAG__TITLE);
      Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
    }
  }
}
