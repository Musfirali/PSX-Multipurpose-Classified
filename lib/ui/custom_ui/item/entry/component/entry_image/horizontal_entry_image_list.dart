import 'package:flutter/material.dart';

import '../../../../../vendor_ui/item/entry/component/entry_image/horizontal_entry_image_list.dart';

class CustomImageUploadHorizontalList extends StatefulWidget {
  const CustomImageUploadHorizontalList({
    required this.addNewItem,
    required this.maxImageCount,
  });
  final String? addNewItem;
  final int maxImageCount;

  @override
  ImageUploadHorizontalListState createState() =>
      ImageUploadHorizontalListState();
}

class ImageUploadHorizontalListState
    extends State<CustomImageUploadHorizontalList> {
  @override
  Widget build(BuildContext context) {
    return ImageUploadHorizontalList(
        addNewItem: widget.addNewItem, maxImageCount: widget.maxImageCount);
  }
}
