import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/entry/view/video_view_online_view.dart';

class CustomPlayerVideoOnlineView extends StatefulWidget {
  const CustomPlayerVideoOnlineView(this.videoPath);
  final String videoPath;

  @override
  PlayerVideoAndPopPageState createState() => PlayerVideoAndPopPageState();
}

class PlayerVideoAndPopPageState extends State<CustomPlayerVideoOnlineView> {
  @override
  Widget build(BuildContext context) {
    return PlayerVideoOnlineView(widget.videoPath);
  }
}
