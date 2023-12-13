import 'package:flutter/material.dart';

import '../../../../../vendor_ui/dashboard/components/bottom_nav/widgets/chat_nav_item.dart';


class CustomChatIconWithUnreadCount extends StatefulWidget {
  const CustomChatIconWithUnreadCount(
      {required this.updateSelectedIndexWithAnimation});
  final Function updateSelectedIndexWithAnimation;
  @override
  State<StatefulWidget> createState() => _ChatIconWithUnreadCountState();
}

class _ChatIconWithUnreadCountState
    extends State<CustomChatIconWithUnreadCount> {
      
  @override
  Widget build(BuildContext context) {
    return ChatIconWithUnreadCount(
        updateSelectedIndexWithAnimation:
            widget.updateSelectedIndexWithAnimation);
  }
}
