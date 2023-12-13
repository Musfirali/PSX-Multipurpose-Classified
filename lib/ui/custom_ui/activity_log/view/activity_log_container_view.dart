import 'package:flutter/material.dart';

import '../../../vendor_ui/activity_log/view/activity_log_container_view.dart';

class CustomActivityLogContainerView extends StatefulWidget {
  @override
  _CustomActivityLogContainerViewState createState() => _CustomActivityLogContainerViewState();
}

class _CustomActivityLogContainerViewState extends State<CustomActivityLogContainerView>
    with SingleTickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
  
    return ActivityLogContainerView ();
    
  }
}
