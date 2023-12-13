import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/product.dart';
import '../../../vendor_ui/gallery/view/gallery_grid_view.dart';

class CustomGalleryGridView extends StatefulWidget {
  const CustomGalleryGridView({
    Key? key,
    required this.product,
    this.onImageTap,
  }) : super(key: key);

  final Product product;
  final Function? onImageTap;
  @override
  _GalleryGridViewState createState() => _GalleryGridViewState();
}

class _GalleryGridViewState extends State<CustomGalleryGridView> {
  @override
  Widget build(BuildContext context) {
    return GalleryGridView(
      product: widget.product,
      onImageTap: widget.onImageTap,
    );
  }
}
