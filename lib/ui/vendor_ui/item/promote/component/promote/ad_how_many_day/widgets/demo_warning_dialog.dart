import 'package:flutter/material.dart';

import '../../../../../../common/dialog/demo_warning_dialog.dart';

dynamic callDemoWarningDialog(BuildContext context) async {
  await showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return const DemoWarningDialog();
      });
}