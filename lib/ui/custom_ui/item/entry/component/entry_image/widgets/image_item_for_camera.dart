import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/image_item_for_camera.dart';

class CustomCameraImageItem extends StatelessWidget {
  const CustomCameraImageItem(
      {required this.index, required this.onDeleteCameraImage});
  final int index;
  final Function onDeleteCameraImage;

  @override
  Widget build(BuildContext context) {
    return CameraImageItem(
      index: index,
      onDeleteCameraImage: onDeleteCameraImage,
    );
  }
}
