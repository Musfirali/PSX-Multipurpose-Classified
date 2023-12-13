import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/paid_ad_item.dart';
import '../../../../../../vendor_ui/user/paid_item_list/component/horizontal/widgets/paid_ad_item_horizontal_list_item.dart';

class CustomPaidAdItemHorizontalListItem extends StatelessWidget {
  const CustomPaidAdItemHorizontalListItem({
    Key? key,
    required this.paidAdItem,
    required this.tagKey,
  }) : super(key: key);

  final PaidAdItem paidAdItem;
  final String tagKey;

  @override
  Widget build(BuildContext context) {
    return PaidAdItemHorizontalListItem(paidAdItem: paidAdItem, tagKey: tagKey);
  }
}
