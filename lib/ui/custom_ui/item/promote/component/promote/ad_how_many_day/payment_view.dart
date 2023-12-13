import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/provider/app_info/app_info_provider.dart';
import '../../../../../../../core/vendor/provider/promotion/item_promotion_provider.dart';
import '../../../../../../../core/vendor/provider/user/user_provider.dart';
import '../../../../../../../core/vendor/viewobject/product.dart';
import '../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/payment_view.dart';


class CustomPaymemtView extends StatefulWidget {
  const CustomPaymemtView({Key? key, required this.product,
  required this.date,required this.day,required this.amount,required this.time,required this.appInfoProvider,required this.itemPaidHistoryProvider,required this.userProvider
  }) : super(key: key);

  final Product product;
  final DateTime time;
  final String date;
  final String amount;
  final String day;
  final AppInfoProvider? appInfoProvider;
  final ItemPromotionProvider itemPaidHistoryProvider;
  final UserProvider? userProvider;

  @override
  _CustomItemPromoteViewState createState() => _CustomItemPromoteViewState();
}

class _CustomItemPromoteViewState extends State<CustomPaymemtView>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return PaymemtView(
      product: widget.product,
      time: widget.time,
      date: widget.date,
      amount: widget.amount,
      day: widget.day,
      appInfoProvider: widget.appInfoProvider,
      itemPaidHistoryProvider: widget.itemPaidHistoryProvider,
      userProvider: widget.userProvider,
    );
  }
}


