import 'package:flutter/material.dart';

import '../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../core/vendor/viewobject/product.dart';
import '../../../../vendor_ui/gallery/component/grid/gallery_grid_item_for_video.dart';

class CustomGalleryGridItemForVideo extends StatefulWidget {
  const CustomGalleryGridItemForVideo({
    Key? key,
    required this.image,
    required this.product,
  }) : super(key: key);

  final DefaultPhoto? image;
  final Product? product;

  @override
  _GalleryGridItemForVideoState createState() =>
      _GalleryGridItemForVideoState();
}

class _GalleryGridItemForVideoState
    extends State<CustomGalleryGridItemForVideo> {
  @override
  Widget build(BuildContext context) {
    return GalleryGridItemForVideo(
      image: widget.image,
      product: widget.product,
    );
  }
}
