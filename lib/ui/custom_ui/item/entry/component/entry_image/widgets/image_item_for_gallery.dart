import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/image_item_for_gallery.dart';

class CustomGalleryImageItem extends StatelessWidget {
  const CustomGalleryImageItem(
      {required this.index, 
      required this.onDeleteGalleryImage});
  final int index;
  final Function onDeleteGalleryImage;

  @override
  Widget build(BuildContext context) {
    return GalleryImageItem(
        index: index, onDeleteGalleryImage: onDeleteGalleryImage);
  }
}
