import 'package:flutter/material.dart';

import '../../../../vendor_ui/item/entry/view/video_view.dart';

class CustomPlayerVideoView extends StatefulWidget {
  const CustomPlayerVideoView(this.videoPath);
  final String videoPath;
  
  @override
  PlayerVideoAndPopPageState createState() => PlayerVideoAndPopPageState();
}

class PlayerVideoAndPopPageState extends State<CustomPlayerVideoView> {
  @override
  Widget build(BuildContext context) {
    return PlayerVideoView(widget.videoPath);
  }
}
