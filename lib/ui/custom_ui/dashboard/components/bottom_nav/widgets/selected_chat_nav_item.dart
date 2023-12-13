import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/bottom_nav/widgets/selected_chat_nav_item.dart';

class CustomSelectedChatIconWithUnreadCount extends StatefulWidget {
  const CustomSelectedChatIconWithUnreadCount(
      {required this.updateSelectedIndexWithAnimation});
  final Function updateSelectedIndexWithAnimation;
  @override
  State<StatefulWidget> createState() => _ChatIconWithUnreadCountState();
}

class _ChatIconWithUnreadCountState
    extends State<CustomSelectedChatIconWithUnreadCount> {
  @override
  Widget build(BuildContext context) {
    return SelectedChatIconWithUnreadCount(
        updateSelectedIndexWithAnimation:
            widget.updateSelectedIndexWithAnimation);
  }
}
