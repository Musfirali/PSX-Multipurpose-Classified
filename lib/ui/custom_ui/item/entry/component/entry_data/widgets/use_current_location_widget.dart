import 'package:flutter/material.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/use_current_location_widget.dart';

class CustomUseCurrentLocationWidget extends StatefulWidget {
  const CustomUseCurrentLocationWidget({
    Key? key,
    /// If set, enable the FusedLocationProvider on Android
    required this.androidFusedLocation,
    required this.updateMap,
  }) : super(key: key);

  final bool androidFusedLocation;
  final Function updateMap;

  @override
  UseCurrentLocationWidgetState<CustomUseCurrentLocationWidget> createState() =>
      UseCurrentLocationWidgetState<CustomUseCurrentLocationWidget>();
}

class UseCurrentLocationWidgetState<T extends CustomUseCurrentLocationWidget>
    extends State<CustomUseCurrentLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return UseCurrentLocationWidget(
        androidFusedLocation: widget.androidFusedLocation,
        updateMap: widget.updateMap);
  }
}
