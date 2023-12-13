import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/horizontal_entry_image_item.dart';

class CustomHorizontalEntryImageItem extends StatefulWidget {
  const CustomHorizontalEntryImageItem(
      {Key? key,
      required this.index,
      required this.addNewItem,
      required this.onTap})
      : super(key: key);

  final int index;
  final String addNewItem;
  final Function onTap;
  @override
  State<StatefulWidget> createState() {
    return HorizontalEntryImageItemState();
  }
}

class HorizontalEntryImageItemState extends State<CustomHorizontalEntryImageItem> {
  @override
  Widget build(BuildContext context) {
    return HorizontalEntryImageItem(
        index: widget.index,
        addNewItem: widget.addNewItem,
        onTap: widget.onTap);
  }
}
