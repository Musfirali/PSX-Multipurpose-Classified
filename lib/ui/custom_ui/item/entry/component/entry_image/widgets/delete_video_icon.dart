import 'package:flutter/material.dart';

import '../../../../../../../core/vendor/viewobject/default_photo.dart';
import '../../../../../../vendor_ui/item/entry/component/entry_image/widgets/delete_video_icon.dart';

class CustomDeleteVideoIcon extends StatelessWidget {
  const CustomDeleteVideoIcon(
      {required this.video,
      required this.videoThumbnail,
      required this.onVideoItemDelete});
  final DefaultPhoto video;
  final DefaultPhoto videoThumbnail;
  final Function onVideoItemDelete;
  
  @override
  Widget build(BuildContext context) {
    return DeleteVideoIcon(
        video: video,
        videoThumbnail: videoThumbnail,
        onVideoItemDelete: onVideoItemDelete);
  }
}
