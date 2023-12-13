import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/vendor/constant/ps_constants.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../../custom_ui/item/entry/component/entry_image/widgets/delete_video_icon.dart';
import '../../../../../common/ps_ui_widget.dart';

class AlreadyUploadedVideo extends StatelessWidget {
  const AlreadyUploadedVideo({required this.onVideoDelete});
  final Function onVideoDelete;
  @override
  Widget build(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context);
    return Stack(
      children: <Widget>[
        PsNetworkImageWithUrl(
          photoKey: '',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          imageAspectRation: PsConst.Aspect_Ratio_1x,
          imagePath: itemEntryProvider.getAlreadyUploadedVideoThumbnail,
        ),
        Positioned(
          child: CustomDeleteVideoIcon(
            video: itemEntryProvider.item!.video!,
            videoThumbnail: itemEntryProvider.item!.videoThumbnail!,
            onVideoItemDelete: onVideoDelete,
          ),
          right: 1,
          top: 1,
        ),
      ],
    );
  }
}
