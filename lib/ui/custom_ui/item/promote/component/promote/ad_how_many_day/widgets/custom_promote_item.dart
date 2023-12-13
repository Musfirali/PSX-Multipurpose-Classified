import 'package:flutter/material.dart';

import '../../../../../../../vendor_ui/item/promote/component/promote/ad_how_many_day/widgets/custom_promote_item.dart';

class CustomCustomPromoteItem extends StatefulWidget {
  const CustomCustomPromoteItem(
      {required this.onTap,
      required this.getEnterDateCountController});

  final Function onTap;
  final TextEditingController getEnterDateCountController;
  
  @override
  State<StatefulWidget> createState() => _CustomPromoteItemState();
}

class _CustomPromoteItemState extends State<CustomCustomPromoteItem> {
  @override
  Widget build(BuildContext context) {
    return CustomPromoteItem(
      getEnterDateCountController: widget.getEnterDateCountController,
      onTap: widget.onTap,
    );
  }
}
