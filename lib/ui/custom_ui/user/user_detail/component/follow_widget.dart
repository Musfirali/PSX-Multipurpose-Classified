import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/user_detail/component/follow_widget.dart';

class CustomFollowWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<CustomFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return FollowWidget();
  }
}
