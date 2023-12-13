import 'package:flutter/material.dart';

import '../../../vendor_ui/introslider/component/not_show_again_widget.dart';

class CustomNotShowAgainWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotShowAgainWidgetState();
}

class _NotShowAgainWidgetState extends State<CustomNotShowAgainWidget> {
  @override
  Widget build(BuildContext context) {
    return NotShowAgainWidget();
  }
}
