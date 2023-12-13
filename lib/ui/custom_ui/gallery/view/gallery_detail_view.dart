import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/default_photo.dart';
import '../../../vendor_ui/gallery/view/gallery_detail_view.dart';

class CustomGalleryView extends StatefulWidget {
  const CustomGalleryView({
    Key? key,
    required this.selectedDefaultImage,
  }) : super(key: key);

  final DefaultPhoto selectedDefaultImage;

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<CustomGalleryView> {
  @override
  Widget build(BuildContext context) {
    return GalleryView(selectedDefaultImage: widget.selectedDefaultImage);
  }
}
