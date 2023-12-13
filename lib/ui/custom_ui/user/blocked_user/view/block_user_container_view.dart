import 'package:flutter/material.dart';

import '../../../../vendor_ui/user/blocked_user/view/block_user_container_view.dart';

class CustomBlockUserContainerView extends StatefulWidget {
  @override
  _BlockUserContainerViewState createState() => _BlockUserContainerViewState();
}

class _BlockUserContainerViewState extends State<CustomBlockUserContainerView> {
  @override
  Widget build(BuildContext context) {
    return BlockUserContainerView();
  }
}
