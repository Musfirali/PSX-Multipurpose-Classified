import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psxmpc/config/ps_colors.dart';

import '../../../../../../../config/route/route_paths.dart';
import '../../../../../../../core/vendor/constant/ps_dimens.dart';
import '../../../../../../../core/vendor/provider/entry/item_entry_provider.dart';
import '../../../../../common/ps_button_widget.dart';

class VideoPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: PSButtonWithIconWidget(
        icon: Icons.play_circle_outline_outlined,
        iconColor: Theme.of(context).primaryColor,
        colorData: PsColors.achromatic800,
        width: PsDimens.space48,
        height: PsDimens.space48,
      ),
      onTap: () {
        onPlayButtonClick(context);
      },
    );
  }

  void onPlayButtonClick(BuildContext context) {
    final ItemEntryProvider itemEntryProvider =
        Provider.of<ItemEntryProvider>(context, listen: false);
    if (itemEntryProvider.hasOfflineVideoToUpload(-1)) {
      Navigator.pushNamed(context, RoutePaths.video,
          arguments: itemEntryProvider.newVideoFilePath!);
    } else {
      Navigator.pushNamed(context, RoutePaths.video_online,
          arguments: itemEntryProvider.item?.video?.imgPath);
    }
  }
}
