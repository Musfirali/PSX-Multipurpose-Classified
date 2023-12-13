import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:psxmpc/ui/vendor_ui/item/entry/component/entry_data/widgets/map_for_flutter.dart';

class CustomMapForFlutter extends StatelessWidget {
  const CustomMapForFlutter(
      {required this.flutterMapController,
      required this.latLng,
      required this.zoom,
      required this.updateFlutterMap,
      required this.currentPosition,
      required this.addressCurrentLocation,
      //required this.itemEntryProvider
      });
  final MapController flutterMapController;
  final LatLng latLng;
  final double zoom;
  final Function updateFlutterMap;
  final Position? currentPosition;
  final String? addressCurrentLocation;
 // final ItemEntryProvider? itemEntryProvider;
  @override
  Widget build(BuildContext context) {
    return MapForFlutter(
        flutterMapController: flutterMapController,
        latLng: latLng,
        zoom: zoom,
        updateFlutterMap: updateFlutterMap,
        addressCurrentLocation: addressCurrentLocation,
      //  itemEntryProvider: itemEntryProvider,
        currentPosition: currentPosition,);
  }
}
