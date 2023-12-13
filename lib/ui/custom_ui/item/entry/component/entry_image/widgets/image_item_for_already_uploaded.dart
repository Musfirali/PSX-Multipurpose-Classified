import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/image_item_for_already_uploaded.dart';

class CustomAlreadyUploadedImageItem extends StatelessWidget {
  const CustomAlreadyUploadedImageItem(
      {required this.index, required this.onDeleteItemImage});
  final int index;
  final Function onDeleteItemImage;
  @override
  Widget build(BuildContext context) {
    return AlreadyUploadedImageItem(
        index: index, onDeleteItemImage: onDeleteItemImage);
  }
}
