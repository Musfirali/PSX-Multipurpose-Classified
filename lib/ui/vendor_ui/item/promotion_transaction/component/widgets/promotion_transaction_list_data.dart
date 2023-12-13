import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/vendor/provider/product/promotion_transaction_provider.dart';
import '../../../../../../core/vendor/viewobject/promotion_transaction.dart';
import '../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../custom_ui/item/promotion_transaction/component/widgets/promotion_transaction_item.dart';

class PromotionTransactionListData extends StatefulWidget {
  const PromotionTransactionListData(
      {required this.isSelected,
      required this.onTap,
      required this.onLongPrass,
      required this.productSelection});
  final bool isSelected;
  final Function onTap;
  final Function onLongPrass;
  final List<Selection> productSelection;

  @override
  State<PromotionTransactionListData> createState() =>
      _PromotionTransactionListDataState();
}

class _PromotionTransactionListDataState
    extends State<PromotionTransactionListData> {
  @override
  Widget build(BuildContext context) {
    final PromotionTranscationHistoryProvider provider =
        Provider.of<PromotionTranscationHistoryProvider>(context);
    return SliverList(
      // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 220.0, childAspectRatio: 1.7),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final PromotionTransaction promotionTransaction =
              provider.getListIndexOf(index);
          widget.productSelection.add(
            Selection(promotionTransaction: promotionTransaction),
          );
          return CustomPromotionTransactionItem(
              transaction: provider.transactionList.data![index],
              isSelected: widget.productSelection[index].isSelected,
              onTap: () {
                onTap(index, provider.hashCode.toString());
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

  void onTap(int index, String tagKey) {
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
    }
  }
}
