import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../../vendor_ui/item/entry/component/entry_data/widgets/pick_on_map_widget.dart';

class CustomPickOnMapWidget extends StatelessWidget {
  const CustomPickOnMapWidget({required this.latLng, required this.updateMap});
  final LatLng latLng;
  final Function updateMap;
  
  @override
  Widget build(BuildContext context) {
    return PickOnMapWidget(latLng: latLng, updateMap: updateMap);
  }
}
