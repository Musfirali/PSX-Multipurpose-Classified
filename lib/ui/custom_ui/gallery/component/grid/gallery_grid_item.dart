import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../vendor_ui/gallery/component/grid/gallery_grid_item.dart';

class CustomGalleryGridItem extends StatelessWidget {
  const CustomGalleryGridItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  final DefaultPhoto image;

  @override
  Widget build(BuildContext context) {
    return GalleryGridItem(
      image: image,
    );
  }
}
