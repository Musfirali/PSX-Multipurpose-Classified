import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/provider/package_bought/package_bought_transaction_provider.dart';
import '../../../../../../../core/vendor/viewobject/buyadpost_transaction.dart';
import '../../../../../../../core/vendor/viewobject/selection.dart';
import '../../../../../../custom_ui/package/component/transaction/vertical/widgets/package_transaction_item.dart';

class PackageTransactionListData extends StatefulWidget {
  const PackageTransactionListData(
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
  State<PackageTransactionListData> createState() =>
      _PackageTransactionListDataState();
}

class _PackageTransactionListDataState
    extends State<PackageTransactionListData> {
  @override
  Widget build(BuildContext context) {
    final PackageTranscationHistoryProvider provider =
        Provider.of<PackageTranscationHistoryProvider>(context);
    return SliverList(
      // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 220.0, childAspectRatio: 1.7),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final PackageTransaction packageTransaction =
              provider.getListIndexOf(index);
          widget.productSelection.add(
            Selection(packageTransaction: packageTransaction),
          );
          return CustomPackageTransactionItem(
              transaction: provider.transactionList.data![index],
              isSelected: widget.productSelection[index].isSelected,
              onTap: () {
                onTap(index, packageTransaction, provider.hashCode.toString());
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

  void onTap(int index, PackageTransaction product, String tagKey) {
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
      // final ProductDetailIntentHolder holder = ProductDetailIntentHolder(
      //     productId: product.id,
      //     heroTagImage: tagKey + product.id! + PsConst.HERO_TAG__IMAGE,
      //     heroTagTitle: tagKey + product.id! + PsConst.HERO_TAG__TITLE);
      // Navigator.pushNamed(context, RoutePaths.productDetail, arguments: holder);
    }
  }
}
