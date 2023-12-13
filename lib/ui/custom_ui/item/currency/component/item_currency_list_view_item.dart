

import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/item_currency.dart';
import '../../../../vendor_ui/item/currency/component/item_currency_list_view_item.dart';

class CustomItemCurrencyListViewItem extends StatelessWidget {
  const CustomItemCurrencyListViewItem(
      {Key? key,
      required this.itemCurrency,
      this.onTap,
      this.animationController,
      this.animation,
      required this.isSelected})
      : super(key: key);

  final ItemCurrency itemCurrency;
  final Function? onTap;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ItemCurrencyListViewItem(
      itemCurrency: itemCurrency,
      onTap: onTap,
      animation: animation,
      animationController: animationController,
      isSelected: isSelected,
    );
  }
}