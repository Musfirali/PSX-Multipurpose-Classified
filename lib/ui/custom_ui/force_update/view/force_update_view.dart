import 'package:flutter/material.dart';

import '../../../../core/vendor/viewobject/holder/intent_holder/version_update_intent_holder.dart';
import '../../../vendor_ui/force_update/view/force_update_view.dart';

class CustomForceUpdateView extends StatelessWidget {
  const CustomForceUpdateView({required this.version});
  final VersionIntentHolder version;

  @override
  Widget build(BuildContext context) {
    return ForceUpdateView(version: version);
  }
}
