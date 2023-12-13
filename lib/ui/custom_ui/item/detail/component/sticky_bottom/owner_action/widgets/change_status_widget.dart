import 'package:flutter/material.dart';

import '../../../../../../../vendor_ui/item/detail/component/sticky_bottom/owner_action/widgets/change_status_widget.dart';

class CustomChangeStatusWidget extends StatefulWidget {
  @override
  ChangeStatusWidgetState<CustomChangeStatusWidget> createState() =>
      ChangeStatusWidgetState<CustomChangeStatusWidget>();
}

class ChangeStatusWidgetState<T extends CustomChangeStatusWidget>
    extends State<CustomChangeStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeStatusWidget();
  }
}
