import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/delete_upladed_image_icon.dart';

class CustomDeleteUploaedImageIcon extends StatelessWidget {
  const CustomDeleteUploaedImageIcon(
      {required this.alreadyUploadedImage, required this.onDeleteItemImage});
  final DefaultPhoto alreadyUploadedImage;
  final Function onDeleteItemImage;
  
  @override
  Widget build(BuildContext context) {
    return DeleteUploaedImageIcon(
        alreadyUploadedImage: alreadyUploadedImage,
        onDeleteItemImage: onDeleteItemImage);
  }
}
