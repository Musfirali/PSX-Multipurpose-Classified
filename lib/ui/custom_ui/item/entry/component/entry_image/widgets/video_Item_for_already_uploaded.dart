import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/video_Item_for_already_uploaded.dart';

class CustomAlreadyUploadedVideo extends StatelessWidget {
  const CustomAlreadyUploadedVideo({required this.onVideoDelete});
  final Function onVideoDelete;
  
  @override
  Widget build(BuildContext context) {
    return AlreadyUploadedVideo(onVideoDelete: onVideoDelete);
  }
}
